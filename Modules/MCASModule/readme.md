# Get-MCASInvestigationScore

This Logic App can be called from a Playbook using the following parameters...

![Step 30] (Step_3.jpg)


## Prerequisites

You will need to get two information from your Microsoft Cloud App Security portal.

You need the MCAS API URL. You can get it followinf those steps:

    1. Connect to your Microsoft Cloud App Security portal and click on the **Help** menu and then click on **About**. Note the URL mentionned in the screen you will need it when you import the Logic App. 
    ![Step 0] (Step_0.jpg)

    2. Then click on the **Parameters** menu and select **Security extensions**. Then click on **Add Token**. Note the Token displayed on the screen as you will need it when you import the Logic.
    ![Step 1] (Step_1.jpg)

## Quick Deployment

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2raw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2FMCASScore%2FModules%2FMCASModule%2Fazuredeploy.json)

