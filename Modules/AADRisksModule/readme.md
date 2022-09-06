# Get-AADUserRisksInfo

## Description
This module will retrieve the level of risk of the users in Azure AD Identity Protection as well as the following information if requested:
* Number of MFA fraud report for the specified entities
* Number of MFA failure (the user denied the MFA request or the MFA request timed out) for the specified entities

## Suported Entity Types
* Accounts

## Trigger Parameters

Trigger name: **triage**

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|True/False (Default:True)|When set to true, the results of the query will be added to the Sentinel Incident Comments|
|Base Module Body|Body (dynamic content)|The Body should be selected from the Dynamic content of the Base-Module response|
|LookbackInDays|1-90|This defines how far back to look through the SecurityAlert tables in Sentinel|
|MFAFailureLookup|True/False (Default:True)|This enables the lookup the SigninLogs table for MFA failures|
|MFAFraudLookup|True/False (Default:True)|This enables the lookup the AuditLogs table for MFA fraud reports|


## Return Properties

|Property|Description|
|---|---|
|AnalyzedEntities|Returns the number of entities analyzed (returns 0 if no Account entities were found)|
|HighestRiskLevel|Returns the highest risk level found in Azure AD for all entities(returns unknown if no Account entities were found)|
|FailedMFATotalCount|Returns the total failed MFA request in the SigninLogs table for all entities (returns 0 if no Account entities were found)|
|MFAFraudTotalCount|Returns the total MFA fraud reports in the AuditLogs table for all entities (returns 0 if no Account entities were found)|
|ModuleName|The internal Name of the Playbook|
|DetailedResults|An array containing the details for each entity|

## Sample Return

```
{
  "AnalyzedEntities": 2,
  "FailedMFATotalCount": 31,
  "HighestRiskLevel": "low",
  "MFAFraudTotalCount": 1,
  "ModuleName": "AADRisksModule",
  "DetailedResults": [
    {
      "UserFailedMFACount": 0,
      "UserMFAFraudCount": 1,
      "UserId": "17de02b6-b883-4f4f-9acd-02ec09d160cd",
      "UserPrincipalName": "alice@contoso.com",
      "UserRiskLevel": "none"
    },
    {
      "UserFailedMFACount": 31,
      "UserMFAFraudCount": 0,
      "UserId": "7ec8eef7-784d-4afd-91a1-1fd433bfc3ee",
      "UserPrincipalName": "john@contoso.com",
      "UserRiskLevel": "low"
    }
  ]
}
```

## Advanced Deployment

Deployment of the Sentinel Triage AssistanT should typically be performed from the [deployment template](/Deploy/readme.md), however in some cases you may wish to deploy an individual module below.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FModules%2FAADRisksModule%2Fazuredeploy.json)

## Post Deployment

* Grant the Logic app managed identity access to the Log Analytics API application permissions Data.Read (GrantPermissions.ps1)
* Grant the Logic app managed identity access to the Microsoft Graph application permissions User.Read.All (GrantPermissions.ps1)
* Grant the Logic app managed identity access to the Microsoft Graph application permissions IdentityRiskyUser.Read.All (GrantPermissions.ps1)
* Grant the Logic app Microsoft Sentinel Responder RBAC role on the resource group containing Microsoft Sentinel (GrantPermissions.ps1)
