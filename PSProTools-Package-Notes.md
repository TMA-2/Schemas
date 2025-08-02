# PowerShell Pro Tools Packaging
[Documentation](https://docs.poshtools.com/powershell-pro-tools-documentation/packaging/package.psd1#config-file-schema)
[PSD1 Schema](PSProTools-Package-Schema.psd1)
[JSON Schema](PSProToolsPackage.schema.json)

## Steps
1. Within PowerShellToolsPro.Packager.PackageProcess.PackageProcess...
2. `Config = new PsPackConfig();`
3. `_stages = new Stage[];`
  1. `ValidateStage()`
    1. [`ValidateDotNetVersion(process);`](#validatestage-logic-for-net-version)
    2. [`ValidatePowerShellVersion(process);`](#validatestage-logic-for-powershellversion)
  2. `OutputPathStage()`
    1. If OutputPath is empty, throw exception
    2. If not rooted, combine current directory with OutputPath
    3. If it doesn't exist, create the directory
  3. `BundleStage()`
    1. If Root is empty, or doesn't exist, throw exception
    2. `var bundler = new Bundler(process.Config);`
    3. `bundler.Bundle(process.Config.Root)`
    4. Copy to Root to temp
  4. `CompileStage()`
    1. `compiler.BuildSingleFileExecutable(previousStage, process.Config.OutputPath, process.Config.Package, process.Config.Root);`
    2. See [Compiler.cs](https://github.com/ironmansoftware/powershell-pro-tools/blob/main/PowerShellToolsPro.Packager/Compiler.cs#L39)
  5. `UpdateHostStage()`
    1. Process if `process.Config.Package.Host == PowerShellHosts.Default && process.PackAsExecutable`
    2. See [UpdateHostStage.cs](https://github.com/ironmansoftware/powershell-pro-tools/blob/main/PowerShellToolsPro.Packager/UpdateHostStage.cs#L30)
  6. `ObfucatorStage()` *sic*
    1. Process if `process.Config.Package.Obfuscate && process.Config.Package.Enabled`
    2. `obfuscator.Obfuscate(previousStage.OutputFileName, process.Config.OutputPath, process.Config.Package.PowerShellVersion);`
    3. See [Obfuscator.cs](https://github.com/ironmansoftware/powershell-pro-tools/blob/main/PowerShellToolsPro.Packager/Obfuscator.cs#L14)

## Package Properties
### DotNetVersion

The .NET version to target for the executable. You can find the valid values below.
| PowerShellVersion  | DotNetVersion                                              |
|--------------------|------------------------------------------------------------|
| Windows PowerShell | net4.6.2, net4.7.0, net4.7.1, net4.7.2, net4.8.0, net4.8.1 |
| PowerShell 7.0.x   | netcoreapp31                                               |
| PowerShell 7.1.x   | net5.0                                                     |
| PowerShell 7.2.x   | net6.0                                                     |
| PowerShell 7.3.x   | net7.0                                                     |
| PowerShell 7.4.x   | net8.0, net8.1                                             |
| PowerShell 7.5.0   | net9.0                                                     |

#### Logic for .NET Version
[PackageProcess.cs](https://github.com/ironmansoftware/powershell-pro-tools/blob/main/PowerShellToolsPro.Packager/PackageProcess.cs#L145)
**Steps**
1. The DotNetVersion value has 'v' and '.' stripped, and 'net' appended to the beginning. So, `v5.0` becomes `net50`.
2. All `validNetVersions` are checked. If none match, an exception is thrown.
3. Then, `validNetVersionsForSystemDefault` are checked (framework versions `4.6.2` through `4.8.1`) if [PowerShellVersion](#powershellversion) is empty or 'Windows PowerShell'.
4. Then, `ValidNetVersionsForNew` are checked (`netcoreapp31` or `net50` through `net90`).
5. If none match, an exception is thrown.

**Snippet**
```cs
public class ValidateStage : Stage
{
    public string[] validNetVersionsForSystemDefault = new[] { "net462", "net470", "net471", "net472", "net480", "net481" };
    public string[] validNetVersionsForNew = new[] { "netcoreapp31", "net50", "net60", "net70", "net80", "net81", "net90" };
    public string[] validNetVersions = new[] { "net462", "net470", "net471", "net472", "net480", "net481", "netcoreapp31", "net50", "net60", "net70", "net80", "net90" };
    private void ValidateDotNetVersion(PackageProcess process)
    {
        var dotNetVersion = process.Config.Package.DotNetVersion.Trim('v').Replace(".", string.Empty);
        if (!dotNetVersion.StartsWith("net")) dotNetVersion = "net" + dotNetVersion;
        // cont.
    }
}
```

### PowerShellVersion

The PowerShell version to target. Defaults to Windows PowerShell. See [DotNetVersion](#dotnetversion) for the associaion between PS and .NET versions.
Ensure that you specify a supported .NET version when selecting your PowerShell version. Supported versions are (replace x with specific version number):

#### Logic for PowerShellVersion
**Steps**
[PackageProcess.cs](https://github.com/ironmansoftware/powershell-pro-tools/blob/main/PowerShellToolsPro.Packager/PackageProcess.cs#L196)
1. If PowerShellVersion is empty or == "Windows PowerShell", return
2. If PowerShellVersion contains "preview", the version check is skipped and returned
3. PowerShellVersion is parsed as a Version type and set to `version` var
4. `validPSVersions` are looped through, and returned once one == the set `version`

**Snippet**
```cs
public class ValidateStage : Stage
{
    public string[] validPSVersions = new[] {"7.2.0", "7.2.1", "7.2.10", "7.2.12", "7.2.13", "7.2.14", "7.2.16", "7.2.17", "7.2.18", "7.2.2", "7.2.21", "7.2.22", "7.2.23", "7.2.24", "7.2.3", "7.2.4", "7.2.5", "7.2.6", "7.2.7", "7.2.8", "7.2.9", "7.3.0", "7.3.1", "7.3.10", "7.3.11", "7.3.2", "7.3.3", "7.3.4", "7.3.5", "7.3.6", "7.3.7", "7.3.8", "7.3.9", "7.4.0", "7.4.1", "7.4.2", "7.4.3", "7.4.4", "7.4.5", "7.4.6", "7.4.7", "7.5.0"}
    private void ValidatePowerShellVersion(PackageProcess process) {}
}
```

### Host

Specifies the PowerShell host to use. The Default host will use the .NET SDK to create and package a script executable. The Ironman Software host's do not function this way. You can read more about Ironman Software hosts [here](https://docs.poshtools.com/powershell-pro-tools-documentation/packaging/package-hosts).

**Possible values:**
- Default
- IronmanowerShellHost
- IronmanPowerShellWinFormsHost
- PowerShell727
- PowerShell727Lightweight
- PowerShell727Winforms
- PowerShell727WinformsLightweight

