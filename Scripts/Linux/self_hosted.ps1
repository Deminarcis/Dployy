if (-not (Get-Module -ListAvailable -Name "DynamicMenu")) {
    if ( ($IsMacOS -eq $true) -or ($IsLinux -eq $true) ) {
        Import-Module ../../bin/DynamicMenu.psm1
    }
    else {
        import-module ..\..\bin\DynamicMenu.psm1
    }
}

#Optional define Menu with a Title
$Menu = [Menu]::New('SELF HOSTING')

#Define a Section
$Services = [MenuSection]::New(1, 'SERVICES')
#Add Options to the Section
$Services.AddOption('1', 'Service 1', 'Script1.ps1')
$Services.AddOption('2', 'Service 2', 'Script2.ps1')
$Services.AddOption('3', 'Service 3', 'Script3.ps1')
$Services.AddOption('4', 'Service 4', 'Script4.ps1')
$Services.AddOption('5', 'Service 5', 'Script5.ps1')
$Services.AddOption('6', 'Service 6', 'Script6.ps1')
$Services.AddOption('7', 'Service 7', 'Script7.ps1')
#Add the Section to the Menu
$Menu.AddSection($Services)

#Same as above
$VPNs = [MenuSection]::New(2, 'VPNs')
$VPNs.AddOption('NBSH', 'Netbird (self hosted)', 'Netbird_SelfHosted.ps1')
$VPNs.AddOption('NB', 'Netbird', 'Netbird.ps1')
$VPNs.AddOption('TS', 'Tailscale', 'Tailscale.ps1')
$Menu.AddSection($VPNs)


$Management = [MenuSection]::New(2, 'Management Interfaces')
$Management.AddOption('C', 'Cockpit', 'Cockpit.ps1')
$Management.AddOption('B', 'Go Back', '../bin/Dployy.ps1')
$Management.AddOption('Q', 'Quit', 'q')
$Menu.AddSection($Management)

While ($True) {
    Clear-Host
    $Menu.Draw()
    $Selection = $Menu.ReadResponse("Pick an option from the list above or press 'q' to go back", 'Callback')
    If ($Selection -eq 'q') {
        Break
    }
    Else {
        "Executing Script: $($Selection)"
        #Can even make them a module and have them run the code automatically in import
        Remove-Modle $Selection -ErrorAction SilentlyContinue; Import-Module ".\$($Selection)"
    }
}