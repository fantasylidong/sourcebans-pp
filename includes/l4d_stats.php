<?php
/**
 * Helper functions to read Left 4 Dead statistics and expose them to the
 * SourceBans++ dashboard.
 */

declare(strict_types=1);

/**
 * Load the configuration from the legacy l4d_stats package without leaking
 * variables into the global scope.
 */
function sbpp_load_l4d_stats_config(): ?array
{
    $configPath = ROOT . 'l4d_stats/_source/_config.php';
    if (!file_exists($configPath)) {
        return null;
    }

    $config = (static function (string $path) {
        include $path;

        return [
            'mysql_server'      => $mysql_server ?? null,
            'mysql_db'          => $mysql_db ?? null,
            'mysql_user'        => $mysql_user ?? null,
            'mysql_password'    => $mysql_password ?? null,
            'mysql_tableprefix' => $mysql_tableprefix ?? '',
            'site_name'         => $site_name ?? null,
            'site_description'  => $site_description ?? null,
            'site_welcome'      => $site_welcome ?? null,
            'site_statsurl'     => $site_statsurl ?? null,
            'site_game'         => $site_game ?? null,
            'site_steamgroup'   => $site_steamgroup ?? null,
            'game_version'      => isset($game_version) ? (int) $game_version : 0,
        ];
    })($configPath);

    if (empty($config['mysql_server']) || empty($config['mysql_db']) || empty($config['mysql_user'])) {
        return null;
    }

    return $config;
}

/**
 * Create a mysqli connection using the extracted configuration.
 */
function sbpp_open_l4d_stats_connection(array $config): ?mysqli
{
    mysqli_report(MYSQLI_REPORT_OFF);

    $connection = @new mysqli(
        $config['mysql_server'],
        $config['mysql_user'],
        $config['mysql_password'],
        $config['mysql_db']
    );

    if ($connection->connect_errno) {
        return null;
    }

    $connection->set_charset('utf8mb4');

    return $connection;
}

function sbpp_l4d_table_name(string $prefix, string $name): string
{
    return sprintf('`%s%s`', $prefix, $name);
}

function sbpp_l4d_points_columns(int $gameVersion): array
{
    $base = ['points', 'points_survivors', 'points_infected', 'points_survival'];

    if ($gameVersion !== 1) {
        $base = array_merge($base, [
            'points_realism',
            'points_realism_survivors',
            'points_realism_infected',
            'points_realismversus',
            'points_scavenge_survivors',
            'points_scavenge_infected',
            'points_mutations',
        ]);
    }

    return $base;
}

function sbpp_l4d_playtime_columns(int $gameVersion): array
{
    $base = ['playtime', 'playtime_versus', 'playtime_survival'];

    if ($gameVersion !== 1) {
        $base = array_merge($base, [
            'playtime_realism',
            'playtime_realismversus',
            'playtime_scavenge',
            'playtime_mutations',
        ]);
    }

    return $base;
}

function sbpp_l4d_sum_expression(array $columns): string
{
    $parts = array_map(static fn ($column) => sprintf('COALESCE(`%s`, 0)', $column), $columns);

    return implode(' + ', $parts);
}

function sbpp_l4d_minutes_to_readable(int $minutes): string
{
    $hours = intdiv($minutes, 60);
    $remainingMinutes = $minutes % 60;

    if ($hours <= 0) {
        return sprintf('%d 分钟', $remainingMinutes);
    }

    if ($remainingMinutes === 0) {
        return sprintf('%d 小时', $hours);
    }

    return sprintf('%d 小时 %d 分钟', $hours, $remainingMinutes);
}

function sbpp_l4d_to_community_id(?string $steamId): ?string
{
    if ($steamId === null || $steamId === '') {
        return null;
    }

    if (preg_match('/^\d{17}$/', $steamId)) {
        return $steamId;
    }

    if (!preg_match('/^STEAM_([0-5]):([0-1]):(\d+)$/', $steamId, $matches)) {
        return null;
    }

    $y = (int) $matches[2];
    $z = (int) $matches[3];

    return (string) ($z * 2 + $y + 76561197960265728);
}

/**
 * Fetch aggregated data required for the dashboard. Returns a structured array
 * that the Smarty template can consume directly.
 */
