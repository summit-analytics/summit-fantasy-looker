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
    # Podium - 1st, 2nd, 3rd Place
    - title: "1st Place"
      name: first_place
      explore: standings
      type: single_value
      fields: [standings.team_name]
      filters:
        standings.standings_rank: "1"
      limit: 1
      custom_color_enabled: true
      custom_color: "#FFD700"
      show_single_value_title: true
      single_value_title: "Champion"
      show_comparison: false
      listen:
        season: standings.season
        league: standings.league_key
      row: 0
      col: 0
      width: 8
      height: 4

    - title: "2nd Place"
      name: second_place
      explore: standings
      type: single_value
      fields: [standings.team_name]
      filters:
        standings.standings_rank: "2"
      limit: 1
      custom_color_enabled: true
      custom_color: "#C0C0C0"
      show_single_value_title: true
      single_value_title: "Runner Up"
      show_comparison: false
      listen:
        season: standings.season
        league: standings.league_key
      row: 0
      col: 8
      width: 8
      height: 4

    - title: "3rd Place"
      name: third_place
      explore: standings
      type: single_value
      fields: [standings.team_name]
      filters:
        standings.standings_rank: "3"
      limit: 1
      custom_color_enabled: true
      custom_color: "#CD7F32"
      show_single_value_title: true
      single_value_title: "3rd Place"
      show_comparison: false
      listen:
        season: standings.season
        league: standings.league_key
      row: 0
      col: 16
      width: 8
      height: 4

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
      row: 4
      col: 0
      width: 24
      height: 12

    # Playoff Bracket placeholder
    - title: "Playoff Bracket"
      name: playoff_bracket
      explore: standings
      type: looker_grid
      fields: [
        standings.playoff_seed,
        standings.team_name,
        standings.record,
        standings.points_for
      ]
      filters:
        standings.playoff_seed: "NOT NULL"
      sorts: [standings.playoff_seed asc]
      limit: 500
      show_view_names: false
      show_row_numbers: false
      table_theme: white
      listen:
        season: standings.season
        league: standings.league_key
      row: 16
      col: 0
      width: 12
      height: 8

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
      row: 16
      col: 12
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
      row: 24
      col: 0
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
      row: 24
      col: 12
      width: 4
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
      row: 24
      col: 16
      width: 4
      height: 4

    - title: "Avg Points Against"
      name: avg_points_against
      explore: standings
      type: single_value
      fields: [standings.avg_points_against]
      limit: 500
      custom_color_enabled: true
      custom_color: "#EA4335"
      show_single_value_title: true
      single_value_title: "Avg Points Against"
      show_comparison: false
      listen:
        season: standings.season
        league: standings.league_key
      row: 24
      col: 20
      width: 4
      height: 4
