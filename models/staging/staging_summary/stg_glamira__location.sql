WITH unique_ips AS (
    SELECT DISTINCT ip 
    FROM {{ source('glamira_raw', 'summary') }}
    WHERE ip IS NOT NULL
),

location_map AS (
    SELECT * FROM {{ source('glamira_raw', 'ip_location') }}
)

SELECT
    u.ip AS ip_address
    ,l.country_code AS country_short_name
    ,l.country_name AS country_long_name
    ,l.region AS region_name
    ,l.city AS city_name
FROM unique_ips u
LEFT JOIN location_map l
    ON u.ip = l.ip -- Joining on exact column name 'ip'