function sbpp_fetch_l4d_stats(): array
{
    $defaults = [
        'available' => false,
        'error' => null,
        'summary' => [
            'total_players' => 0,
            'online_count' => 0,
            'total_points' => 0,
            'total_playtime_hours' => 0.0,
        ],
        'online_players' => [],
        'top_players' => [],
        'site' => [
            'name' => null,
            'description' => null,
            'welcome' => null,
            'game' => null,
            'steam_group' => null,
            'stats_url' => null,
        ],
    ];

    $config = sbpp_load_l4d_stats_config();
    if ($config === null) {
        $defaults['error'] = '统计配置不存在。';

        return $defaults;
    }

    $connection = sbpp_open_l4d_stats_connection($config);
    if ($connection === null) {
        $defaults['error'] = '无法连接至 L4D 统计数据库。';
        $defaults['site'] = [
            'name' => $config['site_name'] ?? null,
            'description' => $config['site_description'] ?? null,
            'welcome' => $config['site_welcome'] ?? null,
            'game' => $config['site_game'] ?? null,
            'steam_group' => $config['site_steamgroup'] ?? null,
            'stats_url' => $config['site_statsurl'] ?? null,
        ];

        return $defaults;
    }

    $prefix = $config['mysql_tableprefix'] ?? '';
    $playersTable = sbpp_l4d_table_name($prefix, 'players');
    $gameVersion = $config['game_version'] ?? 0;

    $pointColumns = sbpp_l4d_points_columns($gameVersion);
    $playtimeColumns = sbpp_l4d_playtime_columns($gameVersion);

    $selectParts = ['COUNT(*) AS total_players'];
    foreach ($pointColumns as $column) {
        $selectParts[] = sprintf('SUM(COALESCE(`%s`, 0)) AS `%s`', $column, $column);
    }
    foreach ($playtimeColumns as $column) {
        $selectParts[] = sprintf('SUM(COALESCE(`%s`, 0)) AS `%s`', $column, $column);
    }

    $summarySql = sprintf('SELECT %s FROM %s', implode(', ', $selectParts), $playersTable);
    $summaryRow = $connection->query($summarySql)?->fetch_assoc() ?: [];

    $totalPoints = 0;
    foreach ($pointColumns as $column) {
        $totalPoints += (int) ($summaryRow[$column] ?? 0);
    }

    $totalMinutes = 0;
    foreach ($playtimeColumns as $column) {
        $totalMinutes += (int) ($summaryRow[$column] ?? 0);
    }

    $onlineThreshold = time() - 300;
    $pointsExpression = sbpp_l4d_sum_expression($pointColumns);
    $playtimeExpression = sbpp_l4d_sum_expression($playtimeColumns);

    $onlineSql = sprintf(
        'SELECT `name`, `steamid`, `lastontime`, `lastgamemode`, %s AS total_points, %s AS total_playtime '
        . 'FROM %s WHERE `lastontime` >= %d ORDER BY total_points DESC LIMIT 10',
        $pointsExpression,
        $playtimeExpression,
        $playersTable,
        $onlineThreshold
    );
    $onlinePlayers = [];
    if ($result = $connection->query($onlineSql)) {
        while ($row = $result->fetch_assoc()) {
            $communityId = sbpp_l4d_to_community_id($row['steamid'] ?? null);
            $onlinePlayers[] = [
                'name' => $row['name'] ?? '未知玩家',
                'steamid' => $row['steamid'] ?? null,
                'community_id' => $communityId,
                'profile_url' => $communityId ? 'https://steamcommunity.com/profiles/' . $communityId : null,
                'last_seen' => (int) ($row['lastontime'] ?? 0),
                'mode' => (int) ($row['lastgamemode'] ?? -1),
                'points' => (int) ($row['total_points'] ?? 0),
                'playtime_minutes' => (int) ($row['total_playtime'] ?? 0),
            ];
        }
        $result->free();
    }

    $topSql = sprintf(
        'SELECT `name`, `steamid`, %s AS total_points, %s AS total_playtime '
        . 'FROM %s ORDER BY total_points DESC LIMIT 5',
        $pointsExpression,
        $playtimeExpression,
        $playersTable
    );
    $topPlayers = [];
    if ($result = $connection->query($topSql)) {
        while ($row = $result->fetch_assoc()) {
            $communityId = sbpp_l4d_to_community_id($row['steamid'] ?? null);
            $topPlayers[] = [
                'name' => $row['name'] ?? '未知玩家',
                'steamid' => $row['steamid'] ?? null,
                'community_id' => $communityId,
                'profile_url' => $communityId ? 'https://steamcommunity.com/profiles/' . $communityId : null,
                'points' => (int) ($row['total_points'] ?? 0),
                'playtime_minutes' => (int) ($row['total_playtime'] ?? 0),
            ];
        }
        $result->free();
    }

    $connection->close();

    $defaults['available'] = true;
    $defaults['summary'] = [
        'total_players' => (int) ($summaryRow['total_players'] ?? 0),
        'online_count' => count($onlinePlayers),
        'total_points' => $totalPoints,
        'total_playtime_hours' => $totalMinutes > 0 ? round($totalMinutes / 60, 1) : 0.0,
    ];
    $defaults['online_players'] = array_map(static function (array $player) {
        $gamemodeMap = [
            0 => '战役',
            1 => '对抗',
            2 => '写实',
            3 => '生存',
            4 => '清道夫',
            5 => '写实对抗',
            6 => '突变模式',
        ];

        $mode = $gamemodeMap[$player['mode']] ?? '未知模式';

        return [
            'name' => $player['name'],
            'steamid' => $player['steamid'],
            'profile_url' => $player['profile_url'],
            'points' => number_format($player['points']),
            'playtime' => sbpp_l4d_minutes_to_readable($player['playtime_minutes']),
            'mode' => $mode,
            'last_seen' => $player['last_seen'],
        ];
    }, $onlinePlayers);

    $defaults['top_players'] = array_map(static function (array $player) {
        return [
            'name' => $player['name'],
            'steamid' => $player['steamid'],
            'profile_url' => $player['profile_url'],
            'points' => number_format($player['points']),
            'playtime' => sbpp_l4d_minutes_to_readable($player['playtime_minutes']),
        ];
    }, $topPlayers);

    $defaults['site'] = [
        'name' => $config['site_name'] ?? null,
        'description' => $config['site_description'] ?? null,
        'welcome' => $config['site_welcome'] ?? null,
        'game' => $config['site_game'] ?? null,
        'steam_group' => $config['site_steamgroup'] ?? null,
        'stats_url' => $config['site_statsurl'] ?? null,
    ];

    return $defaults;
}
