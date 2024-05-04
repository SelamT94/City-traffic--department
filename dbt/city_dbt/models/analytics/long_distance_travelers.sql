SELECT track_id, traveled_distance
FROM {{ ref('TrackInfo') }}
WHERE traveled_distance > 400;
