function install_apps_mac {
    Write-Host ""
    Write-Host ""
    Write-Color "╭──────────────────────────────────────────────────────────────────────────╮  " -color Magenta
    Write-Color "| ", "APP INSTALLER", "                                                            |  " -color Magenta
    Write-Color "|──────────────────────────────────────────────────────────────────────────|  " -color Magenta
    Write-Color "| ", "1. Ghostty             2. iTerm2           3. Kitty ", "                     |  " -color Magenta, White, Magenta
    Write-Color "| ", "4. Alacritty           5. Zellij           6. VSCode ", "                    |  " -color Magenta, White, Magenta
    Write-Color "| ", "7. Zed                 8. Podman Desktop   9. Crossover ", "                 |  " -color Magenta, White, Magenta
    Write-Color "| ", "10. UTM                11. Handbrake       12. Mole ", "                     |  " -color Magenta, White, Magenta
    Write-Color "| ", "13. Veracrypt          14. Orion           15. Google Chrome ", "            | " -color Magenta, White, Magenta
    Write-Color "| ", "16. Helium             17. Zen             18. Discord ", "                  |  " -color Magenta, White, Magenta
    Write-Color "| ", "19. Thunderbird        20. xquartz         21. Superfile ", "                |  " -color Magenta, White, Magenta
    Write-Color "| ", "22. Ghidra             23. Intellidock     24. Grid (requires Licence) ", "  |  " -color Magenta, White, Magenta
    Write-Color "| ", "25. Jetbrains Toolbox  26. Proton Pass     27. LMStudio ", "                 |  " -color Magenta, White, Magenta
    Write-Color "| ", "28. Fresh              29. lsd             30. Bat ", "                      |  " -color Magenta, White, Magenta
    Write-Color "| ", "31. Mesa 3D            32. Vulkan Tools ", "                                 |  " -color Magenta, White, Magenta
    Write-Color "|                                                                          |  " -color Magenta
    Write-Color "|                                                                          |  " -color Magenta
    Write-Color "|──────────────────────────────────────────────────────────────────────────|  " -color Magenta
    Write-Color "|   b to install fomulaue not on this list                                 |  " -color Magenta, White, Magenta
    Write-Color "|   c to install cask not on this list                                     |  " -color Magenta, White, Magenta
    Write-Color "|   p to install port not on this list                                     |  " -color Magenta, White, Magenta
    Write-Color "╰──────────────────────────────────────────────────────────────────────────╯  " -color Magenta
    Write-Host ""
    Write-Host ""
}
function cask_choice {
    $cask = Read-Host "Enter the name of the brew cask you want to install"
}
function port_choice {
    $port = Read-Host "Enter the name of the port you want to install"
}

function brew_choice {
    $brew = Read-Host "Enter the name of the brew formula you want to install"
}

do {
    install_apps_mac
    $choice = Read-Host "Pick a number to continue or press 'q' to quit"

    switch ($choice) {
        1 {
            brew install ghostty
        }
        2 {
            brew install iterm2
        }
        3 {
            brew install kitty
        }
        4 {
            brew install alacritty
        }
        5 {
            brew install zellij
        }
        6 {
            brew install visual-studio-code
        }
        7 {
            brew install zed
        }
        8 {
            brew install podman-desktop
        }
        9 {
            brew install crossover
        }
        10 {
            brew install utm
        }
        11 {
            brew install handbrake
        }
        12 {
            brew install mole
        }
        13 {
            brew install veracrypt
        }
        14 {
            brew install orion
        }
        15 {
            brew install google-chrome
        }
        16 {
            brew install --cask helium-browser
        }
        17 {
            brew install zen
        }
        18 {
            brew install discord
        }
        19 {
            brew install thunderbird
        }
        20 {
            brew install xquartz
        }
        21 {
            brew install superfile
        }
        22 {
            brew install ghidra
        }
        23 {
            brew install intellidock
        }
        24 {
            brew install grid
        }
        25 {
            brew install jetbrains-toolbox
        }
        26 {
            brew install bitwarden
        }
        27 {
            brew install --cask lm-studio
        }
        28 {
            brew install fresh-editor
        }
        29 {
            brew install lsd
        }
        30 {
            brew install bat
        }
        31 {
            brew install mesa
        }
        32 {
            brew install vulkan-tools
        }
        "c" {
            cask_choice
        }
        "p" {
            port_choice
        }
        "b" {
            brew_choice
        }
    }
} until ($choice -eq 'q')