#To do
<#
    Add option for description below
    Add line wrap for options
    Add truncate for Titles
#>

#Export Types

$ExportableTypes = @(
    #Enums

    #Classes
    [MenuOption]
    [MenuSection]
    [Menu]
)

$TypeAcceleratorsClass = [psobject].Assembly.GetType('System.Management.Automation.TypeAccelerators')
$ExistingTypeAccelerators = $TypeAcceleratorsClass::Get
Foreach ($Type in $ExportableTypes) {
    If ($Type.FullName -in $ExistingTypeAccelerators.Keys) {
        throw [System.Management.Automation.ErrorRecord]::new([System.InvalidOperationException]::new("Unable to register type accelerator $($Type.FullName). Accelerator already exists."), 'TypeAcceleratorAlreadyExists', [System.Management.Automation.ErrorCategory]::InvalidOperation, $Type.FullName)
    }
}
Foreach ($Type in $ExportableTypes) {
    $TypeAcceleratorsClass::Add($Type.FullName, $Type) | Out-Null
}
$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove =
{
    Foreach ($Type in $ExportableTypes) {
        $TypeAcceleratorsClass::Remove($Type.FullName) | Out-Null
    }
}.GetNewClosure()



#Classes

Class MenuOption {
    #Properties
    [String]$Selector
    [String]$Name
    [String]$Style
    [String]$CallBack
    [String]$Description

    #Constructors
    MenuOption() {}
    MenuOption([String]$Selector, [String]$Name, [String]$CallBack, [String]$Description) {
        $This.Selector = $Selector
        $This.Name = $Name
        $This.CallBack = $CallBack
        $This.Description = $Description
    }
    MenuOption([String]$Selector, [String]$Name, [String]$CallBack) {
        $This.Selector = $Selector
        $This.Name = $Name
        $This.CallBack = $CallBack
    }
    MenuOption([String]$Selector, [String]$Name) {
        $This.Selector = $Selector
        $This.Name = $Name
    }

    #Methods
}

Class MenuSection {
    #Properties
    [Int]$Order
    [String]$Title
    [String]$Style
    [String]$Description
    [System.Collections.Generic.List[MenuOption]]$Options

    #Constructors
    MenuSection([Int]$Order, [String]$Title, [String]$Description) {
        $This.Order = $Order
        $This.Title = $Title
        $This.Description = $Description
    }
    MenuSection([Int]$Order, [String]$Title) {
        $This.Order = $Order
        $This.Title = $Title
    }

    #Methods
    AddOption([String]$Selector, [String]$Name, [String]$Description) {
        $This.Options += [MenuOption]::new($Selector, $Name, $Description)
    }
    AddOption([String]$Selector, [String]$Name) {
        $This.Options += [MenuOption]::new($Selector, $Name)
    }
}


