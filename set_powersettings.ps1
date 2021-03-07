<#  
.SYNOPSIS  
    Script to set power settings to High Performance.
    
.DESCRIPTION  
    This script runs and sets the wanted power settings after turning on High Performance schema

.PARAMETER
    None are required except the hard-coded ones underneath

.NOTES  
    File Name       :   set_powersettings.ps1
    Author          :   Lars Magnus Herland
    Version         :   0.1
    Last Modified   :   15.12.2020
.LINK
    
#>

cmd /c "powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"
cmd /c "powercfg /change monitor-timeout-ac 30"
cmd /c "powercfg /change monitor-timeout-dc 30"
cmd /c "powercfg /change standby-timeout-ac 0"
cmd /c "powercfg /change standby-timeout-dc 30"
cmd /c "powercfg /change hibernate-timeout-ac 0"
cmd /c "powercfg /change hibernate-timeout-dc 60"
cmd /c "powercfg /change disk-timeout-ac 0"