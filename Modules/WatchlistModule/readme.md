# Get-WatchlistInsights

## Description
This module will check the incident entities to see if there are any matches on a specified watchlist in Microsoft Sentinel

## Suported Entity Types
* Account (UPN)
* IP Address

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|True/False (Default:True)|When set to true, the results of the query will be added to the Sentinel Incident Comments|
|Base Module Body|Body (dynamic content)|The Body should be selected from the Dynamic content of the Base-Module response|
|WatchlistKey|ColumnName|The column name of the watchlist to match with the entity data, such as the UPN or IP Address |
|WatchlistKeyDataType|upn, ip, or cidr|The type of data in the WatchlistKey column.  Use CIDR if the WactchlistKey contains subnets using CIDR notation|
|WatchlistName|Sentinel Watchlist name|This defines how far back to look through the UEBA tables in Sentinel|

## Return Properties

|Property|Description|
|---|---|
|DetailedResults|An Array of detailed results from each item that was checked against the watchlist|
|EntitiesAnalyzedCount|Count of entities checked against the watchlist|
|EntitiesOnWatchlist|True if any entities were found on the watchlist|
|EntitiesOnWatchlistCount|Count of entities found on the watchlist|
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
  "WatchlistName": "TrustedNetworks"
}
```

## Advanced Deployment

Deployment of the Sentinel Triage AssistanT should typically be performed from the [deployment template](/Deploy/readme.md), however in some cases you may wish to deploy an individual module below.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FModules%2FWatchlistModule%2Fazuredeploy.json)

## Post Deployment

* Grant the Logic app managed identity access to the Log Analytics API application permissions Data.Read (GrantPermissions.ps1)
* Grant the Logic app Microsoft Sentinel Responder RBAC role on the resource group containing Microsoft Sentinel (GrantPermissions.ps1)
