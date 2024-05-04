
{{ config(materialized='table') }}

SELECT *
FROM {{ source('analytics', 'TrajectoryInfo') }}
