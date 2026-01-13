view: fct_standings {
  sql_table_name: `summit-fantasy.summit_fantasy_marts.fct_standings` ;;

  # Primary key
  dimension: standings_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.standings_id ;;
    hidden: yes
  }

  # Keys
  dimension: league_key {
    type: string
    sql: ${TABLE}.league_key ;;
    description: "Yahoo league identifier (e.g., 461.l.22103)"
  }

  dimension: team_key {
    type: string
    sql: ${TABLE}.team_key ;;
    description: "Yahoo team identifier"
    hidden: yes
  }

  dimension: team_id {
    type: number
    sql: ${TABLE}.team_id ;;
    description: "Team ID within the league"
    hidden: yes
  }

  dimension: season {
    type: number
    sql: ${TABLE}.season ;;
    description: "NFL season year"
  }

  # Team info
  dimension: team_name {
    type: string
    sql: ${TABLE}.team_name ;;
    description: "Fantasy team name (display name from lookup)"
  }

  dimension: original_team_name {
    type: string
    sql: ${TABLE}.original_team_name ;;
    description: "Original team name from Yahoo"
    hidden: yes
  }

  dimension: manager_name {
    type: string
    sql: ${TABLE}.manager_name ;;
    description: "Team manager/owner name"
  }

  # Standings
  dimension: standings_rank {
    type: number
    sql: ${TABLE}.standings_rank ;;
    description: "Current standings rank"
  }

  dimension: playoff_seed {
    type: number
    sql: ${TABLE}.playoff_seed ;;
    description: "Playoff seed (if applicable)"
  }

  # Record
  dimension: wins {
    type: number
    sql: ${TABLE}.wins ;;
  }

  dimension: losses {
    type: number
    sql: ${TABLE}.losses ;;
  }

  dimension: ties {
    type: number
    sql: ${TABLE}.ties ;;
  }

  dimension: games_played {
    type: number
    sql: ${TABLE}.games_played ;;
    description: "Total games played"
  }

  dimension: win_percentage {
    type: number
    sql: ${TABLE}.win_percentage ;;
    value_format_name: percent_1
    description: "Win percentage (0-1)"
  }

  dimension: record {
    type: string
    sql: CONCAT(${wins}, '-', ${losses}, CASE WHEN ${ties} > 0 THEN CONCAT('-', ${ties}) ELSE '' END) ;;
    description: "W-L-T record"
  }

  # Points
  dimension: points_for {
    type: number
    sql: ${TABLE}.points_for ;;
    value_format_name: decimal_2
    description: "Total points scored"
  }

  dimension: points_against {
    type: number
    sql: ${TABLE}.points_against ;;
    value_format_name: decimal_2
    description: "Total points scored against"
  }

  dimension: point_differential {
    type: number
    sql: ${TABLE}.point_differential ;;
    value_format_name: decimal_2
    description: "Points For minus Points Against"
  }

  # Streak
  dimension: streak_type {
    type: string
    sql: ${TABLE}.streak_type ;;
    description: "W or L for current streak"
    hidden: yes
  }

  dimension: streak_value {
    type: number
    sql: ${TABLE}.streak_value ;;
    description: "Length of current streak"
    hidden: yes
  }

  dimension: streak {
    type: string
    sql: ${TABLE}.streak_display ;;
    description: "Current streak (e.g., W3, L2)"
  }

  # Games back
  dimension: games_back {
    type: number
    sql: ${TABLE}.games_back ;;
    value_format_name: decimal_1
    description: "Games behind first place"
  }

  # ----- Measures -----

  measure: count {
    type: count
    drill_fields: [team_name, manager_name, record, points_for]
  }

  measure: total_wins {
    type: sum
    sql: ${wins} ;;
  }

  measure: total_losses {
    type: sum
    sql: ${losses} ;;
  }

  measure: total_points_for {
    type: sum
    sql: ${points_for} ;;
    value_format_name: decimal_2
  }

  measure: total_points_against {
    type: sum
    sql: ${points_against} ;;
    value_format_name: decimal_2
  }

  measure: avg_points_for {
    type: average
    sql: ${points_for} ;;
    value_format_name: decimal_2
  }

  measure: avg_points_against {
    type: average
    sql: ${points_against} ;;
    value_format_name: decimal_2
  }
}
