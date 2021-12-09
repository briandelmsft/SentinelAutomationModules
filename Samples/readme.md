# Sample Playbook

## Description
This Playbook shows an example of how to use multiple automation modules together in order to triage an incident in Azure Sentinel.

## Advanced Deployment

Deployment of the Sentinel Triage AssistanT should typically be performed from the [deployment template](/Deploy/readme.md), however in some cases you may wish to deploy just the sample template below.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FSamples%2Fazuredeploy.json)

## Post Deployment

* Grant the Logic app Microsoft Sentinel Responder RBAC role on the resource group containing Microsoft Sentinel
