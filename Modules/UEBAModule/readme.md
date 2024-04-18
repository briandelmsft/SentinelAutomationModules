# Get-UEBAInsights

## Description
This module will check the incident account entities to see if there are any User Entity Behavior Analytics events with an investigation priority.

## Supported Entity Types
* Account

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|Yes/No|When set to yes, the results of the query will be added to the Sentinel Incident Comments|
|AddIncidentTask|True/False (Default:False)|When set to true, a task will be added to the Sentinel incident to review the query results if results are found.|
|Base Module Body|Body (dynamic content)|The Body should be selected from the Dynamic content of the Base-Module response|
|IncidentTaskInstructions|Markdown Text|A list of instructions you want to include in the task|
|LookbackInDays|1-90|This defines how far back to look through the UEBA tables in Sentinel|
|MinimumInvestigationPriority|1-10|Only BehaviourAnalytics records with an InvestirgationPriority of >= this value will be considered|

## Return Properties

|Property|Description|
|---|---|
|AllEntityEventCount|Count of all related BehaviorAnalytics records|
|AllEntityInvestigationPriorityAverage|Average investigation priority of all related BehaviorAnalytics records|
|AllEntityInvestigationPriorityMax|Maximum investigation priority of all related BehaviorAnalytics records|
|AllEntityInvestigationPrioritySum|Sum of investigation priority of all related BehaviorAnalytics records|
|AnomalyCount|Count of matching account anomalies from the Anomalies table|
|AnomalyTactics|Array of unique MITRE tactics associated with matching account anomalies|
|AnomalyTacticsCount|Count of unique MITRE tactics from associated anomalies|
|DetailedResults|An array of UEBA investigration priority values by UserPrincipalName|
|InvestigationPrioritiesFound|true if any investigation priorities are found in all related BehaviorAnalytics records, otherwise false|
|ModuleName|The internal Name of the Playbook|
|ThreatIntelFound|true/false based on matching threat intelligence in BehaviorAnalytics table|
|ThreatIntelMatchCount|Count of matching BehaviorAnalytics entries with matching threat intel|


## Sample Return

```
{
  "AllEntityEventCount": 222,
  "AllEntityInvestigationPriorityAverage": 4.031073446327683,
  "AllEntityInvestigationPriorityMax": 5,
  "AllEntityInvestigationPrioritySum": 899,
  "AnomalyCount": 8,
  "AnomalyTactics": [
    "Persistence",
    "DefenseEvasion",
    "InitialAccess"
  ],
  "AnomalyTacticsCount": 3,
  "DetailedResults": [
    {
      "InvestigationPrioritySum": 180,
      "InvestigationPriorityAverage": 4,
      "InvestigationPriorityMax": 4,
      "EventCount": 45,
      "ThreatIntelMatchCount": 1,
      "UserPrincipalName": "user1@contoso.com"
    },
    {
      "InvestigationPrioritySum": 719,
      "InvestigationPriorityAverage": 4.062146892655368,
      "InvestigationPriorityMax": 5,
      "EventCount": 177,
      "ThreatIntelMatchCount": 2,
      "UserPrincipalName": "user2@contoso.com"
    }
  ],
  "InvestigationPrioritiesFound": true,
  "ModuleName": "UEBAModule",
  "ThreatIntelFound": true,
  "ThreatIntelMatchCount": 3
}
```

## Deployment

To deploy the Sentinel Triage AssistanT visit the [deployment documentation](/Docs/deployment.md).
