# Get-MCASInvestigationScore

## Description
This module will get the MCAS Investigation Score of the account entities of the incidient.

## Suported Entity Types
* Account

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|Yes/No|When set to yes, the results of the query will be added to the Sentinel Incident Comments|
|Entities|Entities (dynamic content)|This should be selected from the Dynamic content of the incident creation rule trigger|
|IncidentARMId|Incident ARM ID (dynamic content)|This should be selected from the Dynamic content of the incident creation rule trigger|
|ScoreThreshold|Score (integer)|Minimum investigation score for a user|

## Return Properties

|Property|Description|
|---|---|
|countAboveThrehold|Count of users in the entities for which the investigation score was higher than the threshold|
|maxScore|The maximum investigation score of all users in the entities|
|perUser|An array of user|
|currentScore|The current investigation score for the user|
|status|Returns if the score was found in MCAS|
|userId|The Azure AD ObjectId of the user|
|userLink|A link to the user's page in MCAS|
|userPrincipalName|The UserPrincipalName of the user|
|scoreThreshold|The score threshold passed in the trigger for reference|

## Sample Return

```
{
  "countAboveThrehold": 1,
  "maxScore": 284,
  "perUser": [
    {
      "currentScore": 284,
      "status": "Found",
      "userId": "2b4cfc7a-9538-4b69-9ff8-7a5355fd0a49",
      "userLink": "<a href=https://contoso.portal.cloudappsecurity.com/#/users/eyJpZCI6IjJiNGNmYz...>Link</a>",
      "userPrincipalName": "bob@contoso.com"
    },
    {
      "status": "Score not found in MCAS",
      "userId": "c86eede6-4a7c-478e-983c-0d7db482f4a6",
      "userLink": "<a href=https://contoso.portal.cloudappsecurity.com/#/users/eyJpZCI6ImM4NmVlZG...>Link</a>",
      "userPrincipalName": "contoso.com"
    }
  ],
  "scoreThreshold": 50
}
```

## Pre Deployment

You will need to get two information from your Microsoft Cloud App Security portal. You need the MCAS API URL. You can get it followinf those steps:

1. Connect to your Microsoft Cloud App Security portal and click on the **Help** menu and then click on **About**. Note the URL mentionned in the screen you will need it when you import the Logic App. 
![Step 0](images/Step_0.jpg)

2. Then click on the **Parameters** menu and select **Security extensions**. Then click on **Add Token**. Note the Token displayed on the screen as you will need it when you import the Logic.
![Step 1](images/Step_1.jpg)

3. When deploying the template, type in the API Key and URL in the corresponding fields.
![Step 3](images/Step_3.jpg)

This will create a Key Vault storing the API Key in the selected resource group. The Logic App will then retrieve the key to query the MCAS API usign the URL you have specified.
If you do not perform these tasks before the deployement, you can leave the default value of the ARM template and later modify the variables in the Logic App.

## Quick Deployment

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FModules%2FMCASModule%2Fazuredeploy.json)

## Post Deployment

- Grant the Logic App managed identity the permissions User.Read.All on the Azure Graph API (GrantAPIPermissions.ps1).
- Grant the Logic App managed identity the Azure Sentinel Responder RBAC role on the resource group containing Azure Sentinel.

## Additional Links
* [Understand the investigation priority score](https://docs.microsoft.com/en-us/cloud-app-security/tutorial-ueba#understand-the-investigation-priority-score)
