# Get-OOFDetails

## Description
This module will check the incidient entities to see if a user is out of the office.

## Suported Entity Types
* Account

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|Yes/No|When set to yes, the results of the query will be added to the Sentinel Incident Comments|
|Base Module Body|Body (dynamic content)|The Body should be selected from the Dynamic content of the Base-Module response|

## Return Properties

|Property|Description|
|---|---|
|OverallOOFStatus|Returns an overall status.  If all user entities are in the same Out of Office state then it will return enabled or disabled.  If the user entities are in different states it will return inconsistent|
|PerUserStatus|An array of OOFStatus by UPN|

## Sample Return

```
{
  "AllUsersInOffice": true,
  "AllUsersOutOfOffice": false,
  "DetailedResults": [
    {
      "ExternalMessage": "",
      "InternalMessage": "",
      "OOFStatus": "disabled",
      "UPN": "user1@contoso.com"
    }
  ],
  "UsersInOffice": 1,
  "UsersOutOfOffice": 0,
  "UsersUnknown": 0
}
```

## Quick Deployment

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FModules%2FOOFModule%2Fazuredeploy.json)

## Post Deployment

* Grant the Logic app managed identity access to the Microsoft Graph application permissions MailboxSettings.Read (GrantPermissions.ps1)
* Grant the Logic app Microsoft Sentinel Responder RBAC role on the resource group containing Microsoft Sentinel (GrantPermissions.ps1)
