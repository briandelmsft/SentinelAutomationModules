# Related Alerts Module
---
## Description
This module will check the incidient entities to see if there are any other alerts on the same entities.

## Suported Entity Types
* Account
* IP Address

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|Yes/No|When set to yes, the results of the query will be added to the Sentinel Incident Comments|
|CheckAccountEntityMatches|Yes/No|When set to yes, the module will look for related alerts based on the Account entity type|
|CheckIPEntityMatches|Yes/No|When set to yes, the module will look for related alerts based on the IP entity type|
|Entities|Entities (dynamic content)|This should be selected from the Dynamic content of the incident creation rule trigger|
|IncidentARMId|Incident ARM ID (dynamic content)|This should be selected from the Dynamic content of the incident creation rule trigger|
|LookbackInDays|1-90|This defines how far back to look through the SecurityAlert tables in Sentinel|
|WorkspaceId|Workspace ID (dynamic content)|This should be selected from the Dynamic content of the incident creation rule trigger|

## Quick Deployment

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FModules%2FRelatedAlerts%2Fazuredeploy.json)

## Post Deployment

* Grant the Logic app managed identity access to the Log Analytics API application permissions Data.Read (GrantAPIPermissions.ps1)
* Grant the Logic app Azure Sentinel Responder RBAC role on the resource group containing Azure Sentinel
