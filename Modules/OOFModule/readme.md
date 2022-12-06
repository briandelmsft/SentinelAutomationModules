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

## Deployment

To deploy the Sentinel Triage AssistanT visit the [deployment documentation](/Docs/deployment.md).