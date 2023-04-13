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
|AddIncidentTask|True/False (Default:False)|When set to true, a task will be added to the Sentinel incident to review the query results if results are found.|
|AlertKQLFilter|KQL Statement (Default:none)|Optionally, a KQL statement can be added to filter out alerts you want to exclude from this module, see Alert Filtering below for more inforomation|
|CheckAccountEntityMatches|True/False (Default:True)|When set to true, the module will look for related alerts based on the Account entity type|
|CheckHostEntityMatches|True/False (Default:True)|When set to true, the module will look for related alerts based on the Host entity type|
|CheckIPEntityMatches|True/False (Default:True)|When set to true, the module will look for related alerts based on the IP entity type|
|IncidentTaskInstructions|Markdown Text|A list of instructions you want to include in the task|
|Base Module Body|Body (dynamic content)|The Body should be selected from the Dynamic content of the Base-Module response|
|LookbackInDays|1-90|This defines how far back to look through the SecurityAlert tables in Sentinel|

### Alert Filtering

Some alerts in the SecurityAlert table may be of limited security value when performing an automated triage and you may want to filter them out so they are not considered.  The AlertKQLFilter property of this module allows you to add an optional KQL filter to limit the alerts that are returned by this module.  This filter only supports adding one or more ```| where``` statements, though other KQL may work, modifying the returned columns (reducing columns, adding columns, renaming) may cause the module to fail or produce unexpected results.

The AlertKQLFilter is applied in the KQL query after the most recent version of the alert has been returned and the entities array has been expanded using an mv-expand.  To test a filter statement in Log search, use this KQL statement to test and place your filter at the end.  Other filters, not shown below, are applied automatically in the module, such as only returning alerts that match the incidents account or ip entities.

```
SecurityAlert 
| where TimeGenerated > ago(14d) 
| summarize arg_max(TimeGenerated, *) by SystemAlertId 
| where SystemAlertId !in (currentIncidentAlerts) or isFusionIncident
| mv-expand todynamic(Entities) 
```

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