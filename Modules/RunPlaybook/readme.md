# Run-Playbook

## Description
This module will allow you to start another Microsoft Sentinel playbook on the incident being investigated via STAT. This allows you to benefit from the many existing Playbooks available for Microsoft Sentinel without having to incorporate their Logic into your triage playbooks.

## Suported Entity Types
* N/A

## Prerequisites

Using this module requires additional permissions that exceed those deployed by the GrantPermissions.ps1 PowerShell script.

Ensure the following permissions are assigned:

|Identity|Permissions Needed|Permission Location|
|---|---|---|
|STAT Function Identity (Managed Id or Service Principal)|Microsoft Sentinel Playbook Operator|Resoruce Group of Playbook to Run|
|Azure Security Insights|Microsoft Sentinel Automation Contributor|Resource Group of Playbook to Run|

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|True/False (Default:True)|When set to true, the start of the Playbook will be logged to the incident comments|
|Base Module Body|Body (dynamic content)|The Body should be selected from the Dynamic content of the Base-Module response|
|LogicAppResourceId|resourceId|The resourceId of the Logic App (Playbook) you want to run against the incident|
|TenantId|Azure AD Tenant Id|The Azure AD Tenant Id associated with the subscriptions of the Logic App|

## Return Properties

This module does not return a Body unless there is an error, but a status code is always included in the return.

|Status Code|Description|
|---|---|
|200|The called playbook successfully started|
|500|An error caused the called playbook from starting.  This is usually due to the STAT identity not having Microsoft Sentinel Playbook Operator on the Playbook resource groupp or Microsoft Sentinel (Azure Security Insights) not having the Microsoft Sentinel Automation Contributor role on the resource group where the Playbook is located|

## Deployment

To deploy the Sentinel Triage AssistanT visit the [deployment documentation](/Docs/deployment.md).
