#Requires -Modules @{ ModuleName="PSScriptAnalyzer"; ModuleVersion="1.25.0"; }

$AllRules = Get-ScriptAnalyzerRule
# Get rule properties by enumerating the classes in this namespace
# [Microsoft.Windows.PowerShell.ScriptAnalyzer.BuiltinRules]

# Various properties are available via methods:
# GetName()
# GetCommonName()
# GetDescription()
# GetSeverity()
# GetDiagnosticSeverity()
# GetSourceType()
# GetSourceName()

# Rule Properties
# [Microsoft.Windows.PowerShell.ScriptAnalyzer.BuiltinRules.AlignAssignmentStatement].GetProperties()

# Default value is in the DefaultValueAttribute on the property, e.g.
# [Microsoft.Windows.PowerShell.ScriptAnalyzer.BuiltinRules.AlignAssignmentStatement].GetProperties() | ? Name -eq 'SomeProperty' | % { $_.GetCustomAttributes($false).DefaultValue }

$RuleList = [System.Collections.Generic.Dictionary[string,pscustomobject]]::new()

$RuleDefaults = Import-Csv -Path "$PSScriptRoot/PSScriptAnalyzerRules.csv"
<#
Rule,RuleName,Severity,Enabled,CommonName,Description,Configurable,CanBeDisabled
AlignAssignmentStatement,PSAlignAssignmentStatement,Warning,No,Align assignment statement,Line up assignment statements such that the assignment operator are aligned.,Yes,Yes
#>

# actually update schema rule descriptions
$PSScriptAnalyzerSchema = gc .\PSScriptAnalyzer.schema.json | ConvertFrom-Json -Depth 10

foreach ($Rule in $AllRules) {
    $RuleName = $Rule.RuleName
    $RuleSeverity = $Rule.Severity

    $SchemaRule = $PSScriptAnalyzerSchema.definitions.RuleDescriptions.items.anyOf.Where({ $_.const -eq $RuleName })
    if (-not $SchemaRule) {
        continue
    }

    $RuleIdx = $PSScriptAnalyzerSchema.definitions.RuleDescriptions.items.anyOf.IndexOf($SchemaRule[0])
    $PSScriptAnalyzerSchema.definitions.RuleDescriptions.items.anyOf[$RuleIdx].description += "\nSeverity: $RuleSeverity"

    wh "Updated IncludeRules.$RuleName with severity" -NoNewline

    $SchemaConfig = $PSScriptAnalyzerSchema.definitions.RuleConfig.properties.$RuleName
    if (-not $SchemaConfig) {
        wh '.'
        continue
    }

    $PSScriptAnalyzerSchema.definitions.RuleConfig.properties.$RuleName.description += "\nSeverity: $RuleSeverity"

    wh ". Updated Rules.$RuleName with severity."
}

# RuleName,Title,Description,Settings
$SchemaBase = @'
"{0}": {
  "additionalProperties": false,
  "title": "{1}",
  "description": "{2}",
  "properties": {
    "Enable": {
      "$ref": "#/definitions/RuleEnable",
      "default": true
    },
    {3}
  }
}
'@

# SettingName,Type,Title,Description,DefaultValue,AdditionalProperties
$SchemaBaseSetting = @'
"{0}": {
  "type": "{1}",
  "title": "{2}",
  "description": "{3}",
  "default": {4},
  {5}
}
'@

$NETTypeToJSONType = @{
    'Boolean'            = 'boolean'
    'List`1'             = 'array'
    'Int32'              = 'integer'
    'String'             = 'string'
    'String[]'           = 'array'
    'DiagnosticSeverity' = 'array' # Information, Warning, Error, ParseError
}

$JSONRules = @{
    IncludeRules        = [string[]]@()
    ExcludeRules        = [string[]]@()
    CustomRulePath      = [string[]]@()
    IncludeDefaultRules = $true
    Rules               = @{}
}

