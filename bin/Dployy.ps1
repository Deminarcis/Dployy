if (-not (Get-Module -ListAvailable -Name "DynamicMenu")) {
    if ( ($IsMacOS -eq $true) -or ($IsLinux -eq $true) ) {
        Import-Module ./DynamicMenu.psm1
    }
    else {
        Import-Module .\DynamicMenu.psm1
    }
}

if ($isMacOS -eq $true) {
    #Optional define Menu with a Title
    $Menu = [Menu]::New('WELCOME TO DPLOYY')

    #Define a Section
    $Tweaks = [MenuSection]::New(1, 'SYSTEM SETUP AND TWEAKS')
    #Add Options to the Section
    $Tweaks.AddOption('1', 'Install container', '../Scripts/MacOS/ins_container.ps1')
    $Tweaks.AddOption('2', 'Install Homebrew', '../Scripts/MacOS/ins_brew.ps1')
    $Tweaks.AddOption('3', 'Install MacPorts', '../Scripts/MacOS/ins_macports.ps1')
    $Tweaks.AddOption('4', 'Install Apps (Needs Homebrew)', '../Scripts/MacOS/ins_apps_mac.ps1')
    $Tweaks.AddOption('5', 'Install Nix', '../Scripts/MacOS/ins_nix_macos.ps1')
    $Tweaks.AddOption('S', 'Self Hosting', '../Scripts/MacOS/self_hosted.ps1')
    $Tweaks.AddOption('Z', 'Add custom zshrc', '../Scripts/MacOS/zsh_prompt.ps1')
    $Tweaks.AddOption('P', 'Add custom powershell config', '../Scripts/MacOS/ps_prompt.ps1')
    #Add the Section to the Menu
    $Menu.AddSection($Tweaks)

    #Same as above
    $Containers = [MenuSection]::New(2, 'CONTAINERS')
    $Containers.AddOption('6', 'Container Recipes', '../Scripts/MacOS/containers_mac.ps1')
    $Containers.AddOption('Q', 'Quit', 'q')
    $Menu.AddSection($Containers)

    While ($True) {
        Clear-Host
        $Menu.Draw()
        $Selection = $Menu.ReadResponse("Pick an option from the list above or press 'q' to exit", 'Callback')
        If ($Selection -eq 'q') {
            Break
        }
        Else {
            "Executing Script: $($Selection)"
            #Can even make them a module and have them run the code automatically in import
            Remove-Module $Selection -ErrorAction SilentlyContinue; Import-Module ".\$($Selection)"
        }
    }
}
elseif ($isLinux -eq $true)
{
    #Optional define Menu with a Title
    $Menu = [Menu]::New('WELCOME TO DPLOYY')

    #Define a Section
    $Tweaks = [MenuSection]::New(1, 'SYSTEM SETUP AND TWEAKS')
    #Add Options to the Section
    $Tweaks.AddOption('1', 'Install Flathub', '../Scripts/Linux/ins_flathub.ps1')
    $Tweaks.AddOption('2', 'Install Pods', '../Scripts/Linux/ins_pods.ps1')
    $Tweaks.AddOption('3', 'Install Homebrew', 'bash -c ../Scripts/Linux/ins_brew.sh')
    $Tweaks.AddOption('4', 'Install Nix', '../Scripts/Linux/ins_flathub.ps1')
    $Tweaks.AddOption('Z', 'Custome Zsh Prompt', '../Scripts/Linux/zsh_prompt.ps1')
    $Tweaks.AddOption('P', 'Custom Powershell Prompt', '../Scripts/Linux/ps_prompt.ps1')
    $Tweaks.AddOption('S', 'Self Hosting', '../Scripts/Linux/self_hosted.ps1')
    #Add the Section to the Menu
    $Menu.AddSection($Tweaks)

    #Same as above
    $Containers = [MenuSection]::New(2, 'CONTAINERS')
    $Containers.AddOption('6', 'Container Recipes', '../Scripts/Linux/containers_linux.ps1')
    $Containers.AddOption('Q', 'Quit', 'q')
    $Menu.AddSection($Containers)

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
} else
{
    #Optional define Menu with a Title
    $Menu = [Menu]::New('WELCOME TO DPLOYY')

    #Define a Section
    $Tweaks = [MenuSection]::New(1, 'SYSTEM SETUP AND TWEAKS')
    #Add Options to the Section
    $Tweaks.AddOption('1', 'Install WSL', '..\Scripts\Windows\ins_wsl.ps1')
    $Tweaks.AddOption('2', 'Install Apps', '..\Scripts\Windows\ins_apps.ps1')
    $Tweaks.AddOption('3', 'Custom WSL Kernel', '..\Scripts\Windows\ins_wsl_kernel.ps1')
    $Tweaks.AddOption('4', 'Custom Powershell config', '..\Scripts\Windows\ps_prompt.ps1')
    $Tweaks.AddOption('5', 'Install Scoop', '..\Scripts\Windows\ins_scoop.ps1')
    $Tweaks.AddOption('G', 'Install Scoop', '..\Scripts\Windows\ins_scoop.ps1')
    $Tweaks.AddOption('H', 'Enable Hyper-V', '..\Scripts\Windows\hyperv-on.bat')
    $Tweaks.AddOption('S', 'Self Hosting', '..\Scripts\Windows\self_hosted.ps1')
     #Add the Section to the Menu
    $Menu.AddSection($Tweaks)

    $Containers = [MenuSection]::New(2, 'CONTAINERS')
    $Containers.AddOption('6', 'Container Recipes', '..\Scripts\Windows\containers_windows.ps1')
    $Menu.AddSection($Containers)

    $Debloat = [MenuSection]::New(2, 'DEBLOAT TOOLS')
    #Add Options to the Section
    $Debloat.AddOption('C', 'Chris Titus Tool', '..\Scripts\Windows\titus.ps1')
    $Debloat.AddOption('W', 'Windows11 Debloat Script', '..\Scripts\Windows\win11dbloat.ps1')
    $Debloat.AddOption('Q', 'Quit', 'q')
    $Menu.AddSection($Debloat)

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
}
