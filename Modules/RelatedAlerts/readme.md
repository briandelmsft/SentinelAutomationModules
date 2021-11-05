# Get-RelatedAlerts

## Description
This module will check the incidient entities to see if there are any other alerts about those same entities.

## Suported Entity Types
* Account
* Host
* IP Address

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|Yes/No|When set to yes, the results of the query will be added to the Sentinel Incident Comments|
|CheckAccountEntityMatches|Yes/No|When set to yes, the module will look for related alerts based on the Account entity type|
|CheckHostEntityMatches|Yes/No|When set to yes, the module will look for related alerts based on the Host entity type|
|CheckIPEntityMatches|Yes/No|When set to yes, the module will look for related alerts based on the IP entity type|
|Entities|Entities (dynamic content)|This should be selected from the Dynamic content of the incident creation rule trigger|
|LookbackInDays|1-90|This defines how far back to look through the SecurityAlert tables in Sentinel|

## Return Properties

|Property|Description|
|---|---|
|DetailedResults|An array of each related alert that was found|
|RelatedAlertsCount|Number of related alerts found. This number may exceed the sum of other related alert counts as an alert may be related to more than one entity type.|
|RelatedAlertsFound|true/false indicating if related alerts were found|
|RelatedAccountAlertsCount|Number of alerts related to account entity found|
|RelatedAccountAlertsFound|true/false indicating if alerts related to account entity were found|
|RelatedHostAlertsCount|Number of alerts related to host entity found|
|RelatedHostAlertsFound|true/false indicating if alerts related to host entity were found|
|RelatedIPAlertsCount|Number of alerts related to ip entity found|
|RelatedIPAlertsFound|true/false indicating if alerts related to ip entity were found|

## Sample Return

```
{
  "DetailedResults": [
    {
      "StartTime": "2021-11-03T12:16:29.541Z",
      "DisplayName": "Alert1",
      "AlertName": "Alert1",
      "AlertSeverity": "Informational",
      "SystemAlertId": "55d2036d-e471-4210-bfcd-fead43b85cf8",
      "ProviderName": "ASI Scheduled Alerts",
      "AccountEntityMatch": true,
      "IPEntityMatch": true,
      "HostEntityMatch": true
    },
    {
      "StartTime": "2021-11-01T20:23:45.386Z",
      "DisplayName": "Alert2",
      "AlertName": "Alert2",
      "AlertSeverity": "Informational",
      "SystemAlertId": "5342baa5-531d-7496-6f5f-b3e9c4a077dd",
      "ProviderName": "ASI Scheduled Alerts",
      "AccountEntityMatch": true,
      "IPEntityMatch": false,
      "HostEntityMatch": true
    }
  ],
  "RelatedAccountAlertsCount": 2,
  "RelatedAccountAlertsFound": true,
  "RelatedAlertsCount": 2,
  "RelatedAlertsFound": true,
  "RelatedHostAlertsCount": 2,
  "RelatedHostAlertsFound": true,
  "RelatedIPAlertsCount": 1,
  "RelatedIPAlertsFound": true
}
```

## Quick Deployment

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FModules%2FRelatedAlerts%2Fazuredeploy.json)

## Post Deployment

* Grant the Logic app managed identity access to the Log Analytics API application permissions Data.Read (GrantPermissions.ps1)
* Grant the Logic app Azure Sentinel Responder RBAC role on the resource group containing Azure Sentinel (GrantPermissions.ps1)
