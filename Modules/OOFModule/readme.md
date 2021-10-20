# OOF Module
---
## Description
This module will check the incidient entities to see if a user is out of the office.

## Suported Entity Types
* Account

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|Yes/No|When set to yes, the results of the query will be added to the Sentinel Incident Comments|
|Entities|Entities (dynamic content)|This should be selected from the Dynamic content of the incident creation rule trigger|
|IncidentARMId|Incident ARM ID (dynamic content)|This should be selected from the Dynamic content of the incident creation rule trigger|

## Return Properties

|Property|Description|
|---|---|
|OverallOOFStatus|Returns an overall status.  If all user entities are in the same Out of Office state then it will return enabled or disabled.  If the user entities are in different states it will return inconsistent|
|PerUserStatus|An array of OOFStatus by UPN|

## Sample Return

```
{
  "OverallOOFStatus": "disabled",
  "PerUserStatus": [
    {
      "OOFStatus": "disabled",
      "UPN": "user1@contoso.com"
    },
    {
      "OOFStatus": "disabled",
      "UPN": "user2@contoso.com"
    }
  ]
}
```

## Quick Deployment

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FModules%2FOOFModule%2Fazuredeploy.json)

## Post Deployment

* Grant the Logic app managed identity access to the Microsoft Graph application permissions MailboxSettings.Read (GrantAPIPermissions.ps1)
* Grant the Logic app Azure Sentinel Responder RBAC role on the resource group containing Azure Sentinel
