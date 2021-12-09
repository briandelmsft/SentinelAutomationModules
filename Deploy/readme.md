# Deploy the full solution

This template is used to deploy or update the Microsoft Sentinel Triage AssistanT (STAT) solution.  The template will give you choices of which modules you would like to deploy, including sample templates, and allow for you to provide names for the modules.

## Quick Deployment

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fstatconnector%2FDeploy%2Fazuredeploy.json/createUIDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fstatconnector%2FDeploy%2FcreateUiDefinition.json)

## Post Deployment

* Run [GrantPermissions.ps1](GrantPermissions.ps1) to grant the necessary API and RBAC permissions to the logic apps deployed by this template.
