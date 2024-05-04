-- Description: Calculates average speed and traveled distance for each trajectory

WITH trajectory_summary AS (
    SELECT
        track_id,
        AVG(speed) AS avg_speed,
        SUM(speed * time) AS traveled_distance
    FROM
        trajectory_info
    GROUP BY
        track_id
)

SELECT * FROM trajectory_summary;
