param (
    [Parameter()]
    [string]
    $SpecterRulesFile = "$PSScriptRoot\SpecterRules.csv",

    [Parameter()]
    [string]
    $OutFile = "$PSScriptRoot\SpecterRules_Swapped.csv",

    [switch]
    $UpdateOriginal
)

$SpecterRules = Import-Csv -Path $SpecterRulesFile

$OrphanedRules = [System.Collections.Generic.Stack[string]]::new()

foreach ($Rule in $SpecterRules) {
    # skip blank rules
    if ($Rule.RuleName -eq '') {
        continue
    }
    # get the current index i, RuleName = A, mismatched ResourceName = B
    $Index = $SpecterRules.IndexOf($Rule)
    # if the cells don't match... i[A,B]
    if ($Rule.RuleName.Length -gt 0 -and $Rule.RuleName -ne $Rule.ResourceName) {
        # check if RuleName exists in ResourceName (j[,A])
        $RowIdx = $SpecterRules.ResourceName.IndexOf($Rule.RuleName)
        if ($RowIdx -eq -1) {
            continue
        }

        # save the index of the found row j
        $FoundRow = $SpecterRules[$RowIdx]
        if ([string]::IsNullOrEmpty($FoundRow.RuleName)) {
            wh "${Index}: Found $($FoundRow.ResourceName) at $RowIdx. Setting." -fore Green
            $SpecterRules[$RowIdx].RuleName = $Rule.RuleName
            $SpecterRules[$Index].RuleName = ''
        }
        # check if the found row is not j[A,A]
        elseif ($FoundRow.RuleName -ne $FoundRow.ResourceName) {
            if ($FoundRow.RuleName -eq $Rule.ResourceName) {
                wh "${Index}: Found [$RowIdx]$($FoundRow.ResourceName). Swapping values." -fore Cyan
                $SpecterRules[$RowIdx].RuleName = $Rule.RuleName
                $SpecterRules[$Index].RuleName = $FoundRow.RuleName
            }
            else {
                wh "${Index}: Found [$RowIdx]$($FoundRow.ResourceName). Setting rule and moving $($FoundRow.RuleName) to orphaned rules." -fore Cyan
                $OrphanedRules.Push($FoundRow.RuleName)
                $SpecterRules[$RowIdx].RuleName = $Rule.RuleName
                $SpecterRules[$Index].RuleName = ''
            }
        }
    }
}



if ($UpdateOriginal) {
    Export-Csv -Path $SpecterRulesFile -InputObject $SpecterRules -NoTypeInformation
}
else {
    Export-Csv -Path $OutFile -InputObject $SpecterRules -NoTypeInformation
}
