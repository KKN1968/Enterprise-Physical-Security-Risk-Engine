CREATE OR REPLACE TABLE `coursera-prep-data-4-analysis.india_risk_index_2026.live_threat_feed` AS
SELECT
  PARSE_DATE('%Y%m%d', CAST(SQLDATE AS STRING)) AS event_date,
  ActionGeo_FullName AS location_name,
  ActionGeo_Lat AS latitude,
  ActionGeo_Long AS longitude,
  COUNT(1) AS incident_volume,
  ROUND(AVG(GoldsteinScale), 2) AS avg_stability_score,
  SUM(GoldsteinScale) AS goldstein_sum,
  COUNTIF(GoldsteinScale IS NOT NULL) AS goldstein_count,
  COUNTIF(EventRootCode = '14') AS civil_unrest_count,
  COUNTIF(EventRootCode IN ('18', '19', '20')) AS violent_events_count,
  COUNTIF(EventRootCode IN ('10', '11', '12', '13')) AS escalatory_actions_count
FROM
  `gdelt-bq.gdeltv2.events`
WHERE
  ActionGeo_CountryCode = 'IN'
  AND SQLDATE >= CAST(FORMAT_DATE('%Y%m%d', DATE_SUB(CURRENT_DATE(), INTERVAL 31 DAY)) AS INT64)
  AND SQLDATE < CAST(FORMAT_DATE('%Y%m%d', CURRENT_DATE()) AS INT64)
  AND ActionGeo_FullName IS NOT NULL
GROUP BY
  event_date, location_name, latitude, longitude;