Class Menu {
    #Properties
    Hidden [String]$_TopLine = '─'
    Hidden [String]$_SectionLine = '-'
    Hidden [String]$_BottomLine = '─'
    Hidden [String]$_LeftWall = '|'
    Hidden [String]$_RightWall = '|'
    Hidden [String]$_TopLeftCorner = '╭'
    Hidden [String]$_TopRightCorner = '╮'
    Hidden [String]$_BottomLeftCorner = '╰'
    Hidden [String]$_BottomRightCorner = '╯'
    Hidden [String]$_OptionSeparator = '. '
    Hidden [String]$_InvalidText = "$($PSStyle.Foreground.Red)Invalid selection! $($PSStyle.Reset)"
    Hidden [Int]$_MaxWidth = 120
    Hidden [Int]$_TopPadding = 2
    Hidden [Int]$_BottomPadding = 2
    Hidden [System.Collections.Generic.List[MenuSection]]$_Sections
    Hidden [System.Collections.Generic.List[MenuOption]]$_Options
    [String]$Title
    [String]$BorderStyle = $PSStyle.Foreground.Magenta
    [String]$TitleStyle = $PSStyle.Foreground.Red
    [String]$SectionTitleStyle = $PSStyle.Foreground.White
    [String]$OptionStyle = $PSStyle.Foreground.White
    Hidden [String]$_StyleReset = $PSStyle.Reset

    #Constructors
    Menu() {}
    Menu([String]$Title) {
        $This.Title = $Title
    }

    #Methods
    AddSection([MenuSection]$Section) {
        Try {
            Foreach ($Option in $Section.Options) {
                If ($This._Options.Selector -contains $Option.Selector) {
                    Throw "The Section contains a duplicate Option with another Section."
                }
            }
            $This._Sections += $Section
            $This._UpdateOptions()
        }
        Catch {
            Write-Error $_.Exception.Message
        }
    }
    Hidden [Void]_UpdateOptions() {
        $This._Options = @()
        Foreach ($TempSection in ($This._Sections | Sort-Object Order, Title)) {
            Foreach ($Option in $TempSection.Options) {
                If ($This._Options -notcontains $Option) {
                    $This._Options += $Option
                }
            }
        }
        $This._MaxWidth = (($This._Options.Name | Sort-Object Length -Descending)[0].Length + ($This._Options.Selector | Sort-Object Length -Descending)[0].Length + $This._OptionSeparator.Length + 4)
    }
    Hidden [String]_ReadResponse([String]$Prompt, [String]$OutputType) {
        $Option = ''
        $Invalid = $False
        While (!$Option) {
            $TempPrompt = $Prompt
            If ($Invalid) {
                $TempPrompt = $This._InvalidText + $Prompt
            }
            $Reponse = Read-Host $TempPrompt
            $Option = $This._Options | Where-Object { $_.Selector -eq $Reponse }
            $Invalid = $True
        }

        If ($OutputType -eq 'Callback') {
            Return $Option.Callback
        }
        ElseIf ($OutputType -eq 'Name') {
            Return $Option.Name
        }
        Else {
            Return $Option.Selector
        }
    }
    [String]ReadResponse([String]$Prompt, [String]$OutputType) {
        Return $This._ReadResponse($Prompt, $OutputType)
    }
    [String]ReadResponse([String]$Prompt) {
        Return $This._ReadResponse($Prompt, 'Selection')
    }
    Hidden _Draw([Int]$MaxWidth) {
        $Width = $This._MaxWidth - 1
        If ($MaxWidth -ge 15) {
            $Width = $MaxWidth - 1
        }
        $MaxStringLength = $Width - 2

        $Output = ''
        $BlankLine = "$($This.BorderStyle)$($This._LeftWall.PadRight($Width, ' '))$($This._RightWall)$($This._StyleReset)$([Environment]::NewLine)"

        $Count = 1; While ($Count -le $This._TopPadding) { $Output += $([Environment]::NewLine); $Count ++ }
        $Output += "$($This.BorderStyle)$($This._TopLeftCorner.PadRight($Width, $This._TopLine))$($This._TopRightCorner)$($This._StyleReset)$([Environment]::NewLine)"
        If ($This.Title) {
            $TempStyle = $($This.TitleStyle) + $($This._StyleReset)
            $TempString = $($This.TitleStyle) + $($This.Title) + $($This._StyleReset)
            $Output += "$($This.BorderStyle)$($This._LeftWall)$($This._StyleReset) $($TempString.PadRight(($MaxStringLength + $TempStyle.Length), ' '))$($This.BorderStyle)$($This._RightWall)$($This._StyleReset)$([Environment]::NewLine)"
            $Output += "$($This.BorderStyle)$($This._LeftWall.PadRight($Width, $This._SectionLine))$($This._RightWall)$($This._StyleReset)$([Environment]::NewLine)"
        }

        $DrawTopSectionLine = $False
        Foreach ($TempSection in ($This._Sections | Sort-Object Order, Title)) {
            If ($DrawTopSectionLine) {
                $Output += "$($This.BorderStyle)$($This._LeftWall.PadRight($Width, $This._SectionLine))$($This._RightWall)$($This._StyleReset)$([Environment]::NewLine)"
            }

            $TempSectionTitleStyle = $This.SectionTitleStyle
            If ($Null -ne $TempSection.Style) {
                $TempSectionTitleStyle = $TempSection.Style
            }

            $TempStyle = $($TempSectionTitleStyle) + $($This._StyleReset)
            $TempString = $($TempSectionTitleStyle) + $($TempSection.Title) + $($This._StyleReset)
            $Output += "$($This.BorderStyle)$($This._LeftWall)$($This._StyleReset) $($TempString.PadRight(($MaxStringLength + $TempStyle.Length), ' '))$($This.BorderStyle)$($This._RightWall)$($This._StyleReset)$([Environment]::NewLine)"
            $Output += "$($This.BorderStyle)$($This._LeftWall.PadRight($Width, $This._SectionLine))$($This._RightWall)$($This._StyleReset)$([Environment]::NewLine)"

            $Output += $BlankLine
            Foreach ($TempOption in $TempSection.Options) {
                $OutputOption = "$($TempOption.Selector)$($This._OptionSeparator)$($TempOption.Name)"
                If (($OutputOption.Length + 1) -gt $MaxStringLength) {
                    $TempOptionLength = [System.Math]::Min($TempOption.Name.Length, ($MaxStringLength - 7))
                    $OutputOption = "$($TempOption.Selector)$($This._OptionSeparator)$($TempOption.Name.SubString(0, $TempOptionLength).Trim())..."
                }
                $TempOptioneStyle = $This.OptionStyle
                If ($Null -ne $TempOption.Style) {
                    $TempOptioneStyle = $TempOption.Style
                }
                $TempStyle = $($TempOptioneStyle) + $($This._StyleReset)
                $TempString = $($TempOptioneStyle) + $($OutputOption) + $($This._StyleReset)
                $Output += "$($This.BorderStyle)$($This._LeftWall)$($This._StyleReset) $($TempString.PadRight(($MaxStringLength + $TempStyle.Length), ' '))$($This.BorderStyle)$($This._RightWall)$($This._StyleReset)$([Environment]::NewLine)"
            }
            $DrawTopSectionLine = $True

            $Output += $BlankLine
        }

        $Output += "$($This.BorderStyle)$($This._BottomLeftCorner.PadRight($Width, $This._BottomLine))$($This._BottomRightCorner)$($This._StyleReset)$([Environment]::NewLine)"
        $Count = 1; While ($Count -le $This._BottomPadding) { $Output += $([Environment]::NewLine); $Count ++ }
        Write-Host $Output
    }
    [Void]Draw([Int]$MaxWidth) {
        $This._Draw($MaxWidth)
    }
    [Void]Draw() {
        $This._Draw(0)
    }
}
