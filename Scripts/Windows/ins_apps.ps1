if (-not (Get-Module -ListAvailable -Name "DynamicMenu")) {
    if ( ($IsMacOS -eq $true) -or ($IsLinux -eq $true) ) {
        Import-Module ../../bin/DynamicMenu.psm1
    }
    else {
        import-module ..\..\bin\DynamicMenu.psm1
    }
}

$Menu = [Menu]::New('APP INSTALLER')

$Apps = [MenuSection]::New(1, 'AVAILABLE APPLICATIONS')
$Apps.AddOption('1', 'Powershell', 'scoop install pwsh')
$Apps.AddOption('2', 'VSCode', 'scoop install vscode')
$Apps.AddOption('3', 'Powertoys', 'scoop install extras/powertoys')
$Apps.AddOption('4', 'Zen Browser', 'scoop install extras/zen-browser')
$Apps.AddOption('5', 'Google Chrome', 'scoop install extras/googlechrome')
$Apps.AddOption('6', 'Firefox Browser', 'scoop install extras/firefox')
$Apps.AddOption('7', 'Mozilla Thunderbird', 'scoop install extras/thunderbird')
$Apps.AddOption('8', 'bat', 'scoop install bat')
$Apps.AddOption('9', 'Nano', 'scoop install nano')
$Apps.AddOption('10', 'MS Edit', 'scoop install edit')
$Apps.AddOption('11', 'lsd', 'scoop install lsd')
$Apps.AddOption('12', 'Fresh Editor', 'scoop install fresh')
$Apps.AddOption('13', 'sysinternals', 'scoop install extras/sysinternals')
$Apps.AddOption('14', '7zip', 'scoop install 7zip')
$Apps.AddOption('15', 'Proton Pass', 'scoop install extras/proton-pass')
$Apps.AddOption('16', 'Haruna', 'scoop install extras/haruna')
$Apps.AddOption('17', 'Winfsp', 'scoop install nonportable/winfsp-np')
$Apps.AddOption('18', 'Zed', 'scoop install extras/zed')
$Apps.AddOption('19', 'Bleachbit', 'scoop install extras/bleachbit')
$Apps.AddOption('20', 'Discord', 'scoop install extras/discord')
$Apps.AddOption('21', 'Obsidian', 'scoop install extras/obsidian')
$Apps.AddOption('22', 'Mesa 3D', 'scoop install games/mesa3d')
$Apps.AddOption('23', 'YT-Dlp', 'scoop install yt-dlp ffmpeg')
$Apps.AddOption('24', 'handbrake', 'scoop install extras/handbrake')
$Apps.AddOption('Q', 'Quit', 'q')
$Menu.AddSection($Apps)

While ($True) {
    Clear-Host
    $Menu.Draw()
    $Selection = $Menu.ReadResponse("Pick an option from the list above or press 'q' to quit", 'Callback')
    If ($Selection -eq 'q') {
        Break
    }
    Else {
        "Executing Script: $($Selection)"
        #Can even make them a module and have them run the code automatically in import
        Remove-Module $Selection -ErrorAction SilentlyContinue; Import-Module ".\$($Selection)"
    }
}