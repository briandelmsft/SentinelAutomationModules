# Get-MCASInvestigationScore

## Description
This module will get the MCAS Investigation Score of the account entities of the incidient.

## Suported Entity Types
* Account

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|True/False (Default:True)|When set to true, the results of the query will be added to the Sentinel Incident Comments|
|Base Module Body|Body (dynamic content)|The Body should be selected from the Dynamic content of the Base-Module response|
|ScoreThreshold|Score (integer)|Minimum investigation score for a user|

## Return Properties

|Property|Description|
|---|---|
|AnalysedEntities|Number of entities analyzed|
|AboveThreholdCount|Number of accounts foud above the specified threshold|
|MaximumScore|Maximum score found for all entities|
|ModuleName|The internal Name of the Playbook|
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
  "MaximumScore": 270,
  "ModuleName": "MCASModule"
}
```

## Advanced Deployment

Deployment of the Sentinel Triage AssistanT should typically be performed from the [deployment template](/Deploy/readme.md), however in some cases you may wish to deploy an individual module below.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FModules%2FMCASModule%2Fazuredeploy.json)

## Post Deployment

This module needs the API URL of your Microsoft Defender for Cloud Apps tenant. You can find this URL in the portal https://portal.cloudappsecurity.com/ by following these steps:
![image](https://user-images.githubusercontent.com/22434561/153331954-c072f23d-1e3e-4d69-bf1c-448fa27e92ec.png)
1. Click on the ❔ icone on the top right
2. Click on the About item
3. Copy the URL you see in the PORTAL URL section (note that is has the syntax https://<tenantname>.<tenantregion>.portal.cloudappsecurity.com).
Then you can add this URL (as-is, without a trainling slash) in the logic app itself. When you edit the logic app for this module and open the designer, you can enter the URL in the first step:

  ![image](https://user-images.githubusercontent.com/22434561/153331924-2c67e3f0-1685-4996-a8a4-1e3a167f4b0b.png)

If you do not add the URL, the module will try to determine the correct URL alone by trying all common tenant regions. This will be in a best effort mode and might not work consistently. If no valid URL can be identified, the module will fail and return a 404 error.
  
You also need to grant the following permissions:
- Grant the Logic app managed identity access to the Microsoft Cloud App Security application permissions investigation.read (GrantPermissions.ps1)
- Grant the Logic App managed identity the Microsoft Sentinel Responder RBAC role on the resource group containing Microsoft Sentinel. (GrantPermissions.ps1)

## Additional Links
* [Understand the investigation priority score](https://docs.microsoft.com/en-us/cloud-app-security/tutorial-ueba#understand-the-investigation-priority-score)
* [Using identities instead of API keys to access the API](https://docs.microsoft.com/en-us/defender-cloud-apps/api-authentication-application)
