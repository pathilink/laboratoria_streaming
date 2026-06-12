select *
from `my-first-project-494602.spotify.track_in_competition_ativa_BR`
TABLESAMPLE SYSTEM (0.1 PERCENT)
limit 10;

-- check unique ids -- ok
select 
  --track_id,
  count(track_id) -- 953
from `my-first-project-494602.spotify.track_in_competition_ativa_BR`
--group by 1
--having count(track_id) > 1
;

-- check nulls by column
select 
  count(*) - count(track_id) track_id_nulls,
  count(*) - count(in_apple_playlists) in_apple_playlists_nulls,
  count(*) - count(in_apple_charts) in_apple_charts_nulls,
  count(*) - count(in_deezer_playlists) in_deezer_playlists_nulls,
  count(*) - count(in_deezer_charts) in_deezer_charts_nulls, 
  count(*) - count(in_shazam_charts) in_shazam_charts_nulls -- 50
from `my-first-project-494602.spotify.track_in_competition_ativa_BR`
;

select 
  s.track_id as spotify_id, 
  c.track_id as competition_id, -- competition ids aren't on spotify
  s.artists_name,
  c.in_shazam_charts
from `my-first-project-494602.spotify.track_in_competition_ativa_BR` c
left join `my-first-project-494602.spotify.track_in_spotify_clean` s
  -- both sides forced to string
  on safe_cast(s.track_id as string) = safe_cast(c.track_id as string)
where c.in_shazam_charts is null
order by s.artists_name
;

-- check values
select 
  in_apple_playlists,
  in_apple_charts,
  in_deezer_playlists,
  in_deezer_charts,
  in_shazam_charts
from `my-first-project-494602.spotify.track_in_competition_ativa_BR`
where 
  in_apple_playlists < 0
  or in_apple_charts < 0 
  or in_deezer_playlists < 0
  or in_deezer_charts < 0
  or in_shazam_charts < 0
;
