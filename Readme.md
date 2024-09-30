# Enable PowerShell Script Execution
By default, Windows PowerShell restricts running scripts due to security reasons. You need to change the execution policy to allow your script to run.

Steps:

Open PowerShell as Administrator:
Press Windows + X and select Windows PowerShell (Admin) or Command Prompt (Admin), depending on your version of Windows.
To allow script execution, run the following command:
powershell
Copy code
``Set-ExecutionPolicy RemoteSigned``
This command allows the execution of scripts you’ve written locally, but it will still block scripts downloaded from the internet unless they are signed by a trusted publisher.
You may be prompted to confirm. Type Y and press Enter.


# Setting Up the Task in Task Scheduler
Now, you’ll schedule the script to run daily at 00:00 using Task Scheduler:

1. Open Task Scheduler:
Press Windows Key + R, type taskschd.msc, and press Enter.
2. Create a New Task:
In Task Scheduler, click Create Task.
###  General Tab:
3. Name your task (e.g., "Daily CCTV Backup").
4. Select Run whether the user is logged on or not.
5. Check Run with highest privileges.
### Triggers Tab:
6. Click New to create a new trigger.
7. Set the Begin the task option to On a schedule.
8. Choose Daily, and set the time to 00:00 (midnight).
### Actions Tab:
9. Click New to define an action.
10. Set Action to Start a Program.
11. In Program/script, enter powershell.exe.
12. In Add arguments, specify the path to your PowerShell script, like so:
powershell

``-File "C:\path\to\your\script.ps1"``
### Settings Tab:
13. Enable Allow task to be run on demand.
14. Check Run task as soon as possible after a scheduled start is missed.
Save:
Click OK and provide your credentials if prompted.
## Testing the Script
After creating the task, you can manually test the script:

In Task Scheduler, right-click on the newly created task and choose Run.
Verify that the footage is zipped correctly and the email is sent.

