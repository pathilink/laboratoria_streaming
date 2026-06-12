CREATE OR REPLACE TABLE `my-first-project-494602.spotify.track_in_spotify_clean` AS

WITH deduped AS (
  SELECT *
  FROM (
    SELECT *,
      CAST(track_id AS STRING) AS track_id_str, -- nominal variable
      ROW_NUMBER() OVER (PARTITION BY track_id ORDER BY streams DESC) AS rn
    FROM `my-first-project-494602.spotify.track_in_spotify_ativa_BR`
  )
  WHERE rn = 1
),

cleaned AS (
  SELECT
    track_id_str AS track_id, 
    track_name,
    artists_name,
    artist_count,

    -- treat null + standardization
    CASE
      WHEN track_id_str = '4796316'
        AND main_music_genre IS NULL THEN 'Pop'
      WHEN main_music_genre = 'Disco pop' THEN 'Disco-pop'
      ELSE main_music_genre
    END AS main_music_genre,

    CASE
      WHEN main_country = 'MX' THEN 'Mexico'
      WHEN main_country = 'PR' THEN 'Puerto Rico'
      WHEN main_country = 'USA' THEN 'United States'
      WHEN track_id_str = '4796316' AND main_country IS NULL THEN 'United States'
      ELSE main_country
    END AS main_country,

    -- safe cast + removal of invalid data
    SAFE_CAST(in_spotify_playlists AS INT64) AS in_spotify_playlists,

    -- treat null
    IFNULL(in_spotify_charts, 0) AS in_spotify_charts,

    streams,

    released_year,
    released_month,
    released_day,

    -- create date
    SAFE.DATE(released_year, released_month, released_day) AS released_date

  FROM deduped
)

SELECT *
FROM cleaned
-- WHERE
--   in_spotify_playlists IS NOT NULL  -- removes invalid strings
--   AND released_year IS NOT NULL
;

