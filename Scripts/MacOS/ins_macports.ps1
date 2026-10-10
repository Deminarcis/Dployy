function xcode_utils {
    # Install Xcode Command Line Tools
    xcode-select --install
}

function ins_macports
{
    # Install MacPorts
    xcode_utils
    Write-Host ""
    Write-Host ""
    Write-Color "╭────────────────────────────────────────────────────────────╮  " -color Magenta
    Write-Color "| ", "CHOOSE YOUR MACOS VERSION", "                                  |" -color Magenta, White, Magenta
    Write-Color "|────────────────────────────────────────────────────────────|  " -color Magenta
    Write-Color "| ", "1. Tahoe ", "                                                  |  " -color Magenta, White, Magenta
    Write-Color "| ", "2. Sequoia ", "                                                |  " -color Magenta, White, Magenta
    Write-Color "| ", "3. Sonoma ", "                                                 |  " -color Magenta, White, Magenta
    Write-Color "| ", "4. Ventura ", "                                                |  " -color Magenta, White, Magenta
    Write-Color "| ", "5. Monterey ", "                                               |  " -color Magenta, White, Magenta
    Write-Color "| ", "6. Something else  (open website) ", "                         |  " -color Magenta, White, Magenta
    Write-Color "|                                                            |  " -color Magenta
    Write-Color "|                                                            |  " -color Magenta
    Write-Color "|────────────────────────────────────────────────────────────|  " -color Magenta
    Write-Color "| ", "b to go back ", "                                              |  " -color Magenta, White, Magenta
    Write-Color "| ", "o to View Options ", "                                         |  " -color Magenta, White, Magenta
    Write-Color "╰────────────────────────────────────────────────────────────╯  " -color Magenta
    Write-Host ""
    Write-Host ""
}

do{
    ins_macports
    $choice =  Read-Host "Which version of MacOS do you have?"

    switch ($choice)
    {
        '1'
        { curl -OL "https://github.com/macports/macports-base/releases/download/v2.12.5/MacPorts-2.12.5-26-Tahoe.pkg"; chmod +x MacPorts-2.12.5-26-Tahoe.pkg; open MacPorts-2.12.5-26-Tahoe.pkg
        }
        '2'
        { curl -OL "https://github.com/macports/macports-base/releases/download/v2.12.5/MacPorts-2.12.5-15-Sequoia.pkg"; chmod +x MacPorts-2.12.5-15-Sequoia.pkg; open MacPorts-2.12.5-15-Sequoia.pkg
        }
        '3'
        { curl -OL "https://github.com/macports/macports-base/releases/download/v2.12.5/MacPorts-2.12.5-14-Sonoma.pkg"; chmod +x MacPorts-2.12.5-14-Sonoma.pkg; open MacPorts-2.12.5-14-Sonoma.pkg
        }
        '4'
        { curl -OL "https://github.com/macports/macports-base/releases/download/v2.12.5/MacPorts-2.12.5-13-Ventura.pkg"; chmod +x MacPorts-2.12.5-13-Ventura.pkg; open MacPorts-2.12.5-13-Ventura.pkg
        }
        '5'
        { curl -OL "https://github.com/macports/macports-base/releases/download/v2.12.5/MacPorts-2.12.5-12-Monterey.pkg"; chmod +x MacPorts-2.12.5-12-Monterey.pkg; open MacPorts-2.12.5-12-Monterey.pkg
        }
        '6'
        { open 'https://www.macports.org/install.php'
        }
        default
        {
            Write-Host "Invalid choice. Please select from the list above."
            continue
        }
    }
} until ($choice -eq 'q')
