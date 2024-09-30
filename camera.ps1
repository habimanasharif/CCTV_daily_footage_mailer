# Define Variables
$footageDir = "D:\one_drive\OneDrive\Documents\sharif\footage"  # Directory where CCTV footage is stored
$backupDir = "D:\one_drive\OneDrive\Documents\sharif\backup"    # Directory to store zip file
$zipFile = "$backupDir\FootageBackup_$(Get-Date -Format 'yyyyMMdd').zip"  # Zip file name with the current date

$smtpServer = "smtp.gmail.com"  # Your SMTP server
$smtpFrom = "hdidiersharif@gmail.com"  # Your email
$smtpTo = "wizzysharifivk@gmail.com"  # Recipient email
$smtpSubject = "Daily CCTV Footage Backup"
$smtpBody = "Attached is the CCTV footage backup for the previous day."
$smtpUser = "hdidiersharif@gmail.com"  # SMTP username (email)
$smtpPass = "xlkeqhhzclffrncf"     # SMTP password or App password if using Gmail

# Find All Footage Files from Yesterday
# $filesToZip = Get-ChildItem -Path $footageDir -Recurse | Where-Object {
#     $_.LastWriteTime -ge (Get-Date).AddDays(-0).Date -and $_.LastWriteTime -lt (Get-Date).Date
# }
$filesToZip= Get-ChildItem -Path $footageDir -Recurse



# Create Zip File
if ($filesToZip.Count -gt 0) {
    # Ensure backup directory exists
    if (-not (Test-Path $backupDir)) {
        New-Item -Path $backupDir -ItemType Directory
    }

    # Compress Files into Zip
    Compress-Archive -Path $filesToZip.FullName -DestinationPath $zipFile
    # Email Information


# Get Yesterday's Date
$yesterday = (Get-Date).AddDays(-0).ToString("yyyyMMdd")

# Find All Footage Files from Yesterday

# Send Email with the Zip File as Attachment
    $emailMessage = New-Object system.net.mail.mailmessage
    $emailMessage.From = $smtpFrom
    $emailMessage.To.Add($smtpTo)
    $emailMessage.Subject = $smtpSubject
    $emailMessage.Body = $smtpBody
    $emailMessage.Attachments.Add($zipFile)


    $smtpClient = New-Object system.net.mail.smtpclient($smtpServer, 587)
    $smtpClient.EnableSsl = $true
    $smtpClient.Credentials = New-Object System.Net.NetworkCredential($smtpUser, $smtpPass)

    try {
        $smtpClient.Send($emailMessage)
        Write-Host "Email sent successfully."
    } catch {
        Write-Host "Error sending email: $_"
    }

  
} else {
    Write-Host "No footage found for the previous day."
}