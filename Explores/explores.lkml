# Summit Fantasy Explores

include: "/Fact_views/*.view.lkml"

explore: standings {
  from: fct_standings
  label: "League Standings"
  description: "Current fantasy league standings with records and points"

  # Default sort by rank
  always_filter: {
    filters: [standings.season: ""]
  }
}

# Future explores (uncomment when views are ready):
#
# explore: luck_analysis {
#   from: fct_luck_standings
#   label: "Luck Analysis"
#   description: "Luck-adjusted standings with All-Play records and Expected Wins"
# }
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
