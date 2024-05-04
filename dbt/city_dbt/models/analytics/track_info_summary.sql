{{ config(materialized='table') }}

SELECT
    type,
    COUNT(*) AS track_count,
    AVG(traveled_d) AS avg_distance,
    AVG(avg_speed) AS avg_speed
FROM {{ ref('staging', 'track_info') }}
GROUP BY type