# Calculate-RiskScore

## Description

This module will take the outputs from other STAT modules and calculate a cumulative risk score based on the inputs

## Suported Module Inputs

* AAD Risks Module
* Microsoft Defender for Endpoint Module
* Related Alerts Module
* KQL Module
* Threat Intelligence Module
* Watchlist Module
* Custom Content Scoring

### AAD Risks Scoring

When scoring AAD Risks module the following default scores are assigned based on the user risk level in Azure AD Identity Protection

|Identity Protection Risk Level|Score|
|---|---|
|High|10|
|Medium|5|
|Low|3|
|None|0|

> Note: If ScorePerItem=True, the sum of all user scores will be returned.  If ScorePerItem=False, only the score of the highest severity user will be returned.

### Microsoft Defender for Endpoint Scoring

When scoring the Defender for Endpoint module, the devices risk score will be calcuated from the UsersHighestRiskScore, HostsHighestRiskScore and IPsHighestRiskScore values from the MDE module.  If ScorePerItem=True, the sum of the 3 values will be returned as the risk score, otherwise only the maximum value will be returned.

|MDE HighestRiskScore|Score|
|---|---|
|High|10|
|Medium|5|
|Low|3|
|Informational|1|

### Related Alerts Scoring

When scoring the Related Alerts module consider the following default scores are assigned based on the Alert Severity:

|AlertSeverity|Score|
|---|---|
|High|10|
|Medium|5|
|Low|3|
|Informational|1|

> Note: If ScorePerItem=True, the sum of all alert scores will be returned.  If ScorePerItem=False, only the score of the highest severity alert will be returned.

Additionally, a score of 10 is added per unique MITRE tactic associated with the incident and any related alerts.

### KQL Module Scoring

When scoring the KQL Module if ScorePerItem=True then the returned score will be 5 * ItemCount * ScoreMultiplier.  If ScorePerItem=False the returned score will be 5 * ScoreMultiplier if 1 or more results are returned

### Threat Intelligence Module Scoring

When scoring the Threat Intelligence Module if ScorePerItem=True then the returned score will be 10 * MatchedTIItemCount * ScoreMultiplier.  If ScorePerItem=False the returned score will be 10 * ScoreMultiplier if 1 or more matching pieces of TI is found

### Watchlist Module Scoring

When scoring the Watchlist Module if ScorePerItem=True then the returned score will be 10 * WatchlistMatchCount * ScoreMultiplier.  If ScorePerItem=False the returned score will be 10 * ScoreMultiplier if 1 or more watchlist match is found

### Custom Content Scoring

In addition to scoring STAT modules, the Scoring module can also incorporate score data from other sources such as 3rd party threat intelligence, 3rd party vulnerability management systems and other Microsoft sources not presently covered by STAT.

To add custom content to the scoring module you will need to retieve the necessary information for your score from the source, determine an appropriate score to assign and then format the message to send to the scoring module.

#### Custom Sample input for Scoring Module

<table>
<tr><td>Module Input</td><td>Value</td></tr>
<tr><td>Module Body</td><td>

```json
{
   "ModuleName": "Custom",
   "ScoringData": [
      {
         "Score": 5,
         "ScoreLabel": "Virus Total - Medium Risk"
      },
      {
         "Score": 10,
         "ScoreLabel": "Custom Vulnerability Management Score"
      },
   ]
}
```

</td></tr>
<tr><td>Score Label</td><td>This field is ignored when sending custom data, the label from the JSON data in Module Body will be used</td></tr>
<tr><td>Score Multiplier</td><td>The Score passed in the Module Body will be multiplied by this value</td></tr>
<tr><td>Score Per Item</td><td>This field is ignored when sending custom data, all scores in the array will be processed regardless of this setting</td></tr>
</table>

> Note: Each item in the ScoringData array must include a Score property as an integer. If this property is not included, or it is not an integer the score item will be dropped.

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
