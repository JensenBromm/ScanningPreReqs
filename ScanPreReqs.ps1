#Script that automates steps before Nessus or Scaaps scans can be done.
$scan=Read-Host -Prompt 'What Scan are you doing (NESSUS(N) or SCAAP(S))'

while($scan -ne 'N' -and $scan -ne 'S'){
    $scan=Read-Host -Prompt 'Invalid Input. N for Nessus | S for SCAAP'
}

if($scan.Equals('N')) {
    #User is running a Nessus Scan
    Write-Host "NESSUS"
    #Firewall needs to be disabled
    Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled False
    Write-Host "Windows Firewall: Disabled"
    #Accounts: Administrator Account Status needs to be Enabled
    net user administrator /active:yes
     Write-Host "Built-In Admin: Enabled"
    #User Account Control: admin approval mode for built-in administrator needs to be Disabled
    Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0
    Write-Host "Admin Approval Mode: Disabled"
}
else{
    #User is running a SCAAP Scan
     Write-Host "SCAAP"
    #Firewall needs to be Enabled
    Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled True
     Write-Host "Windows Firewall: Enabled"
    #Accounts: Administrator Account Status needs to be Enabled
    net user administrator /active:no
     Write-Host "Built-In Admin: Disabled"
    #User Account Control: admin approval mode for built-in administrator needs to be Enabled
    Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 1
    Write-Host "Admin Approval Mode: Enabled"
}


#Wait for user to press key to close the window
Read-Host -Prompt "Press any key to continue..."
