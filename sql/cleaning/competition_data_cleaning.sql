CREATE OR REPLACE TABLE `my-first-project-494602.spotify.track_in_competition_clean` AS
SELECT
  track_id,
  in_apple_playlists,
  in_apple_charts,
  in_deezer_playlists,
  in_deezer_charts,

  IFNULL(SAFE_CAST(in_shazam_charts AS INT64), 0) AS in_shazam_charts

FROM `my-first-project-494602.spotify.track_in_competition_ativa_BR`;