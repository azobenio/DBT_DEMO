with trips as (
  select
    ride_id,

    to_date(try_to_timestamp_ntz(started_at)) as trip_date,

    start_statio_id as start_station_id,
    end_station_id,

    member_csual as member_casual,

    datediff(
      'second',
      try_to_timestamp_ntz(started_at),
      try_to_timestamp_ntz(ended_at)
    ) as trip_duration_seconds

  from {{ ref('stg_bike') }}
  where ride_id != 'ride_id'
    and try_to_timestamp_ntz(started_at) is not null
    and try_to_timestamp_ntz(ended_at)   is not null
)

select *
from trips
