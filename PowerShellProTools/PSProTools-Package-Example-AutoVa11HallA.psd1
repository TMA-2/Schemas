@{
    # Root script to package. This is the main entry point for the package.
    Root       = 'C:\users\tma2\onedrive\source\autova11halla\AutoValHallA.ps1'
    # The output directory for the resulting executable.
    OutputPath = 'C:\users\tma2\onedrive\source\autova11halla\bin\Debug'
    # Options for the packager. See the config file schema for the proper layout.
    Package    = @{
        # Whether the packager is enabled. Valid values are either $true or $false.
        Enabled             = $true
        # Whether to obfuscate the assembly. Only valid for Windows PowerShell.
        # Valid values are $true or $false. Note: this is a legacy technique (for educational purposes) which is easily reversed by free modern security tools.
        Obfuscate           = $false
        # Whether to hide the console window. Useful for when packaging form applications. Valid values are $true or $false.
        HideConsoleWindow   = $true
        # The file description to display in the assembly properties.
        FileDescription     = 'Auto VA-11 Hall-A Game Utility'
        # The file version to display in the assembly properties.
        FileVersion         = '0.2.9'
        # The product name to display in the assembly properties.
        ProductName         = 'Auto VA-11 Hall-A'
        # The product version to display in the assembly properties.
        ProductVersion      = '0.2.9'
        # The copyright to display in the assembly properties.
        Copyright           = '(c) 2024 TMA-2'
        # Whether the executable requires elevation to run. This setting is only supported on Windows. Either $true or $false.
        RequireElevation    = $false
        # The path to the icon to display for this application.
        ApplicationIconPath = 'C:\users\tma2\onedrive\source\autova11halla\Resources\Jill64.ico'
        # Type of package to create (Console or Service).
        PackageType         = 'Console'
        # Enable high DPI support for Windows Forms applications. Either $true or $false.
        HighDPISupport      = $true
        # Additional arguments to provide to the PowerShell process. This can include arguments like -ExecutionPolicy or -NoProfile. Do not include -Command.
        PowerShellArguments = '-NoProfile -ExecutionPolicy Bypass'
        # The target architecture for the executable. This should be either x86 or x64.
        Platform            = 'x64'
        <# The PowerShell version to target. Ensure that you specify a supported .NET version with DotNetVersion when selecting your PowerShell version. Supported versions are:
        - Windows PowerShell
        - 7.0.x
        - 7.1.x
        - 7.2.x
        - 7.3.x
        - 7.4.x
        #>
        PowerShellVersion   = '7.4.0'
        <# The .NET version to target for the executable. You can find the valid values below based on the PowerShellVersion property.
            net4.6.2 / Windows PowerShell
            net4.7.0 / Windows PowerShell
            net4.7.1 / Windows PowerShell
            net4.7.2 / Windows PowerShell
            net4.8.0 / Windows PowerShell
            netcoreapp31 / 7.0.x
            net5.0 / 7.1.x
            net6.0 / 7.2.x
            net7.0 / 7.3.x
            net8.0 / 7.4.x
        #>
        DotNetVersion       = 'net8.0'
        # The .NET runtime identifier to target. This defaults to win-x64. If you wish to target Linux, you could specify linux-x64. You can find a list of valid .NET runtime identifiers at https://docs.microsoft.com/en-us/dotnet/core/rid-catalog
        RuntimeIdentifier   = 'win-x64'
        # Disables the quick edit mode on Windows console applications. This defaults to $false. Either $true or $false.
        DisableQuickEdit    = $false
        # An array of resource strings to include with the executable. These resources will be stored embedded.
        Resources           = [string[]]@(
            'C:\users\tma2\onedrive\source\autova11halla\AutoValHallA-Data.psd1',
            'C:\users\tma2\onedrive\source\autova11halla\AutoValHallA.resources.ps1',
            'C:\users\tma2\onedrive\source\autova11halla\Resources\Jill64.ico'
            <#
            'Resources\Jill64.png'
            'Resources\DrinkList.psd1'
            'Resources\AutoItX.psd1'
            'Resources\AutoItX3.PowerShell.dll'
            'Resources\AutoItX3.Assembly.dll'
            'Resources\AutoItX3.Assembly.xml'
            'Resources\AutoItX3_x64.dll'
            'Resources\AutoItX3.dll' #>
        )
        # This is an advanced option. The target .NET SDK to use when packaging the executable. If not specified, the highest version will be used.
        # DotNetSdk           = ''
        # The certificate used to sign the assembly. The packager will use Set-AuthenticodeSignature to sign the assembly. This should be the path to a valid code signing certificate. For example: 'Cert:\CurrentUser\AuthRoot\02FAF3E291435468607857694DF5E45B68851555'
        # Certificate         = ''
        # The name of the output assembly. When this is not specified, this will be the root script name.
        # OutputName          = 'AutoValHallA'
        <# Specifies the PowerShell host to use. The Default host will use the .NET SDK to create and package a script executable. The Ironman PowerShell hosts do not function this way, lacking support for PowerShell 7, Obfuscation, Services, and Resources. You can read more about Ironman Software hosts here: https://docs.poshtools.com/powershell-pro-tools-documentation/packaging/package-hosts.
        The supported hosts are:
        - Default
        - IronmanPowerShellHost
        - IronmanPowerShellWinFormsHost
        #>
        Host                = 'Default'
        # Removes WinForms and WPF support from .NET 7\PowerShell 7 executables. This reduces the overall footprint of the executable by about 45%.
        Lightweight         = $false
        # The name of the service when packaging a service (e.g. "MyService").
        # ServiceName       = ''
        # The display name of the service when packaging a service (e.g. "My Utility Service").
        # ServiceDisplayName  = ''
    }
    Bundle     = @{
        # Bundling will include referenced scripts and modules in the resulting executable.
        Enabled             = $true
        # Whether to bundle modules with the script executable. Modules will only be bundled when imported with Import-Module.
        Modules             = $false
        # Whether to include nested modules of packaged modules. Requires Modules = $true.
        NestedModules       = $false
        # An array of modules to ignore during packaging.
        # IgnoredModules      = [string[]]@()
    }
}
