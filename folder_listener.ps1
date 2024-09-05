$sourceFolder = "" #Path of the source folder
$destinationFolder = "" #Path of the destination folder
$files = Get-ChildItem -Path $sourceFolder
foreach ($file in $files) {
    $destinationPath = Join-Path -Path $destinationFolder -ChildPath $file.Name
    Move-Item -Path $file.FullName -Destination $destinationPath -Force
    $smtpServer = "" #smtp server address
    $emailFrom = "" #email sender address
    $emailTo = "orn@hertz.co.il"
    $subject = ($file.BaseName -replace '_', ':')
    $body = "A new file has been added to the folder: " + $destinationPath
    $smtp = New-Object Net.Mail.SmtpClient($smtpServer)
    $msg = New-Object Net.Mail.MailMessage($emailFrom, $emailTo, $subject, $body)
    $attachment = New-Object Net.Mail.Attachment($destinationPath)
    $msg.Attachments.Add($attachment)
    $smtp.Send($msg)
    $attachment.Dispose()
    $msg.Dispose()
}
