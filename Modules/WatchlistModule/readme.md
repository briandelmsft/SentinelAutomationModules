# Get-WatchlistInsights

## Description
This module will check the incident entities to see if there are any matches on a specified watchlist in Azure Sentinel

## Suported Entity Types
* Account (UPN)
* IP Address

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|Yes/No|When set to yes, the results of the query will be added to the Sentinel Incident Comments|
|Entities|Entities (dynamic content)|This should be selected from the Dynamic content of the incident creation rule trigger|
|IncidentARMId|Incident ARM ID (dynamic content)|This should be selected from the Dynamic content of the incident creation rule trigger|
|WatchlistKey|ColumnName|The column name of the watchlist to match with the entity data, such as the UPN or IP Address |
|WatchlistKeyDataType|upn, ip, or cidr|The type of data in the WatchlistKey column.  Use CIDR if the WactchlistKey contains subnets using CIDR notation|
|WatchlistName|Sentinel Watchlist name|This defines how far back to look through the UEBA tables in Sentinel|
|WorkspaceId|Workspace Id (dynamic content)|This should be selected from the Dynamic content of the incident creation rule trigger|

## Return Properties

|Property|Description|
|---|---|
|DetailedResults|An Array of detailed results from each item that was checked against the watchlist|
|OnWatchlist|true/false, if item is on the Watchlist|
|Status|Success/Failure, if the watchlist check was successful|
|WatchListName|Name of the watchlist that was queried|


## Sample Return

```
{
  "DetailedResults": [
    {
      "OnWatchlist": false,
      "EntityData": "111.222.111.222"
    }
  ],
  "OnWatchlist": false,
  "Status": "Success",
  "WatchListName": "IP"
}
```

## Quick Deployment

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FModules%2FWatchlistModule%2Fazuredeploy.json)

## Post Deployment

* Grant the Logic app managed identity access to the Log Analytics API application permissions Data.Read (GrantAPIPermissions.ps1)
* Grant the Logic app Azure Sentinel Responder RBAC role on the resource group containing Azure Sentinel
