# Get-OOFDetails

## Description
This module will check the incidient entities to see if a user has configured Automatic Replies on their Office 365 mailbox.

## Suported Entity Types
* Account

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|True/False (Default:True)|When set to true, the results of the query will be added to the Sentinel Incident Comments|
|Base Module Body|Body (dynamic content)|The Body should be selected from the Dynamic content of the Base-Module response|

## Return Properties

|Property|Description|
|---|---|
|AllUsersInOffice|true/false if all checked users have Automatic Replies disabled|
|AllUsersOutOfOffice|true/false if all checked users have Automatic Replies enabled|
|DetailedResults|An array of Automatic Reply information for by user|
|UsersInOffice|Integer representing number of users with Automatic Replies disabled|
|UsersOutOfOffice|Integer representing number of users with Automatic Replies enabled|
|UsersUnknown|Integer representing number of users with an unknown Automatic Replies status, this could be due to the user not having a mailbox in Office 365 or other issues|

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

## Advanced Deployment

Deployment of the Sentinel Triage AssistanT should typically be performed from the [deployment template](/Deploy/readme.md), however in some cases you may wish to deploy an individual module below.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FModules%2FOOFModule%2Fazuredeploy.json)

## Post Deployment

* Grant the Logic app managed identity access to the Microsoft Graph application permissions MailboxSettings.Read (GrantPermissions.ps1)
* Grant the Logic app Microsoft Sentinel Responder RBAC role on the resource group containing Microsoft Sentinel (GrantPermissions.ps1)
