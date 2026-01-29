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
          background_color:,
          font_color:,
          color_application: {
            collection_id: custom,
            custom: {
              id: luck-red-white-green,
              label: Luck Red White Green,
              type: continuous,
              stops: [
                { color: "#EA4335", offset: 0 },
                { color: "#FFFFFF", offset: 50 },
                { color: "#34A853", offset: 100 }
              ]
            }
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
      row: 8
      col: 0
      width: 24
      height: 10

    # How It Works
    - title: ""
      name: methodology
      type: text
      title_text: ""
      subtitle_text: ""
      body_text: |
        <div style="background: #F5F5F5; padding: 16px 24px; border-radius: 8px; border-left: 4px solid #1A5C57;">
          <div style="font-size: 16px; font-weight: bold; color: #1A2A3A; margin-bottom: 8px;">How Expected Wins Are Calculated</div>
          <div style="font-size: 13px; color: #4A5A6A; line-height: 1.6;">
            Each week, teams are ranked by points scored. A team's <strong>Expected Win %</strong> for that week is based on how many teams they outscored:
            <br><br>
            <code style="background: #E8E8E8; padding: 2px 6px; border-radius: 4px;">Expected Win % = (Num Teams - Weekly Rank) / (Num Teams - 1)</code>
            <br><br>
            For example, in a 12-team league, the highest scorer has 100% expected win probability, while the lowest has 0%.
            <strong>Expected Wins</strong> is the sum of weekly expected win percentages across the regular season.
            The <strong>Luck Index</strong> is the difference between actual wins and expected wins &mdash; positive means lucky, negative means unlucky.
          </div>
        </div>
      row: 18
      col: 0
      width: 24
      height: 5

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
      row: 4
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
      row: 4
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
      row: 4
      col: 16
      width: 8
      height: 4
