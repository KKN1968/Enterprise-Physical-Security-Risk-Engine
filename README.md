# Enterprise-Physical-Security-Risk-Engine
# Enterprise India Physical Security Risk Index (GDELT 2.0 + BigQuery)

**Author:** Kirit Krishnan Nair  
**Role:** Senior Enterprise Risk Governance Specialist | Physical Security Risk Modeling  

---

## Overview
An automated, dynamic physical security risk monitoring engine built on Google Cloud Platform (GCP). The pipeline ingests telemetry from the GDELT 2.0 Global Events dataset, transforming raw spatial-event data into interactive risk matrices, geographic threat density heatmaps, and ISO 31000-aligned risk indicators in Looker Studio.

## Architecture & Data Pipeline
1. **Source Data:** `gdelt-bq.gdeltv2.events` (Filtered by CountryCode 'IN').
2. **Data Warehouse:** Google BigQuery.
3. **ETL Strategy:** Rolling 30-day dynamic partition aggregation (`SQLDATE` conversion).
4. **Data Visualization:** Looker Studio (Cross-filtered interactive dashboard).

## BigQuery SQL Ingestion Logic
```sql
CREATE OR REPLACE TABLE `coursera-prep-data-4-analysis.india_risk_index_2026.live_threat_feed` AS
SELECT
  PARSE_DATE('%Y%m%d', CAST(SQLDATE AS STRING)) AS event_date,
  ActionGeo_FullName AS location_name,
  ActionGeo_Lat AS latitude,
  ActionGeo_Long AS longitude,
  COUNT(1) AS incident_volume,
  ROUND(AVG(GoldsteinScale), 2) AS avg_stability_score,
  COUNTIF(EventRootCode = '14') AS civil_unrest_count,
  COUNTIF(EventRootCode = '18' OR EventRootCode = '19') AS violent_events_count,
  COUNTIF(EventRootCode IN ('10', '11', '12', '13')) AS operational_disruptions
FROM
  `gdelt-bq.gdeltv2.events`
WHERE
  ActionGeo_CountryCode = 'IN'
  AND SQLDATE >= CAST(FORMAT_DATE('%Y%m%d', DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY)) AS INT64)
  AND ActionGeo_FullName IS NOT NULL
GROUP BY
  event_date, location_name, latitude, longitude;
```
  ## Risk Classification Framework (ISO 31000 Alignment)
- **Civil Unrest:** CAMEO Root Code 14 (Protests, Demonstrations, Rallies)
- **Violent Incidents:** CAMEO Root Codes 18 & 19 (Assaults, Explosions, Armed Conflict)
- **Operational Disruptions:** CAMEO Root Codes 10–13 (Demand, Disapprove, Reject, Threaten)
- **Stability Metrics:** Averaged Goldstein Scale (-10.0 to +10.0 impact score)

## Live Dashboard Access
https://datastudio.google.com/reporting/e0a4beae-8f55-40fb-96af-b6cc848307ec
