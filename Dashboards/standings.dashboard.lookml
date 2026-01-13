- dashboard: standings
  title: "League Standings"
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Fantasy league standings - validates against Yahoo Fantasy standings page"

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
      row: 0
      col: 0
      width: 24
      height: 12

    - title: "Points For vs Points Against"
      name: points_scatter
      explore: standings
      type: looker_scatter
      fields: [
        standings.team_name,
        standings.points_for,
        standings.points_against
      ]
      sorts: [standings.points_for desc]
      limit: 500
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_label: "Points For"
      y_axis_label: "Points Against"
      point_style: circle
      series_colors:
        standings.points_against: "#EA4335"
      listen:
        season: standings.season
        league: standings.league_key
      row: 12
      col: 0
      width: 12
      height: 8

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
      row: 12
      col: 12
      width: 12
      height: 8

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
      row: 20
      col: 0
      width: 12
      height: 8

    - title: "Standings Summary"
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
      row: 20
      col: 12
      width: 6
      height: 4

    - title: "Avg Points Per Team"
      name: avg_points
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
      row: 20
      col: 18
      width: 6
      height: 4
