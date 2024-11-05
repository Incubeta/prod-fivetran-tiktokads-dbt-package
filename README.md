# TikTok Ads Transformation dbt Package

## What does this dbt package do?
* Materializes the TikTok Ads RAW_main tables using the data coming from the TikTok API.

## How do I use the dbt package?
### Step 1: Prerequisites
To use this dby package, you must have the following:
- At least one Fivetran Microsoft connector syncing data for at least one of the predefined reports:
    - tiktok_ad_performance_v_1
- A BigQuery data destination.

### Step 2: Install the package
Include the following tiktok package version in your `packages.yml` file
```yaml
packages:
  - git: "https://github.com/Incubeta/prod-fivetran-tiktok-dbt-package.git"
    revision: main
```

### Step 3: Define input tables variables
This package reads the microsoft/bings data from the different tables created by the microsoft ads connector. 
The names of the tables can be changed by setting the correct name in the root `dbt_project.yml` file.

The following table shows the configuration keys and the default table names:

|key|default|
|---|-------|
|tiktok_ad_performance_v_1_identifier|tiktok_ad_performance_v_1|


If the connector uses different table names (for example tiktok_ad_performance_v_1_test) this can be set in the `dbt_project.yml` as follows.

```yaml
vars:
    tiktok_ad_performance_v_1_identifier: tiktok_ad_performance_v_1_test
```

### (Optional) Step 4: Additional configurations

#### Change output tables:
The following vars can be used to change the output table names:

|key| default                  |
|---|--------------------------|
|tiktok_ad_performance_v1_alias| tiktok-ad_performance-v1 |


#### Add custom fields:
Ensure that the variable `tiktok_custom_fields` is defined in the root project's `dbt_project.yml` file (this is your main repository).
```yaml
# dbt_project.yml (root project)
vars:
  tiktok_custom_fields: "value_per_complete_payment,complete_payment,user_registration,page_event_search,total_pageview"

```

#### Add non-existing fields:
Ensure that the variable `tiktok_non_existing_fields` is defined in the root project's `dbt_project.yml` file (this is your main repository).
This will add `NULL` value to the field.
```yaml
# dbt_project.yml (root project)
vars:
  tiktok_non_existing_fields: "field1,field2"

```

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
