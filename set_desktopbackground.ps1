<#  
.SYNOPSIS  
    Script to set a new background picture
    
.DESCRIPTION  
    This script runs and sets the downloaded image as the background
    Background should be minimum 1920x1080 for best looks

.PARAMETER
    None are required except the hard-coded ones underneath

.NOTES  
    File Name       :   set_desktopbackground.ps1
    Author          :   Lars S
    Version         :   0.1
    Last Modified   :   12.10.2020
.LINK
    
#>

# Set the place where to store the background image (C:\Users\USERNAME\AppData\Roaming\backgrounds)
$path = "$env:APPDATA\backgrounds"

if(!(test-path $path)) {
      New-Item -ItemType Directory -Force -Path $path
}


# Download the background image to the users profile
$url = "https://example.com/background.png"
$output = $path + "\CustomBackground.png"
Start-BitsTransfer -Source $url -Destination $output


# Remove the old settings for desktop background and set new
Remove-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "Wallpaper"
New-ItemProperty -path "HKCU:\Control Panel\Desktop\" -Name Wallpaper -Value $output -PropertyType String


rundll32.exe user32.dll, UpdatePerUserSystemParameters, 0, $false