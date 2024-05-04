-- Model: safety_analysis_summary

-- Calculate safety metrics for each track
WITH safety_metrics AS (
    SELECT
        track_id,
        AVG(speed) AS avg_speed,           -- Average speed of the track
        MAX(lon_acc) AS max_lon_acc,       -- Maximum longitudinal acceleration (potential indicator of sudden braking or acceleration)
        MAX(lat_acc) AS max_lat_acc,       -- Maximum lateral acceleration (potential indicator of sharp turns)
        SUM(traveled_d) AS total_distance  -- Total distance traveled by the track
    FROM
        TrajectoryInfo
    GROUP BY
        track_id
)

-- Final summary including safety categories
SELECT
    track_id,
    avg_speed,                           -- Average speed of the track
    max_lon_acc,                         -- Maximum longitudinal acceleration
    max_lat_acc,                         -- Maximum lateral acceleration
    total_distance,                      -- Total distance traveled by the track
    CASE
        WHEN avg_speed > 40 THEN 'High Speed'  -- Categorize tracks with average speed greater than 40 as 'High Speed'
        ELSE 'Normal Speed'                    -- Otherwise, categorize as 'Normal Speed'
    END AS speed_category,
    CASE
        WHEN total_distance > 400 THEN 'Long Distance'  -- Categorize tracks with total distance greater than 400 as 'Long Distance'
        ELSE 'Short Distance'                           -- Otherwise, categorize as 'Short Distance'
    END AS distance_category
FROM
    safety_metrics;
