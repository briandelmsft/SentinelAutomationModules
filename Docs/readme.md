# Sentinel Triage AssistanT (STAT) :hospital: - Documentation Home

The Microsoft Sentinel Triage AssistanT (STAT) is a Logic Apps Custom Connector that calls on a library of Automation [Modules](/Modules/) that can be used from Incident based Microsoft Sentinel playbooks.  This connector and modules will simplify automation by moving the complex tasks into these callable modules so they can be performed consistently and with ease from the Logic Apps Connector.

The primary focus of these modules is to perform automated incident triage.  An incident triage takes an incoming incident and assesses it based on the criteria you choose to determine which further actions should be taken.

Take for example an impossible travel incident, while this incident could represent a legitimate threat to the environment it could also be a false positive due to the legitimate users use of a VPN or the imperfections of IP based geo location technologies.  STAT can be used to perform automated analysis of such an incident against customized criteria to determine if the incident should be raised in severity, closed altogether or another custom action performed.

## Learn more

* [How it works](howitworks.md)
* [Deployment](deployment.md)
* [Sample Playbook](sample.md)