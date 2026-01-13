- dashboard: standings
  title: "League Home Page"
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Summary of the 2025 Season"

  filters:
    - name: season
      title: "Season"
      type: field_filter
      default_value: ""
      allow_multiple_values: false
      required: false
      ui_config:
        type: dropdown_menu
        display: inline
      explore: standings
      field: standings.season

    - name: league
      title: "League"
      type: field_filter
      default_value: ""
      allow_multiple_values: false
      required: false
      ui_config:
        type: dropdown_menu
        display: inline
      explore: standings
      field: standings.league_key

  elements:
    # Top Banner - Podium styled like Yahoo
    - title: ""
      name: podium_banner
      type: text
      title_text: ""
      subtitle_text: ""
      body_text: |
        <div style="display: flex; justify-content: space-around; align-items: center; background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%); padding: 20px; border-radius: 8px; margin-bottom: 10px;">
          <div style="text-align: center; flex: 1; border-right: 1px solid #374151;">
            <div style="font-size: 12px; color: #9CA3AF; text-transform: uppercase; margin-bottom: 5px;">🏆 1st Place</div>
            <div style="font-size: 18px; font-weight: bold; color: #FFD700;">Taylor Park Boys</div>
          </div>
          <div style="text-align: center; flex: 1; border-right: 1px solid #374151;">
            <div style="font-size: 12px; color: #9CA3AF; text-transform: uppercase; margin-bottom: 5px;">🥈 2nd Place</div>
            <div style="font-size: 18px; font-weight: bold; color: #C0C0C0;">Nacua Matata</div>
          </div>
          <div style="text-align: center; flex: 1;">
            <div style="font-size: 12px; color: #9CA3AF; text-transform: uppercase; margin-bottom: 5px;">🥉 3rd Place</div>
            <div style="font-size: 18px; font-weight: bold; color: #CD7F32;">McMayhem</div>
          </div>
        </div>
      row: 0
      col: 0
      width: 24
      height: 4

    # Playoff Bracket - Static HTML
    - title: ""
      name: playoff_bracket_html
      type: text
      title_text: "Playoff Bracket"
      subtitle_text: "Weeks 15-17"
      body_text: |
        <style>
          .bracket-container { display: flex; justify-content: space-between; font-family: -apple-system, sans-serif; font-size: 11px; }
          .round { flex: 1; padding: 0 5px; }
          .round-title { background: #1a1a2e; color: white; padding: 8px; text-align: center; border-radius: 4px; margin-bottom: 10px; font-weight: bold; }
          .matchup { background: #f8f9fa; border: 1px solid #e5e7eb; border-radius: 6px; margin-bottom: 8px; overflow: hidden; }
          .matchup-header { background: #e5e7eb; padding: 4px 8px; font-size: 10px; color: #6b7280; }
          .team { padding: 8px; border-bottom: 1px solid #e5e7eb; display: flex; justify-content: space-between; }
          .team:last-child { border-bottom: none; }
          .team.winner { background: #ecfdf5; }
          .team.loser { color: #9ca3af; text-decoration: line-through; }
          .score { font-weight: bold; }
        </style>
        <div class="bracket-container">
          <div class="round">
            <div class="round-title">Week 15: Quarterfinals</div>
            <div class="matchup">
              <div class="team winner"><span>Taylor Park Boys</span><span class="score">BYE</span></div>
            </div>
            <div class="matchup">
              <div class="team loser"><span>11 Men on grass</span><span class="score">102.24</span></div>
              <div class="team winner"><span>Bum Rushers</span><span class="score">110.52</span></div>
            </div>
            <div class="matchup">
              <div class="team winner"><span>McMayhem</span><span class="score">109.80</span></div>
              <div class="team loser"><span>Pierogi People Eater</span><span class="score">86.90</span></div>
            </div>
            <div class="matchup">
              <div class="team winner"><span>Nacua Matata</span><span class="score">BYE</span></div>
            </div>
          </div>
          <div class="round">
            <div class="round-title">Week 16: Semifinals</div>
            <div class="matchup">
              <div class="matchup-header">Semifinal</div>
              <div class="team winner"><span>Taylor Park Boys</span><span class="score">116.08</span></div>
              <div class="team loser"><span>Bum Rushers</span><span class="score">75.50</span></div>
            </div>
            <div class="matchup">
              <div class="matchup-header">Semifinal</div>
              <div class="team winner"><span>Nacua Matata</span><span class="score">128.08</span></div>
              <div class="team loser"><span>McMayhem</span><span class="score">110.60</span></div>
            </div>
            <div class="matchup">
              <div class="matchup-header">5th Place Game</div>
              <div class="team loser"><span>11 Men on grass</span><span class="score">59.52</span></div>
              <div class="team winner"><span>Pierogi People Eater</span><span class="score">128.70</span></div>
            </div>
          </div>
          <div class="round">
            <div class="round-title">Week 17: Finals</div>
            <div class="matchup">
              <div class="matchup-header">Championship</div>
              <div class="team winner"><span>Taylor Park Boys</span><span class="score">110.62</span></div>
              <div class="team loser"><span>Nacua Matata</span><span class="score">85.98</span></div>
            </div>
            <div class="matchup">
              <div class="matchup-header">3rd Place Game</div>
              <div class="team winner"><span>McMayhem</span><span class="score">102.52</span></div>
              <div class="team loser"><span>Bum Rushers</span><span class="score">93.18</span></div>
            </div>
          </div>
        </div>
      row: 4
      col: 0
      width: 24
      height: 10

    # League Standings Table with All-Play columns
    - title: "League Standings"
      name: standings_table
      explore: standings
      type: looker_grid
      fields: [
        standings.standings_rank,
        standings.team_name,
        standings.manager_name,
        standings.record,
        standings.win_percentage,
        standings.points_for,
        standings.points_against,
        standings.point_differential,
        luck_standings.all_play_record,
        luck_standings.all_play_win_pct,
        standings.streak,
        standings.games_back
      ]
      sorts: [standings.standings_rank asc]
      limit: 500
      show_view_names: false
      show_row_numbers: false
      truncate_column_names: false
      subtotals_at_bottom: false
      hide_totals: true
      hide_row_totals: true
      table_theme: white
      limit_displayed_rows: false
      enable_conditional_formatting: false
      header_text_alignment: left
      header_font_size: '12'
      rows_font_size: '12'
      listen:
        season: standings.season
        league: standings.league_key
      row: 14
      col: 0
      width: 24
      height: 12

    # Points For Distribution
    - title: "Points For Distribution"
      name: points_for_bar
      explore: standings
      type: looker_bar
      fields: [
        standings.team_name,
        standings.points_for
      ]
      sorts: [standings.points_for desc]
      limit: 500
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      show_y_axis_labels: true
      show_y_axis_ticks: true
      show_x_axis_label: false
      show_x_axis_ticks: true
      show_value_labels: true
      series_colors:
        standings.points_for: "#1A73E8"
      listen:
        season: standings.season
        league: standings.league_key
      row: 26
      col: 0
      width: 12
      height: 8

    # Win Percentage by Team
    - title: "Win Percentage by Team"
      name: win_pct_bar
      explore: standings
      type: looker_bar
      fields: [
        standings.team_name,
        standings.win_percentage
      ]
      sorts: [standings.win_percentage desc]
      limit: 500
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      show_y_axis_labels: true
      show_y_axis_ticks: true
      show_x_axis_label: false
      show_x_axis_ticks: true
      show_value_labels: true
      series_colors:
        standings.win_percentage: "#34A853"
      listen:
        season: standings.season
        league: standings.league_key
      row: 26
      col: 12
      width: 12
      height: 8

    # Summary tiles
    - title: "Teams in League"
      name: standings_summary
      explore: standings
      type: single_value
      fields: [standings.count]
      limit: 500
      custom_color_enabled: true
      custom_color: "#1A73E8"
      show_single_value_title: true
      single_value_title: "Teams in League"
      show_comparison: false
      listen:
        season: standings.season
        league: standings.league_key
      row: 34
      col: 0
      width: 8
      height: 4

    - title: "Avg Points For"
      name: avg_points_for
      explore: standings
      type: single_value
      fields: [standings.avg_points_for]
      limit: 500
      custom_color_enabled: true
      custom_color: "#34A853"
      show_single_value_title: true
      single_value_title: "Avg Points For"
      show_comparison: false
      listen:
        season: standings.season
        league: standings.league_key
      row: 34
      col: 8
      width: 8
      height: 4
