select *
from `my-first-project-494602.spotify.track_in_spotify_ativa_BR`
TABLESAMPLE SYSTEM (0.1 PERCENT)
limit 10;

-- check unique ids
select 
  track_id,
  count(track_id)
from `my-first-project-494602.spotify.track_in_spotify_ativa_BR`
group by 1
having count(track_id) > 1;

-- non unique ids -> dedupe
select *
from `my-first-project-494602.spotify.track_in_spotify_ativa_BR`
where track_id in (4343383, 4322356, 3108815, 8174233)
order by track_id;

-- check artists name -> lines with more than one artist (collabs)
select 
  distinct track_id, -- 7235348, 4335470,...
  artists_name
from `my-first-project-494602.spotify.track_in_spotify_ativa_BR`
order by artists_name;

-- check nulls by column
select 
  count(*) - count(track_id) track_id_nulls,
  count(*) - count(track_name) track_name_nulls,
  count(*) - count(artists_name) artists_name_nulls,
  count(*) - count(artist_count) artist_count_nulls,
  count(*) - count(main_music_genre) main_music_genre_nulls, -- 1
  count(*) - count(main_country) main_country_nulls, -- 1
  count(*) - count(released_year) released_year_nulls,
  count(*) - count(released_month) released_month_nulls,
  count(*) - count(released_day) released_day_nulls,
  count(*) - count(in_spotify_playlists) in_spotify_playlists_nulls,
  count(*) - count(in_spotify_charts) in_spotify_charts_nulls, -- 4
  count(*) - count(streams) streams_nulls
from `my-first-project-494602.spotify.track_in_spotify_ativa_BR`
;

select *
from `my-first-project-494602.spotify.track_in_spotify_ativa_BR`
where main_music_genre is null -- same line for main_country
;

select *
from `my-first-project-494602.spotify.track_in_spotify_ativa_BR`
where artists_name like 'Taylor%'
;

select *
from `my-first-project-494602.spotify.track_in_spotify_ativa_BR`
where in_spotify_charts is null -- assumed not in the ranking
;

-- different spellings 
select distinct main_music_genre -- Disco pop, Disco-pop
from `my-first-project-494602.spotify.track_in_spotify_ativa_BR`
order by 1
;

select distinct main_country -- MX, Mexico, PR, Puerto Rico, USA, United States
from `my-first-project-494602.spotify.track_in_spotify_ativa_BR`
order by 1
;

-- check periods
select released_year, released_month, released_day
from `my-first-project-494602.spotify.track_in_spotify_ativa_BR`
where 
  released_year not between 1800 and 2026
  or released_month not between 1 and 12
  or released_day not between 1 and 31
;

-- check values
select 
  distinct track_id, 
  in_spotify_playlists -- string -> int
from `my-first-project-494602.spotify.track_in_spotify_ativa_BR`
order by in_spotify_playlists desc
;

select *
from `my-first-project-494602.spotify.track_in_spotify_ativa_BR`
where track_id = 4061483 -- string instead of int
--where track_name like 'Love Grows%'
;

select track_id,--in_spotify_playlists, 
  in_spotify_charts, streams
from `my-first-project-494602.spotify.track_in_spotify_ativa_BR`
where 
  --in_spotify_playlists < 0
   in_spotify_charts < 0
  or streams < 0 -- -1 -> to be deleted
;