# | Key                     | Values                                       | Description                                            |
# | ----------------------- | -------------------------------------------- | ------------------------------------------------------ |
# | `BuiltinRulePreference` | `"none"`, `"default"`, `"comprehensive"`     | Which built-in rules to load                           |
# | `RuleExecutionMode`     | `"default"`, `"parallel"`, `"sequential"`    | How rules are executed                                 |
# | `RulePaths`             | `["/path/to/rules", ...]`                    | Additional rule module paths (see security note below) |
# | `ExternalRules`         | `"explicit"`, `"disabled"`, `"unrestricted"` | External rule loading policy (default: `explicit`)     |
# | `Rules`                 | `{ "RuleName": { ... }, ... }`               | Per-rule configuration                                 |

$SpecterRules = @{
    BuiltinRulePreference = 'default'
    RuleExecutionMode     = 'default'
    RulePaths             = @()
    ExternalRules         = 'explicit'
    Rules                 = @{}
}
<# JSON schema structure
    TBD
#>

foreach ($Rule in $AllRules) {
    <# Rule Properties
    RuleName         : PSAlignAssignmentStatement
    CommonName       : Align assignment statement
    Description      : Line up assignment statements such that the assignment operator are aligned.
    SourceType       : Builtin
    SourceName       : PS
    Severity         : Warning
    ImplementingType : Microsoft.Windows.PowerShell.ScriptAnalyzer.BuiltinRules.AlignAssignmentStatement
        Name : Enable, etc.
        PropertyType.Name : Boolean, etc.
    #>

    # is rule enabled by default?
    $RuleEnabled = $RuleDefaults.Where({$_.RuleName -eq $Rule.RuleName}).Enabled -eq 'Yes'
    $RuleConfigurable = $RuleDefaults.Where({$_.RuleName -eq $Rule.RuleName}).Configurable -eq 'Yes'

    # find configurable rule properties
    $RuleProperties = $Rule.ImplementingType.GetProperties() |
        ? Name -NE 'DiagnosticSeverity' |
        % {
            $customAttr = $_.GetCustomAttributes($false)
            $defaultValue = if ($null -ne $customAttr.DefaultValue) {
                $customAttr.DefaultValue
            }

            [pscustomobject]@{
                Name     = $_.Name
                # Types: Boolean, List`1, int32, string, string[], diagnosticseverity
                Type     = $_.PropertyType.Name
                TypeJSON = $NETTypeToJSONType[$_.PropertyType.Name]
                Default  = $defaultValue
            }
        }
    # $RuleProperties | select name,propertytype

    $RuleList[$Rule.RuleName] = [pscustomobject]@{
        RuleName    = $Rule.RuleName
        CommonName  = $Rule.CommonName
        Description = $Rule.Description
        Type        = $Rule.ImplementingType
        Enabled     = $RuleEnabled
        Config      = $RuleProperties
    }

    # add rule to include or exclude based on 'enabled by default'
    if ($RuleEnabled) {
        $JSONRules.IncludeRules += $Rule.RuleName
    }
    else {
        $JSONRules.ExcludeRules += $Rule.RuleName
    }

    if ($RuleConfigurable -and $RuleProperties.Count -gt 0) {
        # add default value by type
        $RuleProperties | % {
            $JSONRules.Rules[$Rule.RuleName] += @{
                $_.Name = $_.Default
            }
        }
    }
}

$ConfigurableRules = $RuleList.Keys | Where-Object { $null -ne $RuleList[$_].Config }

Write-Host "Found $($RuleList.Count) built-in rules with $($ConfigurableRules.Count) configurable."
Write-Host "Generating PSScriptAnalyzer settings JSON with $($JSONRules.Count) rules..."

$JSONRuleSchema = @()
$JSONRuleSchema += $ConfigurableRules | ForEach-Object {
    $ruleName = $_.RuleName
    $ruleDescription = $_.Description
    @{
        $ruleName = @{
            Const       = $ruleName
            Type        = 'string'
            Description = $ruleDescription
        }
    }
}

# $JSONOutput = $JSONRuleSchema | ConvertTo-Json -Depth 5 -EnumsAsStrings

# $JSONOutput = $ConfigurableRules | ConvertTo-Json -Depth 5 -EnumsAsStrings
# $JSONOutput | Set-Clipboard
