#Requires -PSEdition Core

[Diagnostics.CodeAnalysis.SuppressMessageAttribute(
    <#Category#>'PSUseCompatibleSyntax', <#CheckId#>$null,
    Justification='Reason for suppressing'
)]
param (
    [string]
    $Path = 'Specter-Strings.resx'
)

[xml]$Xml = Get-Content -LiteralPath $Path

<# $RelevantNodes = $Xml.SelectNodes(
    '/root/data[ends-with(@name, "CommonName") or ends-with(@name, "Description")]'
) #>

[System.Collections.Generic.Dictionary[string, pscustomobject]]$RulesMap = @{}

# Method 1
$RuleNames = $Xml.root.data.name.Where{$_ -notmatch '(?:(?<!Common)Name|Error)$'} -replace '^(.+)(?:CommonName|Description)$','$1' | sort -Unique

$RuleNames | ForEach-Object {
    $RuleName = $_
    if ([string]::IsNullOrEmpty($RuleName)) { continue }
    if ($RuleName -match '(Name|Error)$') { continue }
    if ($RulesMap.ContainsKey($RuleName)) { continue }

    try {
        $Description = $Xml.root.SelectSingleNode("data[@name='${RuleName}Description']")?.value
        $CommonName = $Xml.root.SelectSingleNode("data[@name='${RuleName}CommonName']")?.value
        $RulesMap.Add($RuleName,
            [pscustomobject]@{
                Name        = $RuleName
                CommonName  = $CommonName
                Description = $Description
            })
    }
    catch {
        $Err = $_
        Write-Warning "Exception $($Err.Exception.HResult) selecting rule $RuleName > $($Err.Exception.Message)"
    }
}

if ($RulesMap -and $RulesMap.Count -gt 0) { return <# $RulesMap #> }

<# Method 2
$RelevantNodes = $Xml.SelectNodes('/root/data') | ? {$_.Name -match '^(.*)(CommonName|Description)$'}

foreach ($Node in $RelevantNodes) {
    $Suffix =
    if ($Node.name.EndsWith('CommonName')) {
        'CommonName'
    }
    elseif ($Node.name.EndsWith('Description')) {
        'Description'
    }
    else {
        continue
    }

    $BaseName = $Node.name.TrimEnd($Suffix)

    if ($RulesMap.ContainsKey($BaseName)) {
        $RulesMap.$BaseName.$Suffix = $Node.Value
        continue
    }

    $RulesMap.Add($BaseName, [PSCustomObject]@{
            Name        = $BaseName
            CommonName  = $Node.Value
            Description = $Node.Value
        })
}

# $RulesMap
#>

<# $SpecterRules = $RulesMap.Values |
    Group-Object -Property Name |
    ForEach-Object {
        $Map = @{}
        foreach ($Item in $_.Group) {
            $Map[$Item.Field] = $Item.Value
        }

        [PSCustomObject]@{
            Name        = $Map.Name ?? $_.Name
            CommonName  = $Map.CommonName
            Description = $Map.Description
        }
    } |
    Where-Object {
        $_.CommonName -or $_.Description
    }
    $SpecterRules
#>

