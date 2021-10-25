# Get-RelatedAlerts

## Description
This module will check the incidient entities to see if there are any other alerts on the same entities.

## Suported Entity Types
* Account
* IP Address

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|Yes/No|When set to yes, the results of the query will be added to the Sentinel Incident Comments|
|CheckAccountEntityMatches|Yes/No|When set to yes, the module will look for related alerts based on the Account entity type|
|CheckIPEntityMatches|Yes/No|When set to yes, the module will look for related alerts based on the IP entity type|
|Entities|Entities (dynamic content)|This should be selected from the Dynamic content of the incident creation rule trigger|
|IncidentARMId|Incident ARM ID (dynamic content)|This should be selected from the Dynamic content of the incident creation rule trigger|
|LookbackInDays|1-90|This defines how far back to look through the SecurityAlert tables in Sentinel|
|WorkspaceId|Workspace ID (dynamic content)|This should be selected from the Dynamic content of the incident creation rule trigger|

## Return Properties

|Property|Description|
|---|---|
|DetailedResults|An array of each related alert that was found|
|RelatedAlertsCount|Number of related alerts found|
|RelatedAlertsFound|true/false indicating if related alerts were found|

## Sample Return

```
{
  "DetailedResults": [
    {
      "StartTime": "2021-10-25T15:40:05.341Z",
      "DisplayName": "Alert Display Name",
      "AlertName": "Alert Name",
      "AlertSeverity": "Informational",
      "SystemAlertId": "e10dd976-4e15-4144-3ae7-55c660f9aebc",
      "ProviderName": "ASI Scheduled Alerts",
      "MatchedEntityTypes": "[\"Account\",\"Ip\",\"Host\"]"
    }
  ],
  "RelatedAlertsCount": 1,
  "RelatedAlertsFound": true
}
```

## Quick Deployment

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FModules%2FRelatedAlerts%2Fazuredeploy.json)

## Post Deployment

* Grant the Logic app managed identity access to the Log Analytics API application permissions Data.Read (GrantPermissions.ps1)
* Grant the Logic app Azure Sentinel Responder RBAC role on the resource group containing Azure Sentinel (GrantPermissions.ps1)
