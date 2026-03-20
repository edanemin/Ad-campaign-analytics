# 📊 Ad Campaign Analytics
### Paid Media Performance Analysis 

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![Looker Studio](https://img.shields.io/badge/Looker%20Studio-4285F4?style=for-the-badge&logo=googleanalytics&logoColor=white)

> **Business Question:** Which media source, campaign, and UTM channel drives the most efficient return on ad spend? Where are the biggest opportunities to reduce cost per lead?

---

## Live Dashboard
🔗 **[View on Looker Studio →](https://lookerstudio.google.com/reporting/a15645c1-31f5-4a2e-8857-b2a06861d944)**

---

## Repo Structure
```
Ad-campaign-analytics
┣ sql/
┃ ┗ facebook_google_united.sql
┗ README.md
```

---

## Project Summary
| | |
|---|---|
| **Data** | 3,892 ad records |
| **Period** | November 2020 – November 2022 |
| **Sources** | `facebook_ads_basic_daily` + `google_ads_basic_daily` + `facebook_adset` + `facebook_campaign` |
| **Output** | `facebook_google_united` |
| **Tools** | PostgreSQL, Looker Studio |

---

## Key Findings

### Overall Performance
| Metric | Value |
|---|---|
| Total Spend | 28.6M |
| Total Revenue | 34.9M |
| Total Leads | 12.3K |
| ROAS | 1.2 |

### Media Source Comparison
| Source | Spend | Revenue | Leads |
|---|---|---|---|
| Facebook | ~20M | ~25M | ~9K |
| Google | ~9M | ~10M | ~4K |

> Facebook accounts for approximately 2x the spend, revenue, and leads compared to Google.

### Top Performing Campaigns
| Campaign | ROAS | Note |
|---|---|---|
| Trendy | 1.91 | Highest ROAS |
| Promos | 1.44 | Strong efficiency, lower volume |
| Expansion | 1.19 | Highest spend, below-average ROAS |

> Expansion campaign consumes the largest budget but delivers one of the lowest ROAS values — a key optimization opportunity.

---

## Technical Details

### PostgreSQL — `sql/facebook_google_united.sql`
Combining and cleaning Facebook and Google ad data:
- `UNION ALL` to merge Facebook and Google tables
- `LEFT JOIN` with `facebook_campaign` and `facebook_adset` for campaign and adset names
- UTM parameters extracted from `url_parameters` using `SUBSTRING` with regex
- URL-encoded and empty UTM values replaced with `'unknown'` via `CASE` and `COALESCE`
- NULL `leads` values handled with `COALESCE`
- Rows with NULL `ad_date` and `url_parameters` filtered out

### Looker Studio
- Custom calculated fields: ROAS, CTR, CPL, CPC, CPM, CR, Reach Rate
- `PARSE_DATE('%F', ad_date)` for date type conversion
- Conditional formatting to flag Reach Rate > 100% as data anomaly

---

## Business Recommendations
| # | Recommendation | Rationale |
|---|---|---|
| 1 | **Reallocate Expansion budget** | Highest spend but lowest ROAS — shift budget to Trendy and Promos |
| 2 | **Fix UTM tracking** | Missing UTM parameters prevent accurate channel attribution |
| 3 | **Investigate spend spikes** | July 2021 and April 2022 peaks need root cause analysis |
| 4 | **Scale Google campaigns** | Lower spend with comparable ROAS — room to grow |

---

## Notes
- Campaigns with missing UTM parameters are labeled as `"unknown"`.
- Reach Rate >100% indicates a data anomaly (Brand campaign).

---

## 👩‍💻 Author
Eda Nilsun EMİN · March 2026  
🔗 [LinkedIn](https://www.linkedin.com/in/eda-nilsun-emin-51225810b)

---
