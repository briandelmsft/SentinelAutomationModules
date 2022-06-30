# Calculate-RiskScore

## Description
This module will take the outputs from other STAT modules and calculate a cumulative risk score based on the inputs

## Suported Module Inputs
* Related Alerts Module
* KQL Module
* Threat Intelligence Module
* Watchlist Module

### Related Alerts Scoring

When scoring the Related Alerts module consider the following default scores are assigned based on the Alert Severity:

|AlertSeverity|Score|
|---|---|
|High|10|
|Medium|5|
|Low|3|
|Informational|1|

> Note: If ScorePerItem=True, the sum of all alert scores will be returned.  If ScorePerItem=False, only the score of the highest severity alert will be returned.


### KQL Module Scoring

When scoring the KQL Module if ScorePerItem=True then the returned score will be 5 * ItemCount * ScoreMultiplier.  If ScorePerItem=False the returned score will be 5 * ScoreMultiplier if 1 or more results are returned

### Threat Intelligence Module Scoring

When scoring the Threat Intelligence Module if ScorePerItem=True then the returned score will be 10 * MatchedTIItemCount * ScoreMultiplier.  If ScorePerItem=False the returned score will be 10 * ScoreMultiplier if 1 or more matching pieces of TI is found

### Watchlist Module Scoring

When scoring the Watchlist Module if ScorePerItem=True then the returned score will be 10 * WatchlistMatchCount * ScoreMultiplier.  If ScorePerItem=False the returned score will be 10 * ScoreMultiplier if 1 or more watchlist match is found

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|True/False (Default:True)|When set to true, the results of the scoring module will be added to the Sentinel Incident Comments|
|Base Module Body|Body (dynamic content)|The Body should be selected from the Dynamic content of the Base-Module response|
|ScoringData-ModuleBody|Body (dynamic content)|The *Body* of a supported module you want to score|
|ScoringData-ScoreMultiplier|Decimal value (1 for default scoring)|Default scores will be multiplied by this value, this can be a negative value which will result in the cumulative score being reduced|
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
    },
    {
      "Score": -10,
      "ScoreSource": "Watchlist - Check for Trusted IP Location"
    }
  ],
  "TotalScore": 30
}
```

## Advanced Deployment

Deployment of the Sentinel Triage AssistanT should typically be performed from the [deployment template](/Deploy/readme.md), however in some cases you may wish to deploy an individual module below.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FModules%2FScoringModule%2Fazuredeploy.json)

## Post Deployment

* Grant the Logic app Microsoft Sentinel Responder RBAC role on the resource group containing Microsoft Sentinel (GrantPermissions.ps1)
