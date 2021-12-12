# Get-MCASInvestigationScore

## Description
This module will get the MCAS Investigation Score of the account entities of the incidient.

## Suported Entity Types
* Account

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|Yes/No|When set to yes, the results of the query will be added to the Sentinel Incident Comments|
|Entities|Entities (dynamic content)|This should be selected from the Dynamic content|
|ScoreThreshold|Score (integer)|Minimum investigation score for a user|

## Return Properties

|Property|Description|
|---|---|
|AnalysedEntities|Number of entities analyzed|
|AboveThreholdCount|Number of accounts foud above the specified threshold|
|MaximumScore|Maximum score found for all entities|
|DetailedResults|An array of user with their respective score|

## Sample Return

```
{
  "AboveThreholdCount": 0,
  "AnalyzedEntities": 1,
  "DetailedResults": [
    {
      "ThreatScore": 270,
      "UserId": "312b4fab-fa2e-43d4-9885-5a78ae6772b9",
      "UserPrincipalName": "bob@xontoso.com"
    }
  ],
  "MaximumScore": 270
}
```

## Advanced Deployment

Deployment of the Sentinel Triage AssistanT should typically be performed from the [deployment template](/Deploy/readme.md), however in some cases you may wish to deploy an individual module below.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FModules%2FMCASModule%2Fazuredeploy.json)

## Post Deployment

- Grant the Logic app managed identity access to the Microsoft Cloud App Security application permissions investigation.read (GrantPermissions.ps1)
- Grant the Logic App managed identity the Microsoft Sentinel Responder RBAC role on the resource group containing Microsoft Sentinel. (GrantPermissions.ps1)

## Additional Links
* [Understand the investigation priority score](https://docs.microsoft.com/en-us/cloud-app-security/tutorial-ueba#understand-the-investigation-priority-score)
* [Using identities instead of API keys to access the API](https://docs.microsoft.com/en-us/defender-cloud-apps/api-authentication-application)
