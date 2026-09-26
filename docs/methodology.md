# Methodology & Taxonomy Specifications

## 1. Analytical Purpose & Scope
The **Enterprise India Physical Security Threat Activity Monitor** is an open-source threat-telemetry pipeline. It ingests global media event streams to provide spatial and temporal situational awareness across Indian geographic nodes.

---

## 2. Framework & Taxonomy Mapping
This system leverages the **Conflict and Mediation Event Observations (CAMEO)** taxonomy:
- **Civil Unrest:** CAMEO Root Code `14` (Protests, Demonstrations, Rallies).
- **Violent Incidents:** CAMEO Root Codes `18` (Assault), `19` (Explosions), & `20` (Unconventional Mass Violence).
- **Escalatory Actions:** CAMEO Root Codes `10` (Demand), `11` (Disapprove), `12` (Reject), & `13` (Threaten).

---

## 3. Goldstein Scale & Stability Proxy
The **Goldstein Scale** assigns a numeric score to each event code ranging strictly from **-10.0 (maximum conflict/instability)** to **+10.0 (maximum cooperation/stability)**.
- **Aggregation Math:** Scores are averaged dynamically across event volumes per geographic node over a completed past rolling window.
- **Interpretation Rule:** Locations exhibiting the **most negative scores** reflect the highest degree of conflict intensity and operational volatility.

---

## 4. Pipeline Architecture & Rolling-Window Logic
- **Data Source:** `gdelt-bq.gdeltv2.events` (`ActionGeo_CountryCode = 'IN'`).
- **Warehouse:** Google BigQuery dynamic SQL query.
- **Time Window Filter:** Captures completed daily data (`SQLDATE < CURRENT_DATE()`) over a rolling historical period to eliminate current-day partial ingestion drop-offs.

---

## 5. Methodological Limitations & Boundary Conditions
1. **Media Telemetry Bias:** GDELT tracks news reporting frequency. Fluctuations in event volume can reflect shifts in open-source media coverage intensity rather than ground-truth event probability.
2. **Geographic Granularity:** `ActionGeo_FullName` telemetry contains mixed spatial entities (states, cities, and regional aliases).
3. **Enterprise Risk Distinction:** In accordance with **ISO 31000** governance standards, this tool monitors *external threat telemetry*. It does not evaluate internal facility vulnerability, asset exposure, or impact consequences, and must be paired with asset-level exposure data for full corporate risk assessments.
