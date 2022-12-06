# Sample Playbook

## Description
This Playbook shows an example of how to use multiple automation modules together in order to triage an incident in Microsoft Sentinel.  This sample is not meant to be capable of triaging any type of incident; additional playbooks may need to be built using STAT to handle the unique requirements of different incident types.

### Basic Sample

The Basic Sample Playbook evaluates the incident entities to look for Related Alerts (Account, Host or IP), Threat Intelligence (Domain, FileHash, IP or URL) and Azure AD MFA Fraud reports.  If anything is found, the Incident is tagged and severity is raised to High.  If nothing is found the Incident is tagged and severity is lowered to Informational.

## Deployment

To deploy the Sentinel Triage AssistanT visit the [deployment documentation](/Docs/deployment.md).