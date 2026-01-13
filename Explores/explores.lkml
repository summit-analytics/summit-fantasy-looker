# Summit Fantasy Explores

include: "/Fact_views/*.view.lkml"

explore: standings {
  from: fct_standings
  label: "League Standings"
  description: "Summary of the 2025 Season"

  # Default sort by rank
  always_filter: {
    filters: [standings.season: ""]
  }

  # Join luck standings for All-Play columns
  join: luck_standings {
    from: fct_luck_standings
    type: left_outer
    relationship: one_to_one
    sql_on: ${standings.team_key} = ${luck_standings.team_key}
        AND ${standings.season} = ${luck_standings.season}
        AND ${standings.league_key} = ${luck_standings.league_key} ;;
  }
}

explore: luck_analysis {
  from: fct_luck_standings
  label: "Luck Analysis"
  description: "Luck-adjusted standings with All-Play records and Expected Wins"

  always_filter: {
    filters: [luck_analysis.season: ""]
  }
}

# Future explores (uncomment when views are ready):
#
# explore: matchups {
#   from: fct_matchup_history
#   label: "Matchup History"
#   description: "Weekly head-to-head matchup results"
# }
#
# explore: player_performance {
#   from: fct_player_performance
#   label: "Player Performance"
#   description: "Player stats and fantasy points"
# }
