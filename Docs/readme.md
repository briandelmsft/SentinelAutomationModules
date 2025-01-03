# Microsoft Sentinel Triage AssistanT (STAT) :hospital: - Documentation Home

> [!NOTE]
> STAT documentation is located in the built-in [Wiki](https://github.com/briandelmsft/SentinelAutomationModules/wiki).

The Microsoft Sentinel Triage AssistanT (STAT) is a Logic Apps Custom Connector that calls on a library of Automation [Modules](https://github.com/briandelmsft/SentinelAutomationModules/wiki/Modules#modules) that can be used from Incident or alert based Microsoft Sentinel playbooks.  This connector and modules will simplify automation by moving the complex tasks into these callable modules so they can be performed consistently and with ease from the Logic Apps Connector.

The primary focus of these modules is to perform automated incident triage.  An incident triage takes an incoming incident and assesses it based on the criteria you choose to determine which further actions should be taken.

Take for example an impossible travel incident, while this incident could represent a legitimate threat to the environment it could also be a false positive due to the legitimate users use of a VPN or the imperfections of IP based geo location technologies.  STAT can be used to perform automated analysis of such an incident against customized criteria to determine if the incident should be raised in severity, closed altogether or another custom action performed.

## Learn more

* [How it works](https://github.com/briandelmsft/SentinelAutomationModules/wiki#how-it-works)
* [Deployment](https://github.com/briandelmsft/SentinelAutomationModules/wiki/Deployment)
* [Sample Playbook](https://github.com/briandelmsft/SentinelAutomationModules/wiki/Examples#sample-playbook-logic)
* [Risk Scoring](https://github.com/briandelmsft/SentinelAutomationModules/wiki/Examples#risk-scoring-example)
* [Incident Tasks](https://github.com/briandelmsft/SentinelAutomationModules/wiki/Modules#incident-tasks)
* [Remediation](https://github.com/briandelmsft/SentinelAutomationModules/wiki/Examples#triggering-a-remediation-playbook-on-stat-output)
* [Authentication](https://github.com/briandelmsft/SentinelAutomationModules/wiki/Authentication)
* [MSSP Deployments](https://github.com/briandelmsft/SentinelAutomationModules/wiki/MSSP)
* [Troubleshooting](https://github.com/briandelmsft/SentinelAutomationModules/wiki/Troubleshooting-%E2%80%90-Common-Errors)
