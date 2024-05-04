{{ config(materialized='table') }}

SELECT
    track_id,
    COUNT(*) AS trajectory_count,
    AVG(speed) AS avg_speed,
    AVG(lon) AS avg_lon,
    AVG(lat) AS avg_lat
FROM {{ ref('staging', 'trajectory_info') }}
GROUP BY track_id