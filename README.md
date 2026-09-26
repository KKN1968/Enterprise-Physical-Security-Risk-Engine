# Enterprise India Physical Security Threat Activity Monitor

**Author:** Kirit Krishnan Nair  
**Role:** Senior Enterprise Risk Governance Specialist | Threat Intelligence & Analytics  

---

## Overview & Scope
An open-source threat-activity monitoring prototype built on Google Cloud Platform (GCP). The pipeline ingests telemetry from the GDELT 2.0 Global Events stream, aggregating spatial-event signals to provide dynamic situational awareness across Indian geographic nodes.

> **Methodological Note:** This system measures reported external threat telemetry and media-coded event velocity. It serves as an ISO 31000-informed decision-support tool for situational awareness, but does not constitute a full enterprise risk assessment (which requires asset criticality, facility exposure, vulnerability, and internal control effectiveness data).

## System Architecture
1. **Data Source:** `gdelt-bq.gdeltv2.events` (Filtered by `CountryCode = 'IN'`).
2. **Data Warehouse:** Google BigQuery (SQL dynamic rolling 30-day window excluding incomplete current date).
3. **Analytics & Visualization:** Looker Studio (Cross-filtered interactive dashboard).

## Risk & Taxonomy Framework Alignment
- **Civil Unrest:** CAMEO Root Code 14 (Protests, Rallies, Demonstrations).
- **Violent Incidents:** CAMEO Root Codes 18, 19, & 20 (Assaults, Explosions, Mass Violence).
- **Escalatory Actions:** CAMEO Root Codes 10–13 (Demands, Disapprovals, Rejections, Threats).
- **Stability Proxy:** Averaged Goldstein Scale (-10.0 to +10.0 impact score).

## Repository Structure
- `/sql/live_threat_feed.sql`: Ingestion and dynamic partition query logic.
- `/docs/methodology.md`: Comprehensive breakdown of CAMEO classifications, Goldstein scale methodology, and limitations.

## Live Interactive Dashboard
[Access Live Threat Activity Monitor](https://datastudio.google.com/reporting/e0a4beae-8f55-40fb-96af-b6cc848307ec)
