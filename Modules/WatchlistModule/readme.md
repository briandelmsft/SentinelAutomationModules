# Get-WatchlistInsights

## Description
This module will check the incident entities to see if there are any matches on a specified watchlist in Microsoft Sentinel

## Suported Entity Types
* Account (UPN)
* IP Address
* Host (FQDN)

> Note: For best results with host entities, the WatchlistKey should be in FQDN format (hostname.contoso.com) although the module will also attempt hostname matches.

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|True/False (Default:True)|When set to true, the results of the query will be added to the Sentinel Incident Comments|
|Base Module Body|Body (dynamic content)|The Body should be selected from the Dynamic content of the Base-Module response|
|WatchlistKey|ColumnName|The column name of the watchlist to match with the entity data, such as the UPN or IP Address.  If the WatchlistKey has a space in it, you must enter the key in the following format: ['Key Name'] |
|WatchlistKeyDataType|upn, ip, cidr or fqdn|The type of data in the WatchlistKey column.  Use CIDR if the WactchlistKey contains subnets using CIDR notation|
|WatchlistAlias|Sentinel Watchlist Alias|This is the Alias of the Watchlist in Sentinel you want to check.|

## Return Properties

|Property|Description|
|---|---|
|DetailedResults|An Array of detailed results from each item that was checked against the watchlist|
|EntitiesAnalyzedCount|Count of entities checked against the watchlist|
|EntitiesOnWatchlist|True if any entities were found on the watchlist|
|EntitiesOnWatchlistCount|Count of entities found on the watchlist|
|ModuleName|The internal Name of the Playbook|
|WatchListName|Name of the watchlist that was queried|


## Sample Return

```
{
  "DetailedResults": [
    {
      "OnWatchlist": false,
      "EntityData": "40.126.28.11"
    }
  ],
  "EntitiesAnalyzedCount": 1,
  "EntitiesOnWatchlist": false,
  "EntitiesOnWatchlistCount": 0,
  "ModuleName": "WatchlistModule",
  "WatchlistName": "TrustedNetworks"
}
```

## Deployment

To deploy the Sentinel Triage AssistanT visit the [deployment documentation](/Docs/deployment.md).
