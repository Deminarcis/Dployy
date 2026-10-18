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
$Apps.AddOption('1', 'Ghostty', 'brew install ghostty')
$Apps.AddOption('2', 'iTerm2', 'brew install iterm2')
$Apps.AddOption('3', 'Kitty', 'brew install kitty')
$Apps.AddOption('4', 'Alacritty', 'brew install alacritty')
$Apps.AddOption('5', 'Zellij', 'brew install zellij')
$Apps.AddOption('6', 'VSCode', 'brew install visual-studio-code')
$Apps.AddOption('7', 'Zed', 'brew install zed')
$Apps.AddOption('8', 'Podman Desktop', 'brew install podman-desktop')
$Apps.AddOption('9', 'Crossover', 'brew install crossover')
$Apps.AddOption('10', 'UTM', 'brew install --cask utm')
$Apps.AddOption('11', 'Handbrake', 'brew install handbrake')
$Apps.AddOption('12', 'Mole', 'brew install mole')
$Apps.AddOption('13', 'Veracrypt', 'brew install veracrypt')
$Apps.AddOption('14', 'Google Chrome', 'brew install google-chrome')
$Apps.AddOption('15', 'Proton Pass', 'brew install proton-pass')
$Apps.AddOption('16', 'Vivaldi', 'brew install vivaldi')
$Apps.AddOption('17', 'Discord', 'brew install --cask discord')
$Apps.AddOption('18', 'Xquartz', 'brew install xquartz')
$Apps.AddOption('19', 'Superfile', 'brew install extras/bleachbit')
$Apps.AddOption('20', 'Ghidra', 'brew install extras/discord')
$Apps.AddOption('21', 'DockAutoHide', 'brew tap nshcr/tap && brew trust nshcr/tap && brew install --cask dockautohide')
$Apps.AddOption('22', 'Rectangle', 'brew install rectangle')
$Apps.AddOption('23', 'YT-Dlp', 'brew install yt-dlp')
$Apps.AddOption('24', 'LM Stuido', 'brew install lm-studio')
$Apps.AddOption('25', 'Fresh Editor', 'brew install fresh')
$Apps.AddOption('26', 'lsd', 'brew install lsd')
$Apps.AddOption('27', 'Vulkan Tools', 'brew install vulkan-tools')
$Apps.AddOption('28', 'Mesa 3D', 'brew install mesa')
$Apps.AddOption('B', 'Go Back', '../bin/Dployy.ps1')
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