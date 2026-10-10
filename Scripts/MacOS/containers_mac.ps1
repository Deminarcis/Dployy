function containers_mac {
    Write-Host ""
    Write-Host ""
    Write-Color "╭────────────────────────────────────────────────────────────╮  " -color Magenta
    Write-Color "| ", "RECIPES ", "                                                   |  " -color Magenta, White, Magenta
    Write-Color "|────────────────────────────────────────────────────────────|  " -color Magenta
    Write-Color "| ", "1. Ubuntu ", "                                                 |  " -color Magenta, White, Magenta
    Write-Color "| ", "2. Fedora ", "                                                 |  " -color Magenta, White, Magenta
    Write-Color "| ", "3. CentOS ", "                                                 |  " -color Magenta, White, Magenta
    Write-Color "| ", "4. Red Hat ", "                                                |  " -color Magenta, White, Magenta
    Write-Color "| ", "5. Kali ", "                                                   |  " -color Magenta, White, Magenta
    Write-Color "| ", "6. Blackarch ", "                                              |  " -color Magenta, White, Magenta
    Write-Color "| ", "7. OpenSUSE ", "                                               |  " -color Magenta, White, Magenta
    Write-Color "|────────────────────────────────────────────────────────────|  " -color Magenta
    Write-Color "╰────────────────────────────────────────────────────────────╯  " -color Magenta
    Write-Host ""
    Write-Host ""
}

do {
    containers_mac
    $choice = Read-Host "Enter your choice from the list above or press 'q' to go back: "

    switch ($choice) {
        1 {
            pwsh -ArgumentList -File container_ubuntu.ps1
        }
        2 {
            pwsh -ArgumentList -File container_fedora.ps1
        }
        3 {
            pwsh -ArgumentList -File container_centos.ps1
        }
        4 {
            pwsh -ArgumentList -File container_rhel.ps1
        }
        5 {
            pwsh -ArgumentList -File container_kali.ps1
        }
        6 {
            pwsh -ArgumentList -File container_blackarch.ps1
        }
        7 {
            pwsh -ArgumentList -File container_leap.ps1
        }
    }
} until ($choice -eq 'q')

