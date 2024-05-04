SELECT track_id, avg_speed
FROM {{ ref('TrackInfo') }}
WHERE avg_speed > 40;
