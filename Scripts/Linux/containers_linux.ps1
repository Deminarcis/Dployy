function containers_linux {
    Write-Host ""
    Write-Host ""
    Write-Color "╭────────────────────────────────────────────────────────────╮  " -color Magenta
    Write-Color "| ", "CONTAINERS ", "                                                |  "  -color Magenta, White, Magenta
    Write-Color "|────────────────────────────────────────────────────────────|  " -color Magenta
    Write-Color "| ", "1. Ubuntu ", "                                                 | " -color Magenta, White, Magenta
    Write-Color "| ", "2. Fedora ", "                                                 | " -color Magenta, White, Magenta
    Write-Color "| ", "3. CentOS ", "                                                 |  " -color Magenta, White, Magenta
    Write-Color "| ", "4. Red Hat ", "                                                |   " -color Magenta, White, Magenta
    Write-Color "| ", "5. Kali ", "                                                   |  " -color Magenta, White, Magenta
    Write-Color "| ". "6. Blackarch ", "                                              |  " -color Magenta, White, Magenta
    Write-Color "| ", "7. OpenSUSE ", "                                               |  " -color Magenta, White, Magenta
    Write-Color "|                                                            |  " -color Magenta
    Write-Color "╰────────────────────────────────────────────────────────────╯  " -color Magenta
    Write-Host ""
    Write-Host ""
}

do {
    containers_linux
    $choice = Read-Host "Enter your choice from the list above, or press q to go back: "

    switch ($choice) {
        1 {
            pwsh -File container_ubuntu.ps1
        }
        2 {
            pwsh -File container_fedora.ps1
        }
        3 {
            pwsh -File container_centos.ps1
        }
        4 {
            pwsh -File container_rhel.ps1
        }
        5 {
            pwsh -File container_kali.ps1
        }
        6 {
            pwsh -File container_blackarch.ps1
        }
        7 {
            pwsh -File container_leap.ps1
        }
    }
}
until ($choice -eq 'q')