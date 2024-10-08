<##################################################################################################
#
.SYNOPSIS
Description: This script will block attachment downloads on unmanaged devices.

Prerequisites: The tenant will require any Exchange Online plan and Azure AD Premium P1 or Microsoft 365 Business, and Connect to Exchange Online via PowerShell using MFA:
https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/mfa-connect-to-exchange-online-powershell?view=exchange-ps

WARNING: Script provided as-is. Author is not responsible for its use and application. Use at your own risk.

.NOTES
    FileName:    Block-UnmanagedDownload.ps1
    Author:      John Igbokwe, techaxia.com
    Revised:     August 2024
    Version:     2.0
    
#>
###################################################################################################﻿

$MessageColor = "cyan"
$AssessmentColor = "magenta"

$OwaPolicy = Get-OwaMailboxPolicy -Identity OwaMailboxPolicy-Default
if ($OwaPolicy.ConditionalAccessPolicy -eq 'Off') {
    Write-Host 
    Write-Host -ForegroundColor $AssessmentColor "Attachment download is currently enabled for unmanaged devices by the default OWA policy"
    Write-Host 
    $Answer = Read-Host "Do you want to disable attachment download on unmanaged devices? Type Y or N and press Enter to continue"
    if ($Answer -eq 'y'-or $Answer -eq 'yes') {
        Get-OwaMailboxPolicy | Set-OwaMailboxPolicy -ConditionalAccessPolicy ReadOnly
        Write-Host 
        Write-Host -ForegroundColor $MessageColor "Attachment download on unmanaged devices is now disabled; please be sure to create a corresponding Conditional Access policy in Azure AD"
    } Else {
        Write-Host
        Write-Host -ForegroundColor $AssessmentColor "Attachment download on unamanged devices has not been disabled"
        }
} Else {
Write-Host
Write-Host -ForegroundColor $MessageColor "Attachment download on unmanaged devices is already disabled; please be sure there is a corresponding Conditional Access policy present in Azure AD"
}