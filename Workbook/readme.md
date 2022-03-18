# Microsoft Sentinel Triage AssistanT - Status Workbook

This workbook provides an overview of the installed STAT solution.  It includes information on run history as well as version information to ensure that STAT is up to date. Note that this workbook can be opened directly from the resource group but will not be visible in the Workbooks blade in the Sentinel portal. To make it available in the My template section of the workbooks blade, follow the instructions in the section Make the workbook visible in the Workbooks blade below.

## Advanced Deployment

Deployment of the Microsoft Sentinel Triage AssistanT should typically be performed from the [deployment template](/Deploy/readme.md), however in some cases you may wish to deploy just the sample template below.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FWorkbook%2Fazuredeploy.json)

## Make the workbook visible in the Workbooks blade
Use the deploy to Azure link above and before creating the deployment, click the **Edit template** link.
Replace the line 13 and 14 of the ARM template by the following data:

`"workbookType": "workbook",` becomes `"workbookType": "sentinel",`     
`"workbookSourceId": "Azure Monitor",` becomes `"workbookSourceId": "{resource ID}",`

For `workbookSourceId` replace `{resource ID}` by the actual resource ID of the Sentinel enabled workspace. To see the resource ID of your workspace, in your Sentinel portal click on the **Settings** blade then **Workspace settings**. In the **Overview** blade of the Log Analytics workspace click the **JSON View** link on the right side:
![image](https://user-images.githubusercontent.com/22434561/158928032-57f23284-9204-4dc7-ba2e-b765e53a29c8.png)
You will find the resource ID on the top:
![image](https://user-images.githubusercontent.com/22434561/158928269-dd4db50d-81e3-46cc-82f8-312e12ba9399.png)

Once you have edited the `workbookType` and the `workbookSourceId` you can click **Save**.

Then select the same subscription and the same resource group as your Sentinel enabled workspace in the interface:
![image](https://user-images.githubusercontent.com/22434561/158927081-d3446dc7-2e80-491f-b214-4e736164d8fe.png)
And proceed with the creation.
  
The workbook will now be visible when visiting the **Workbooks** blade in the **My templates** section.
