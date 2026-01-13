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
    # Top Banner - Podium with Ted Lasso names (HTML styled)
    - title: ""
      name: podium_banner
      type: text
      title_text: ""
      subtitle_text: ""
      body_text: |
        <div style="display: flex; justify-content: space-around; align-items: center; background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%); padding: 20px; border-radius: 8px;">
          <div style="text-align: center; flex: 1; border-right: 1px solid #374151;">
            <div style="font-size: 12px; color: #9CA3AF; text-transform: uppercase; margin-bottom: 5px;">🏆 1st Place</div>
            <div style="font-size: 18px; font-weight: bold; color: #FFD700;">AFC Richmond</div>
          </div>
          <div style="text-align: center; flex: 1; border-right: 1px solid #374151;">
            <div style="font-size: 12px; color: #9CA3AF; text-transform: uppercase; margin-bottom: 5px;">🥈 2nd Place</div>
            <div style="font-size: 18px; font-weight: bold; color: #C0C0C0;">Believe</div>
          </div>
          <div style="text-align: center; flex: 1;">
            <div style="font-size: 12px; color: #9CA3AF; text-transform: uppercase; margin-bottom: 5px;">🥉 3rd Place</div>
            <div style="font-size: 18px; font-weight: bold; color: #CD7F32;">Be A Goldfish</div>
          </div>
        </div>
      row: 0
      col: 0
      width: 24
      height: 4

    # Playoff Bracket - Week 15 Quarterfinals
    - title: "Week 15: Quarterfinals"
      name: bracket_week15
      type: text
      subtitle_text: ""
      body_text: |
        | Seed | Team | Score |
        |------|------|-------|
        | 1 | **AFC Richmond** | BYE |
        | 2 | **Believe** | BYE |
        | 3 | ~~Roy Kent FC~~ | 102.24 |
        | 6 | **Biscuits With The Boss** | 110.52 |
        | 4 | **Be A Goldfish** | 109.80 |
        | 5 | ~~Diamond Dogs~~ | 86.90 |
      row: 4
      col: 0
      width: 8
      height: 7

    # Playoff Bracket - Week 16 Semifinal 1
    - title: "Week 16: Semifinal 1"
      name: bracket_semi1
      type: text
      subtitle_text: ""
      body_text: |
        | Team | Score |
        |------|-------|
        | **AFC Richmond** | 116.08 |
        | ~~Biscuits With The Boss~~ | 75.50 |
      row: 4
      col: 8
      width: 5
      height: 3

    # Playoff Bracket - Week 16 Semifinal 2
    - title: "Week 16: Semifinal 2"
      name: bracket_semi2
      type: text
      subtitle_text: ""
      body_text: |
        | Team | Score |
        |------|-------|
        | **Believe** | 128.08 |
        | ~~Be A Goldfish~~ | 110.60 |
      row: 4
      col: 13
      width: 5
      height: 3

    # Playoff Bracket - Week 16 5th Place
    - title: "Week 16: 5th Place"
      name: bracket_5th
      type: text
      subtitle_text: ""
      body_text: |
        | Team | Score |
        |------|-------|
        | ~~Roy Kent FC~~ | 59.52 |
        | **Diamond Dogs** | 128.70 |
      row: 7
      col: 8
      width: 5
      height: 3

    # Playoff Bracket - Week 17 Championship
    - title: "Week 17: Championship 🏆"
      name: bracket_championship
      type: text
      subtitle_text: ""
      body_text: |
        | Team | Score |
        |------|-------|
        | **AFC Richmond** 🏆 | 110.62 |
        | ~~Believe~~ | 85.98 |
      row: 4
      col: 18
      width: 6
      height: 3

    # Playoff Bracket - Week 17 3rd Place
    - title: "Week 17: 3rd Place"
      name: bracket_3rd
      type: text
      subtitle_text: ""
      body_text: |
        | Team | Score |
        |------|-------|
        | **Be A Goldfish** 🥉 | 102.52 |
        | ~~Biscuits With The Boss~~ | 93.18 |
      row: 7
      col: 18
      width: 6
      height: 3

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
      row: 11
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
      row: 23
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
      row: 23
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
      row: 31
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
      row: 31
      col: 8
      width: 8
      height: 4
