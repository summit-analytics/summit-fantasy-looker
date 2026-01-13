view: fct_luck_standings {
  sql_table_name: `summit-fantasy.summit_fantasy_marts.fct_luck_standings` ;;

  # Primary key
  dimension: luck_standings_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.luck_standings_id ;;
    hidden: yes
  }

  # Keys
  dimension: league_key {
    type: string
    sql: ${TABLE}.league_key ;;
    hidden: yes
  }

  dimension: team_key {
    type: string
    sql: ${TABLE}.team_key ;;
    hidden: yes
  }

  dimension: season {
    type: number
    sql: ${TABLE}.season ;;
  }

  # Team info
  dimension: team_name {
    type: string
    sql: ${TABLE}.team_name ;;
    description: "Fantasy team name (display name)"
  }

  dimension: original_team_name {
    type: string
    sql: ${TABLE}.original_team_name ;;
    hidden: yes
  }

  # Actual record
  dimension: actual_wins {
    type: number
    sql: ${TABLE}.actual_wins ;;
  }

  dimension: actual_losses {
    type: number
    sql: ${TABLE}.actual_losses ;;
  }

  dimension: actual_ties {
    type: number
    sql: ${TABLE}.actual_ties ;;
  }

  dimension: games_played {
    type: number
    sql: ${TABLE}.games_played ;;
  }

  dimension: actual_record {
    type: string
    sql: CONCAT(${actual_wins}, '-', ${actual_losses}, CASE WHEN ${actual_ties} > 0 THEN CONCAT('-', ${actual_ties}) ELSE '' END) ;;
    description: "W-L-T record"
  }

  # All-Play record
  dimension: all_play_wins {
    type: number
    sql: ${TABLE}.all_play_wins ;;
    description: "Wins if you played every team every week"
  }

  dimension: all_play_losses {
    type: number
    sql: ${TABLE}.all_play_losses ;;
    description: "Losses if you played every team every week"
  }

  dimension: all_play_win_pct {
    type: number
    sql: ${TABLE}.all_play_win_pct ;;
    value_format_name: percent_1
    description: "All-Play win percentage"
  }

  dimension: all_play_record {
    type: string
    sql: CONCAT(${all_play_wins}, '-', ${all_play_losses}) ;;
    description: "All-Play W-L record"
  }

  # Luck metrics
  dimension: expected_wins {
    type: number
    sql: ${TABLE}.expected_wins ;;
    value_format_name: decimal_1
    description: "Expected wins based on weekly scoring rank"
  }

  dimension: luck_index {
    type: number
    sql: ${TABLE}.luck_index ;;
    value_format_name: decimal_1
    description: "Actual Wins - Expected Wins (positive = lucky)"
    html:
      {% if value > 0 %}
        <span style="color: #34A853;">+{{ rendered_value }}</span>
      {% elsif value < 0 %}
        <span style="color: #EA4335;">{{ rendered_value }}</span>
      {% else %}
        {{ rendered_value }}
      {% endif %} ;;
  }

  dimension: luck_rating {
    type: string
    sql: ${TABLE}.luck_rating ;;
    description: "Luck interpretation (Very Lucky, Lucky, Neutral, Unlucky, Very Unlucky)"
    html:
      {% if value == 'Very Lucky' %}
        <span style="color: #34A853; font-weight: bold;">{{ value }}</span>
      {% elsif value == 'Lucky' %}
        <span style="color: #34A853;">{{ value }}</span>
      {% elsif value == 'Very Unlucky' %}
        <span style="color: #EA4335; font-weight: bold;">{{ value }}</span>
      {% elsif value == 'Unlucky' %}
        <span style="color: #EA4335;">{{ value }}</span>
      {% else %}
        {{ value }}
      {% endif %} ;;
  }

  # Points
  dimension: total_points_for {
    type: number
    sql: ${TABLE}.total_points_for ;;
    value_format_name: decimal_2
  }

  dimension: avg_weekly_points {
    type: number
    sql: ${TABLE}.avg_weekly_points ;;
    value_format_name: decimal_2
  }

  # Rankings
  dimension: actual_rank {
    type: number
    sql: ${TABLE}.actual_rank ;;
    description: "Rank by actual wins"
  }

  dimension: expected_rank {
    type: number
    sql: ${TABLE}.expected_rank ;;
    description: "Rank by expected wins"
  }

  dimension: all_play_rank {
    type: number
    sql: ${TABLE}.all_play_rank ;;
    description: "Rank by all-play record"
  }

  # ----- Measures -----

  measure: count {
    type: count
    drill_fields: [team_name, actual_record, all_play_record, luck_index]
  }

  measure: total_luck_index {
    type: sum
    sql: ${luck_index} ;;
    value_format_name: decimal_1
  }

  measure: avg_luck_index {
    type: average
    sql: ${luck_index} ;;
    value_format_name: decimal_2
  }

  measure: total_all_play_wins {
    type: sum
    sql: ${all_play_wins} ;;
  }

  measure: total_all_play_losses {
    type: sum
    sql: ${all_play_losses} ;;
  }
}
