CREATE OR REPLACE TASK LOAD_STATION_TASK 
    WAREHOUSE = DIVVY_WAREHOUSE
    SCHEDULE = '15 MINUTE'
AS
  INSERT INTO STATION_STATUS_FLATTEN_FULL
  select DISTINCT
     to_timestamp(data:last_updated)                    as last_updated
  , value:station_id                                    as station_id
  , value:num_ebikes_available                          as num_ebikes_available
  , (num_ebikes_available >= 1)                         as num_ebikes_available_bool
  , value:num_bikes_available                           as num_bikes_available
  , value:num_docks_available                           as num_docks_available
  , to_timestamp(value:last_reported)                   as last_reported
  , value:station_status                                as station_status
  , value:is_installed                                  as is_installed
  , value:num_docks_disabled                            as num_docks_disabled
  , value:num_bikes_disabled                            as num_bikes_disabled
  , value:is_renting                                    as is_renting
  , value:is_returning                                  as is_returning
  , value:eightd_has_available_keys                     as eightd_has_available_keys
  , value:legacy_id                                     as legacy_id
  from
    station_status_raw
  , lateral flatten ( input => data:data.stations )
  WHERE last_updated > dateadd('minutes', -16, convert_timezone('America/Los_Angeles', 'UTC' ,current_timestamp()));