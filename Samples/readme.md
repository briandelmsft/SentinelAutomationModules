# Sample Playbook

## Description
This Playbook shows an example of how to use multiple automation modules together in order to triage an incident in Azure Sentinel.

### Basic Sample

The Basic Sample Playbook evaluates the incident entities to look for Related Alerts (Account, Host or IP), Threat Intelligence (Domain, FileHash, IP or URL) and Azure AD MFA Fraud reports.  If anything is found, the Incident is tagged and severity is raised to High.  If nothing is found the Incident is tagged and severity is lowered to Informational.

## Advanced Deployment

Deployment of the Sentinel Triage AssistanT should typically be performed from the [deployment template](/Deploy/readme.md), however in some cases you may wish to deploy just the sample template below.

### Basic Sample

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FSamples%2Fbasicsample.json)

## Post Deployment

* Grant the Logic app Microsoft Sentinel Responder RBAC role on the resource group containing Microsoft Sentinel
