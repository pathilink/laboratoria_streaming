CREATE OR REPLACE TABLE my-first-project-494602.spotify.track_performance AS
SELECT
  s.track_id,
  s.track_name,
  s.artists_name,
  s.artist_count,
  s.main_music_genre,
  s.main_country,
  s.streams as in_spotify_streams,
  s.in_spotify_playlists,
  s.in_spotify_charts,
  c.in_apple_playlists,
  c.in_apple_charts,
  c.in_deezer_playlists,
  c.in_deezer_charts,
  c.in_shazam_charts, 
  s.released_year,
  s.released_month,
  s.released_day,
  s.released_date
FROM my-first-project-494602.spotify.track_in_spotify_clean s
LEFT JOIN my-first-project-494602.spotify.track_in_competition_clean c
ON s.track_id = c.track_id;

