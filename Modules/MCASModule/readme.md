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

## Pre Deployment

You will need to get two information from your Microsoft Cloud App Security portal. You need the MCAS API URL. You can get it followinf those steps:

1. Connect to your Microsoft Cloud App Security portal and click on the **Parameters** menu and select **Security extensions**. Then click on **Add Token**. 
![Step 1](images/Step_1.jpg)

2. Note the Token displayed on the screen as well as the API url, you will need it when you import the Logic.
![Step 2](images/Step_0.jpg)

3. When deploying the template, type in the API Key and URL in the corresponding fields.
![Step 3](images/Step_3.jpg)

This will create a Key Vault storing the API Key in the selected resource group. The Logic App will then retrieve the key to query the MCAS API usign the URL you have specified.
If you do not perform these tasks before the deployement, you can leave the default value of the ARM template and later modify the variables in the Logic App.

## Quick Deployment

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FModules%2FMCASModule%2Fazuredeploy.json)

## Post Deployment

- Grant the Logic App managed identity the Microsoft Sentinel Responder RBAC role on the resource group containing Microsoft Sentinel. (GrantPermissions.ps1)

## Additional Links
* [Understand the investigation priority score](https://docs.microsoft.com/en-us/cloud-app-security/tutorial-ueba#understand-the-investigation-priority-score)
