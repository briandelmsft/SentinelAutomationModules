# Shared Modules

## Description
This module is called by other modules to process entity data and enrich the results.

## Quick Deployment

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fenrich_entities%2FModules%2FShared%2Fazuredeploy.json)

## Post Deployment

* Grant the Logic app managed identity access to the Microsoft Graph application permissions User.Read.All and RoleManagement.Read.Directory (GrantPermissions.ps1)
* Grant the Logic app Azure Sentinel Responder RBAC role on the resource group containing Azure Sentinel (GrantPermissions.ps1)