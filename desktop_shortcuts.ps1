<#  
.SYNOPSIS  
    Script to create bunch of desktop icons
    
.DESCRIPTION  
    This script runs and creates a couple of shortcuts to web pages to be placed on the desktop or start-menu
    Create a high-res icon by using a 256x256 png and convert to ICO using: https://icoconvert.com/
    Icons can be placed anywhere accessible by HTTP/HTTPS

.PARAMETER
    None are required except the hard-coded ones underneath

.NOTES  
    File Name       :   desktop_shortcuts.ps1
    Author          :   Lars S
    Version         :   0.3
    Last Modified   :   22.10.2020
.LINK
    
#>

param (
[system.string]$Desktop = [Environment]::GetFolderPath("Desktop"),
[system.string]$IconsProgramDir = "$env:APPDATA\Icons",
)

$listOfShortCuts = @(
    @{"shortcutName" = "NAME1"; "shortcutUrl" = "https://example1.com/"; "iconURL" = "https://example.com/logo.ico1"; "tempIcon" = "$IconsProgramDir\NAME1.ico"; "shortcutOnDesktop" = $True; "shortcutInStartMenu" = $False},
    @{"shortcutName" = "NAME2"; "shortcutUrl" = "https://example2.com/"; "iconURL" = "https://example.com/logo.ico2"; "tempIcon" = "$IconsProgramDir\NAME2.ico"; "shortcutOnDesktop" = $True; "shortcutInStartMenu" = $False},
    @{"shortcutName" = "NAME3"; "shortcutUrl" = "https://example3.com/"; "iconURL" = "https://example.com/logo.ico3"; "tempIcon" = "$IconsProgramDir\NAME3.ico"; "shortcutOnDesktop" = $True; "shortcutInStartMenu" = $False},
    @{"shortcutName" = "NAME4"; "shortcutUrl" = "https://example4.com/"; "iconURL" = "https://example.com/logo.ico4"; "tempIcon" = "$IconsProgramDir\NAME4.ico"; "shortcutOnDesktop" = $True; "shortcutInStartMenu" = $False} # This is the last entry and does not have an ending comma
)

#### Create all other Shortcuts

foreach($shortcuts in $listOfShortCuts){

    # Remove possible duplicates of shortcuts created by other programs or scripts
    $FileName = "$Desktop\$($shortcuts.shortcutName).lnk"
    if (Test-Path -Path $FileName) {
      Remove-Item $FileName -Force -Confirm:$False
    }

    $FileName2 = "$Desktop\$($shortcuts.shortcutName) - Copy.lnk"
    if (Test-Path -Path $FileName2) {
      Remove-Item $FileName2 -Force -Confirm:$False
    }

    $FileName3 = "$Desktop\$($shortcuts.shortcutName)- Copy.lnk"
    if (Test-Path -Path $FileName3) {
      Remove-Item $FileName3 -Force -Confirm:$False
    }

    # Remove icon if it was downloaded earlier and download a new copy of it
    if (Test-Path -Path $shortcuts.tempIcon) {
      Remove-Item $shortcuts.tempIcon -Force -Confirm:$False
    }

    Start-Sleep -s 2
     
    $WScriptShell = New-Object -ComObject WScript.Shell
    
    # Check if folder exists
    If ((Test-Path -Path $IconsProgramDir) -eq $False) {
      New-Item -ItemType Directory $IconsProgramDir -Force -Confirm:$False
    }
     
    # Start to download the icons
    Start-BitsTransfer -Source $shortcuts.iconURL -Destination $shortcuts.tempIcon
    
    # Create shortcut if it's to be placed on the users Desktop
    if ($shortcuts.shortcutOnDesktop) {
      $Shortcut = $WScriptShell.CreateShortcut("$Desktop\$($shortcuts.shortcutName).lnk")
      $Shortcut.TargetPath = $shortcuts.shortcutUrl
      $Shortcut.IconLocation = $shortcuts.tempIcon
      $Shortcut.Save()
    }
    
    # Create shortcut if it's to be placed in the users Start-Menu
    if ($shortcuts.shortCutInStartMenu) {
      $Shortcut = $WScriptShell.CreateShortcut("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk")
      $Shortcut.targetPath = $shortcutUrl
      $Shortcut.iconLocation = $shortcuts.tempIcon
      $Shortcut.Save()
    }

}