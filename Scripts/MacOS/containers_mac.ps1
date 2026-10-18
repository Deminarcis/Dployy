if (-not (Get-Module -ListAvailable -Name "DynamicMenu")) {
    if ( ($IsMacOS -eq $true) -or ($IsLinux -eq $true) ) {
        Import-Module ../../bin/DynamicMenu.psm1
    }
    else {
        import-module ..\..\bin\DynamicMenu.psm1
    }
}

$Menu = [Menu]::New('CONTAINER RECIPES')

$Container = [MenuSection]::New(1, 'CONTAINER RECIPES')
$Container.AddOption('1', 'Ubuntu', './container_ubuntu.ps1')
$Container.AddOption('2', 'Fedora', './container_fedora.ps1')
$Container.AddOption('3', 'CentOS', './container_centos.ps1')
$Container.AddOption('4', 'Red Hat Enterprise Linux (UBI) ', './container_rhel.ps1')
$Container.AddOption('5', 'Kali Linux', './container_kali.ps1')
$Container.AddOption('6', 'Blackarch', './container_blackarch.ps1')
$Container.AddOption('7', 'OpenSUSE Leap', './container_leap.ps1')
$Container.AddOption('B', 'Go Back', '../bin/Dployy.ps1')
$Container.AddOption('Q', 'Quit', 'q')
$Menu.AddSection($Container)

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