- dashboard: luck_analysis
  title: "Luck Analysis"
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "All-Play records, Expected Wins, and Luck Index for regular season (Weeks 1-14)"

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
      explore: luck_analysis
      field: luck_analysis.season

    - name: league
      title: "League"
      type: field_filter
      default_value: ""
      allow_multiple_values: false
      required: false
      ui_config:
        type: dropdown_menu
        display: inline
      explore: luck_analysis
      field: luck_analysis.league_key

  elements:
    # Header text
    - title: ""
      name: luck_header
      type: text
      title_text: ""
      subtitle_text: ""
      body_text: |
        <div style="background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%); padding: 20px; border-radius: 8px; text-align: center;">
          <div style="font-size: 24px; font-weight: bold; color: #FFFFFF; margin-bottom: 10px;">Luck Analysis</div>
          <div style="font-size: 14px; color: #9CA3AF;">Regular Season Only (Weeks 1-14)</div>
          <div style="font-size: 12px; color: #6B7280; margin-top: 10px;">
            <strong>Luck Index</strong> = Actual Wins - Expected Wins | <strong>All-Play</strong> = Record vs. every team every week
          </div>
        </div>
      row: 0
      col: 0
      width: 24
      height: 4

    # Luck Index Bar Chart - Horizontal
    - title: "Luck Index by Team"
      name: luck_index_bar
      explore: luck_analysis
      type: looker_bar
      fields: [
        luck_analysis.team_name,
        luck_analysis.luck_index
      ]
      sorts: [luck_analysis.luck_index desc]
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
        luck_analysis.luck_index: "#5C6BC0"
      reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
          margin_value: mean, margin_bottom: deviation, label_position: left, color: "#EA4335",
          line_value: '0', label: 'Neutral'}]
      listen:
        season: luck_analysis.season
        league: luck_analysis.league_key
      row: 4
      col: 0
      width: 12
      height: 10

    # All-Play Win % Bar Chart
    - title: "All-Play Win %"
      name: all_play_pct_bar
      explore: luck_analysis
      type: looker_bar
      fields: [
        luck_analysis.team_name,
        luck_analysis.all_play_win_pct
      ]
      sorts: [luck_analysis.all_play_win_pct desc]
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
        luck_analysis.all_play_win_pct: "#26A69A"
      listen:
        season: luck_analysis.season
        league: luck_analysis.league_key
      row: 4
      col: 12
      width: 12
      height: 10

    # Luck Analysis Table
    - title: "Luck Standings"
      name: luck_table
      explore: luck_analysis
      type: looker_grid
      fields: [
        luck_analysis.all_play_rank,
        luck_analysis.team_name,
        luck_analysis.actual_record,
        luck_analysis.all_play_record,
        luck_analysis.all_play_win_pct,
        luck_analysis.expected_wins,
        luck_analysis.actual_wins,
        luck_analysis.luck_index,
        luck_analysis.luck_rating
      ]
      sorts: [luck_analysis.all_play_rank asc]
      limit: 500
      show_view_names: false
      show_row_numbers: false
      truncate_column_names: false
      subtotals_at_bottom: false
      hide_totals: true
      hide_row_totals: true
      table_theme: white
      limit_displayed_rows: false
      enable_conditional_formatting: true
      conditional_formatting: [
        {
          type: along a scale...,
          value:,
          background_color: "#26A69A",
          font_color:,
          color_application: {
            collection_id: google,
            palette_id: google-diverging-0,
            options: { steps: 5, reverse: true }
          },
          bold: false,
          italic: false,
          strikethrough: false,
          fields: [luck_analysis.luck_index]
        }
      ]
      header_text_alignment: left
      header_font_size: '12'
      rows_font_size: '12'
      listen:
        season: luck_analysis.season
        league: luck_analysis.league_key
      row: 14
      col: 0
      width: 24
      height: 10

    # Actual vs Expected Wins Scatter
    - title: "Actual vs Expected Wins"
      name: actual_vs_expected
      explore: luck_analysis
      type: looker_scatter
      fields: [
        luck_analysis.team_name,
        luck_analysis.expected_wins,
        luck_analysis.actual_wins
      ]
      sorts: [luck_analysis.expected_wins desc]
      limit: 500
      x_axis_gridlines: true
      y_axis_gridlines: true
      show_view_names: false
      show_y_axis_labels: true
      show_y_axis_ticks: true
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_label: "Expected Wins"
      y_axis_labels: ["Actual Wins"]
      show_value_labels: true
      point_style: circle
      series_colors:
        luck_analysis.actual_wins: "#5C6BC0"
      reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
          margin_value: mean, margin_bottom: deviation, label_position: left, color: "#9E9E9E",
          line_value: 'x', label: 'Perfect Luck Line'}]
      listen:
        season: luck_analysis.season
        league: luck_analysis.league_key
      row: 24
      col: 0
      width: 24
      height: 10

    # Summary KPIs
    - title: "Luckiest Team"
      name: luckiest_team
      explore: luck_analysis
      type: single_value
      fields: [luck_analysis.team_name, luck_analysis.luck_index]
      sorts: [luck_analysis.luck_index desc]
      limit: 1
      custom_color_enabled: true
      custom_color: "#34A853"
      show_single_value_title: true
      single_value_title: "Luckiest Team"
      show_comparison: true
      comparison_type: value
      comparison_label: "Luck Index"
      listen:
        season: luck_analysis.season
        league: luck_analysis.league_key
      row: 34
      col: 0
      width: 8
      height: 4

    - title: "Unluckiest Team"
      name: unluckiest_team
      explore: luck_analysis
      type: single_value
      fields: [luck_analysis.team_name, luck_analysis.luck_index]
      sorts: [luck_analysis.luck_index asc]
      limit: 1
      custom_color_enabled: true
      custom_color: "#EA4335"
      show_single_value_title: true
      single_value_title: "Unluckiest Team"
      show_comparison: true
      comparison_type: value
      comparison_label: "Luck Index"
      listen:
        season: luck_analysis.season
        league: luck_analysis.league_key
      row: 34
      col: 8
      width: 8
      height: 4

    - title: "Best All-Play Record"
      name: best_all_play
      explore: luck_analysis
      type: single_value
      fields: [luck_analysis.team_name, luck_analysis.all_play_record]
      sorts: [luck_analysis.all_play_rank asc]
      limit: 1
      custom_color_enabled: true
      custom_color: "#1A73E8"
      show_single_value_title: true
      single_value_title: "Best All-Play Record"
      show_comparison: true
      comparison_type: value
      comparison_label: "All-Play Record"
      listen:
        season: luck_analysis.season
        league: luck_analysis.league_key
      row: 34
      col: 16
      width: 8
      height: 4
