SELECT DISTINCT * FROM DIVVY_DATABASE.PUBLIC.STATION_STATUS_FLATTEN_FULL 
    WHERE LEGACY_ID = '185' 
        OR LEGACY_ID = '222' 
        OR LEGACY_ID = '125' 
        OR LEGACY_ID = '196' 
        OR LEGACY_ID = '47' 
        OR LEGACY_ID = '285' 
        OR LEGACY_ID = '316' 
        OR LEGACY_ID = '116' 
    ORDER BY LAST_UPDATED DESC
    LIMIT 100000;