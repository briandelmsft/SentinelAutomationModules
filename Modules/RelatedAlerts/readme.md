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
|AddIncidentComments|True/False (Default:True)|When set to true, the results of the query will be added to the Sentinel Incident Comments|
|CheckAccountEntityMatches|True/False (Default:True)|When set to true, the module will look for related alerts based on the Account entity type|
|CheckHostEntityMatches|True/False (Default:True)|When set to true, the module will look for related alerts based on the Host entity type|
|CheckIPEntityMatches|True/False (Default:True)|When set to true, the module will look for related alerts based on the IP entity type|
|Base Module Body|Body (dynamic content)|The Body should be selected from the Dynamic content of the Base-Module response|
|LookbackInDays|1-90|This defines how far back to look through the SecurityAlert tables in Sentinel|

## Return Properties

|Property|Description|
|---|---|
|AllTactics|An array of unique MITRE tactics including all tactics linked directly to the incident as well as any found in related alerts|
|AllTacticsCount|Count of unique MITRE tactics from AllTactics|
|DetailedResults|An array of each related alert that was found|
|HighestSeverityAlert|The severity of the highest severity alert found (High, Medium, Low or Informational)|
|ModuleName|The internal Name of the Playbook|
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
  "AllTactics": ["InitialAccess","Impact"],
  "AllTacticsCount": 2,
  "DetailedResults": [
    {
      "StartTime": "2021-11-03T12:16:29.541Z",
      "DisplayName": "Alert1",
      "AlertSeverity": "Informational",
      "SystemAlertId": "55d2036d-e471-4210-bfcd-fead43b85cf8",
      "ProviderName": "ASI Scheduled Alerts",
      "Tactics": "InitialAccess",
      "AccountEntityMatch": true,
      "IPEntityMatch": true,
      "HostEntityMatch": true
    },
    {
      "StartTime": "2021-11-01T20:23:45.386Z",
      "DisplayName": "Alert2",
      "AlertSeverity": "Informational",
      "SystemAlertId": "5342baa5-531d-7496-6f5f-b3e9c4a077dd",
      "ProviderName": "ASI Scheduled Alerts",
      "Tactics": "Impact",
      "AccountEntityMatch": true,
      "IPEntityMatch": false,
      "HostEntityMatch": true
    }
  ],
  "HighestSeverityAlert": "Informational",
  "ModuleName": "RelatedAlerts",
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

## Deployment

To deploy the Sentinel Triage AssistanT visit the [deployment documentation](/Docs/deployment.md).