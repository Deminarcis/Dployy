function xcode_utils {
    # Install Xcode Command Line Tools
    xcode-select --install
}

if (-not (Get-Module -ListAvailable -Name "DynamicMenu")) {
    if ( ($IsMacOS -eq $true) -or ($IsLinux -eq $true) ) {
        Import-Module ../../bin/DynamicMenu.psm1
    }
    else {
        import-module ..\..\bin\DynamicMenu.psm1
    }
}

xcode_utils

$Menu = [Menu]::New('CHOOSE YOUR MACOS VERSION')

$Ports = [MenuSection]::New(1, 'MACPORTS INSTALLER')
$Ports.AddOption('1', 'Golden Gate (27)', 'curl -OL https://github.com/macports/macports-base/releases/download/v2.12.7/MacPorts-2.12.7-27-GoldenGate.pkg && chmod +x MacPorts-2.12.7-27-GoldenGate.pkg && open MacPorts-2.12.7-27-GoldenGate.pkg')
$Ports.AddOption('2', 'Tahoe (26)', 'curl -OL https://github.com/macports/macports-base/releases/download/v2.12.7/MacPorts-2.12.7-26-Tahoe.pkg && chmod +x MacPorts-2.12.7-26-Tahoe.pkg && open MacPorts-2.12.7-26-Tahoe.pkg')
$Ports.AddOption('3', 'Sequoia (15)', 'curl -OL https://github.com/macports/macports-base/releases/download/v2.12.7/MacPorts-2.12.7-15-Sequoia.pkg && chmod +x MacPorts-2.12.7-15-Sequoia.pkg && open MacPorts-2.12.7-15-Sequoia.pkg')
$Ports.AddOption('4', 'Sonoma (14) ', 'curl -OL https://github.com/macports/macports-base/releases/download/v2.12.7/MacPorts-2.12.7-14-Sonoma.pkg && chmod +x MacPorts-2.12.7-14-Sonoma.pkg && open MacPorts-2.12.7-14-Sonoma.pkg')
$Ports.AddOption('5', 'Something Else?', 'open https://www.macports.org/install.php#installing')
$Ports.AddOption('Q', 'Quit', 'q')
$Menu.AddSection($Ports)

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
        #Remove-Module $Selection -ErrorAction SilentlyContinue; Import-Module ".\$($Selection)"
    }
}