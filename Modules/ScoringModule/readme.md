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
* User Entity Behavior Analytics Module
* File Module
* Microsoft Defender for Cloud Apps Module
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

### UEBA Module Scoring

Scoring for the UEBA module consists of 3 parts:

|Score Part|Explanation|
|---|---|
|InvestigationPriorityMax|The maximum investigation priority score is taken and mulitpled by the ScoreMultiplier|
|ThreatIntelMatchCount|If realted threat intelligence matches are found in the BehaviorAnalytics table, 10 * ScoreMultiplier is added to the score|
|AnomalyTacticsCount|If related anomalies around found in the Anomalies table the number of uniqure MITRE tactics is determined and the AnomalyTacticsCount * 10 * ScoreMultiplier is added to the score|

> If ScorePerItem=False, AllEntityInvestigationPriorityMax is used and the global ThreatIntelMatchCount is used instead of the entity level counts.

### File Module Scoring

When scoring the File Module the calculated score is based on (HashesLinkedToThreatCount * 10 * ScoreMultiplier).  The ScorePerItem setting has no impact on the scoring of this module.

### MDCA Module Scoring

When scoring the MDCA module, if ScorePerItem=True the score is calculated based on (AboveThresholdCount * 10 * ScoreMultiplier).  If ScorePerItem=False, the score is calculated if the AboveThresholdCount > 0 as (10 * ScoreMultiplier).

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
      }
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
|ScoringData-ScoreLabel|string (Default:ScoredModuleName)|Used to label the score outputs in the comment added to the incident|
|ScoringData-ScoreMultiplier|Decimal value (Default:1)|Default scores will be multiplied by this value, this can be a negative value which will result in the cumulative score being reduced|
|ScoreingData-ScorePerItem|true/false (Default:true)|true if you want to score the input on a row level (per alert or record)|

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

## Deployment

To deploy the Sentinel Triage AssistanT visit the [deployment documentation](/Docs/deployment.md).
