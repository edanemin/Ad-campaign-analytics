WITH facebook_google_united AS (
SELECT 
ad_date, 
c.campaign_name, 
a.adset_name, spend, 
impressions, 
reach, 
clicks, 
coalesce(leads, 0) as leads, 
value, 
'facebook' AS media_source,
      CASE 
    WHEN SUBSTRING(url_parameters FROM 'utm_campaign=([^&]+)') IS NULL THEN 'unknown'
    WHEN SUBSTRING(url_parameters FROM 'utm_campaign=([^&]+)') LIKE '%%D%' THEN 'unknown'
    ELSE SUBSTRING(url_parameters FROM 'utm_campaign=([^&]+)')
END AS utm_campaign,
CASE
    WHEN SUBSTRING(url_parameters FROM 'utm_medium=([^&]+)') IS NULL THEN 'unknown'
    ELSE SUBSTRING(url_parameters FROM 'utm_medium=([^&]+)')
END AS utm_medium
FROM facebook_ads_basic_daily f
left JOIN facebook_campaign c on f.campaign_id = c.campaign_id
left JOIN facebook_adset a on f.adset_id = a.adset_id
union ALL
SELECT 
ad_date, 
campaign_name, 
adset_name, 
spend, 
impressions, 
reach, 
clicks, 
coalesce(leads, 0) as leads, 
value, 
'google' AS media_source,
     CASE 
    WHEN SUBSTRING(url_parameters FROM 'utm_campaign=([^&]+)') IS NULL THEN 'unknown'
    WHEN SUBSTRING(url_parameters FROM 'utm_campaign=([^&]+)') LIKE '%%D%' THEN 'unknown'
    ELSE SUBSTRING(url_parameters FROM 'utm_campaign=([^&]+)')
END AS utm_campaign,
CASE
    WHEN SUBSTRING(url_parameters FROM 'utm_medium=([^&]+)') IS NULL THEN 'unknown'
    ELSE SUBSTRING(url_parameters FROM 'utm_medium=([^&]+)')
END AS utm_medium
FROM google_ads_basic_daily)
SELECT DISTINCT* FROM facebook_google_united
WHERE ad_date is not NULL;
