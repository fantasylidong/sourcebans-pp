{assign var=source_summary value=$sourcebans_summary}
{assign var=l4d value=$l4d_stats}

<div class="dashboard-wrapper">
  <section class="dashboard-hero layout_box">
    <div class="dashboard-hero__content">
      {if $dashboard_intro.game}
        <span class="dashboard-hero__eyebrow">{$dashboard_intro.game}</span>
      {/if}
      <h1 class="dashboard-hero__title">{$dashboard_intro.headline|default:$dashboard_title|escape:'html'}</h1>
      {if $dashboard_intro.description}
        <div class="dashboard-hero__description">{$dashboard_intro.description nofilter}</div>
      {elseif $dashboard_text}
        <div class="dashboard-hero__description">{$dashboard_text nofilter}</div>
      {/if}
      <div class="dashboard-hero__actions">
        {if $dashboard_intro.stats_url}
          <a class="button button-light" href="{$dashboard_intro.stats_url}" target="_blank" rel="noopener">
            <i class="fa fa-chart-line"></i>
            查看完整统计
          </a>
        {/if}
        {if $dashboard_intro.steam_group}
          <a class="button button-success" href="{$dashboard_intro.steam_group}" target="_blank" rel="noopener">
            <i class="fab fa-steam"></i>
            Steam 群组
          </a>
        {/if}
      </div>
    </div>
  </section>

  <section class="dashboard-metrics">
    <article class="dashboard-metric layout_box">
      <span class="dashboard-metric__label">封禁总数</span>
      <strong class="dashboard-metric__value">{$source_summary.total_bans}</strong>
      <span class="dashboard-metric__hint">SourceBans 封禁数量</span>
    </article>
    <article class="dashboard-metric layout_box">
      <span class="dashboard-metric__label">通讯封锁</span>
      <strong class="dashboard-metric__value">{$source_summary.total_comms}</strong>
      <span class="dashboard-metric__hint">静音 / 禁言记录</span>
    </article>
    <article class="dashboard-metric layout_box">
      <span class="dashboard-metric__label">拦截尝试</span>
      <strong class="dashboard-metric__value">{$source_summary.total_blocked}</strong>
      <span class="dashboard-metric__hint">被系统拒绝的连接</span>
    </article>
    <article class="dashboard-metric layout_box">
      <span class="dashboard-metric__label">在线玩家</span>
      <strong class="dashboard-metric__value">{$l4d.summary.online_count}</strong>
      <span class="dashboard-metric__hint">L4D 当前在线 ({$l4d.summary.total_players} 总玩家)</span>
    </article>
  </section>

  <div class="dashboard-grid">
    <section class="dashboard-card layout_box">
      <div class="dashboard-card__header">
        <div>
          <h2 class="dashboard-card__title">最新封禁</h2>
          <span class="dashboard-card__subtitle">最近 10 条封禁记录</span>
        </div>
        <a class="dashboard-card__link" href="index.php?p=banlist">查看全部</a>
      </div>
      <div class="dashboard-card__body">
        <div class="dashboard-table">
          <table>
            <thead>
              <tr>
                <th>模组</th>
                <th class="text:left">玩家</th>
                <th class="text:left">封禁时间</th>
                <th>时长</th>
              </tr>
            </thead>
            <tbody>
              {foreach from=$players_banned item=player}
                <tr onclick="{$player.link_url}" class="collapse">
                  <td class="text:center">
                    <img src="images/games/{$player.icon}" alt="{$player.icon}" />
                  </td>
                  <td>
                    {if empty($player.short_name)}
                      <span class="text:italic">无昵称</span>
                    {else}
                      <span>{$player.short_name|escape:'html'}</span>
                    {/if}
                  </td>
                  <td>{$player.created}</td>
                  <td class="dashboard-ban-length{if $player.unbanned} dashboard-ban-length--unbanned{elseif $player.perm} dashboard-ban-length--permanent{elseif $player.temp} dashboard-ban-length--temporary{/if}">
                    {$player.length}{if $player.unbanned} ({$player.ub_reason}){/if}
                  </td>
                </tr>
              {/foreach}
            </tbody>
          </table>
        </div>
      </div>
    </section>

    <section class="dashboard-card layout_box">
      <div class="dashboard-card__header">
        <div>
          <h2 class="dashboard-card__title">当前在线玩家</h2>
          <span class="dashboard-card__subtitle">最近五分钟的活跃玩家</span>
        </div>
        {if $l4d.site.stats_url}
          <a class="dashboard-card__link" href="{$l4d.site.stats_url}" target="_blank" rel="noopener">详细统计</a>
        {/if}
      </div>
      <div class="dashboard-card__body">
        {if $l4d.available && $l4d.online_players|@count > 0}
          <div class="dashboard-table">
            <table>
              <thead>
                <tr>
                  <th class="text:left">玩家</th>
                  <th>模式</th>
                  <th>积分</th>
                  <th>游戏时长</th>
                </tr>
              </thead>
              <tbody>
                {foreach from=$l4d.online_players item=player}
                  <tr>
                    <td class="text:left">
                      {if $player.profile_url}
                        <a href="{$player.profile_url}" target="_blank" rel="noopener">{$player.name|escape:'html'}</a>
                      {else}
                        {$player.name|escape:'html'}
                      {/if}
                    </td>
                    <td class="text:center">{$player.mode}</td>
                    <td class="text:center">{$player.points}</td>
                    <td class="text:center">{$player.playtime}</td>
                  </tr>
                {/foreach}
              </tbody>
            </table>
          </div>
        {elseif $l4d.available}
          <div class="dashboard-empty">当前没有玩家在线。</div>
        {else}
          <div class="dashboard-empty">{$l4d.error|default:'暂时无法获取统计数据。'}</div>
        {/if}
      </div>
    </section>
  </div>

  <div class="dashboard-grid">
    <section class="dashboard-card layout_box">
      <div class="dashboard-card__header">
        <div>
          <h2 class="dashboard-card__title">顶尖玩家</h2>
          <span class="dashboard-card__subtitle">积分最高的 5 位玩家</span>
        </div>
        {if $l4d.site.steam_group}
          <a class="dashboard-card__link" href="{$l4d.site.steam_group}" target="_blank" rel="noopener">社区</a>
        {/if}
      </div>
      <div class="dashboard-card__body">
        {if $l4d.available && $l4d.top_players|@count > 0}
          <ul class="dashboard-list">
            {foreach from=$l4d.top_players item=player name=topLoop}
              <li>
                <div class="dashboard-list__rank">#{$smarty.foreach.topLoop.iteration}</div>
                <div class="dashboard-list__details">
                  <span class="dashboard-list__name">
                    {if $player.profile_url}
                      <a href="{$player.profile_url}" target="_blank" rel="noopener">{$player.name|escape:'html'}</a>
                    {else}
                      {$player.name|escape:'html'}
                    {/if}
                  </span>
                  <span class="dashboard-list__meta">积分 {$player.points} · 总时长 {$player.playtime}</span>
                </div>
              </li>
            {/foreach}
          </ul>
        {elseif $l4d.available}
          <div class="dashboard-empty">暂无排行榜数据。</div>
        {else}
          <div class="dashboard-empty">{$l4d.error|default:'暂时无法获取统计数据。'}</div>
        {/if}
      </div>
    </section>

    <section class="dashboard-card layout_box">
      <div class="dashboard-card__header">
        <div>
          <h2 class="dashboard-card__title">最新通讯封锁</h2>
          <span class="dashboard-card__subtitle">最近 10 条禁言 / 静音</span>
        </div>
        <a class="dashboard-card__link" href="index.php?p=commslist">查看全部</a>
      </div>
      <div class="dashboard-card__body">
        <div class="dashboard-table">
          <table>
            <thead>
              <tr>
                <th>类型</th>
                <th class="text:left">玩家</th>
                <th class="text:left">时间</th>
                <th>时长</th>
              </tr>
            </thead>
            <tbody>
              {foreach from=$players_commed item=player}
                <tr onclick="{$player.link_url}" class="collapse">
                  <td class="text:center"><i class="{$player.type}"></i></td>
                  <td>
                    {if empty($player.short_name)}
                      <span class="text:italic">无昵称</span>
                    {else}
                      <span>{$player.short_name|escape:'html'}</span>
                    {/if}
                  </td>
                  <td>{$player.created}</td>
                  <td class="dashboard-ban-length{if $player.unbanned} dashboard-ban-length--unbanned{elseif $player.perm} dashboard-ban-length--permanent{elseif $player.temp} dashboard-ban-length--temporary{/if}">
                    {$player.length}{if $player.unbanned} ({$player.ub_reason}){/if}
                  </td>
                </tr>
              {/foreach}
            </tbody>
          </table>
        </div>
      </div>
    </section>
  </div>

  <section class="dashboard-card layout_box">
    <div class="dashboard-card__header">
      <div>
        <h2 class="dashboard-card__title">服务器状态</h2>
        <span class="dashboard-card__subtitle">实时服务器在线情况</span>
      </div>
      <a class="dashboard-card__link" href="index.php?p=servers">所有服务器</a>
    </div>
    <div class="dashboard-card__body">
      {include file='page_servers.tpl'}
    </div>
  </section>
</div>
