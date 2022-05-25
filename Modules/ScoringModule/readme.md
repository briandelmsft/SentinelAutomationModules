# Calculate-RiskScore

## Description
This module will take the outputs from other STAT modules and calculate a cumulative risk score based on the inputs

## Suported Module Inputs
* RelatedAlerts
* KQLModule

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|True/False (Default:True)|When set to true, the results of the scoring module will be added to the Sentinel Incident Comments|
|Base Module Body|Body (dynamic content)|The Body should be selected from the Dynamic content of the Base-Module response|
|ScoringData-ModuleBody|Body (dynamic content)||
|ScoringData-ScoreMultiplier|Decimal value (1 for default scoring)|Default scores will be multiplied by this value, this can be a negative value if needed to reduce cumulative score|
|ScoreingData-ScorePerItem|true/false|true if you want to score the input on a row level (per alert or record)|

## Return Properties

|Property|Description|
|---|---|
|DetailedResults|An array of each scored item with label and score|
|TotalScore|Sum of all scored items|

## Sample Return

```
{
  "DetailedResults": [
    {
      "Score": 25,
      "ScoreSource": "Bad Password KQL Query"
    },
    {
      "Score": 10,
      "ScoreSource": "Related Alerts - Initial Access Incident"
    },
    {
      "Score": 5,
      "ScoreSource": "Related Alerts - Multiple Password changes"
    }
  ],
  "TotalScore": 40
```

## Advanced Deployment

Deployment of the Sentinel Triage AssistanT should typically be performed from the [deployment template](/Deploy/readme.md), however in some cases you may wish to deploy an individual module below.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FModules%2FScoringModule%2Fazuredeploy.json)

## Post Deployment

* Grant the Logic app Microsoft Sentinel Responder RBAC role on the resource group containing Microsoft Sentinel (GrantPermissions.ps1)
