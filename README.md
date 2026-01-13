# Summit Fantasy Looker

LookML project for Summit Fantasy league analytics.

## Structure

```
├── summit_fantasy.model.lkml    # Main model file
├── manifest.lkml                # Project manifest
├── Fact_views/                  # Fact table views
├── Dimension_views/             # Dimension views (future)
├── Derived_views/               # Derived/calculated views (future)
├── Explores/                    # Explore definitions
└── Dashboards/                  # Dashboard LookML
```

## Connection

This project connects to the `summit_fantasy` BigQuery connection pointing to `summit-fantasy.summit_fantasy_marts`.

## Related Repos

- [summit-fantasy](https://github.com/summit-analytics/summit-fantasy) - Main project with dbt models and extraction
