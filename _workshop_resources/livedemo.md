### Live Demo

Update the `models:` config in `dbt_project.yml` to match the example below.

```yml
models:
  xplat_foundation:
    marts:
      +materialized: table
      +access: public
      +file_format: iceberg
      +catalog: coalesce_cross_platform_mesh_iceberg
      intermediate: 
        +materialized: table
        +file_format: delta
      standard_tables: 
        +materialized: table
        +file_format: delta
```

Learn more: [dbt Databricks and Apache Iceberg support documentation](https://docs.getdbt.com/docs/mesh/iceberg/databricks-iceberg-support)  
