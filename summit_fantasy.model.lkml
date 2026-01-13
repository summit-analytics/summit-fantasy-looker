connection: "summit_fantasy"

# Include all views
# include: "/Dimension_views/*.view.lkml"  # Empty - uncomment when views added
include: "/Fact_views/*.view.lkml"
# include: "/Derived_views/*.view.lkml"  # Empty - uncomment when views added
include: "/Explores/*.lkml"
include: "/Dashboards/*.dashboard.lookml"

# Default datagroup for caching
datagroup: summit_fantasy_default_datagroup {
  max_cache_age: "1 hour"
}

persist_with: summit_fantasy_default_datagroup

# Access grants (if needed later)
# access_grant: can_see_sensitive_data {
#   user_attribute: department
#   allowed_values: ["analytics"]
# }
