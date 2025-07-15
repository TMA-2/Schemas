@{
    # ref: https://docs.poshtools.com/powershell-pro-tools-documentation/packaging/package.psd1#config-file-schema
    <# Notes:
        PowerShellVersion and DotNetVersion must be compatible according to this table:
        | PowerShellVersion  | DotNetVersion                                  |
        | ------------------ | -------------                                  |
        | Windows PowerShell | net462, net470, net471, net472, net480, net481 |
        | 7.0.x              | netcoreapp31                                   |
        | 7.1.x              | net50                                          |
        | 7.2.x              | net60                                          |
        | 7.3.x              | net70                                          |
        | 7.4.x              | net80, net81                                   |
        | 7.5.x              | net90                                          |
    #>

    # Root: Root script to package. This is the main entry point for the package.
    Root       = 'Path\to\script.ps1'
    # OutputPath: The output directory for the resulting executable.
    OutputPath = 'debug'
    # Package: Options for the packager. See the config file schema for the proper layout.
    Package    = @{
        # Enabled: Whether the packager is enabled.
        Enabled             = $true
        # Obfuscate: Whether to obfuscate the assembly. Only valid when PowerShellVersion = Windows PowerShell.
        #   Note: this is a legacy technique (for educational purposes) which is easily reversed by free modern security tools.
        Obfuscate           = $true
        # HideConsoleWindow: Whether to hide the console window. Useful for when packaging form applications.
        HideConsoleWindow   = $true
        # FileDescription: The file description to display in the assembly properties.
        FileDescription     = 'My App'
        # FileVersion: The file version to display in the assembly properties.
        FileVersion         = '0.1.0'
        # ProductName: The product name to display in the assembly properties.
        ProductName         = 'My App'
        # ProductVersion: The product version to display in the assembly properties.
        ProductVersion      = '0.1.0'
        # Copyright: The copyright to display in the assembly properties.
        Copyright           = '(c) 2025'
        # RequireElevation: Whether the executable requires elevation to run. This setting is only supported on Windows.
        RequireElevation    = $false
        # ApplicationIconPath: The path to the icon to display for this application.
        ApplicationIconPath = 'Resources\icon.ico'
        # PackageType: Type of package to create. Accepted values are Console, Service, or Windows.
        PackageType         = 'Windows'
        # HighDPISupport: Enable high DPI support for Windows Forms applications.
        HighDPISupport      = $true
        # PowerShellArguments: Additional arguments to provide to the PowerShell process. This can include arguments like -ExecutionPolicy or -NoProfile. It must not include -Command.
        PowerShellArguments = '-NoProfile -ExecutionPolicy Bypass'
        # Platform: The target architecture for the executable. Accepted values are x86 or x64.
        Platform            = 'x64'
        <# PowerShellVersion: The PowerShell version to target. Ensure that you specify a supported DotNetVersion when selecting your PowerShell version.
        #>
        PowerShellVersion   = 'Windows PowerShell'
        # DotNetVersion: The .NET version to target for the executable. This must be compatible with PowerShellVersion.
        DotNetVersion       = 'net480'
        # RuntimeIdentifier: The .NET runtime identifier to target. This defaults to win-x64. If you wish to target Linux, you could specify linux-x64. You can find a list of valid .NET runtime identifiers at https://docs.microsoft.com/en-us/dotnet/core/rid-catalog
        RuntimeIdentifier   = 'win-x64'
        # DisableQuickEdit: Disables the quick edit mode on Windows console applications. This defaults to $false. Either $true or $false.
        DisableQuickEdit    = $false
        # Resources: An array of resource strings to include with the executable. These resources will be stored embedded.
        Resources           = @(
            'Data.psd1'
            'Resources\icon.ico'
            'Resources\Utility.ps1'
        )
        # DotNetSdk: This is an advanced option. The target .NET SDK to use when packaging the executable. If not specified, the highest version will be used.
        DotNetSdk           = ''
        # Certificate: The certificate used to sign the assembly. The packager will use Set-AuthenticodeSignature to sign the assembly. This should be the path to a valid code signing certificate. For example: 'Cert:\CurrentUser\AuthRoot\02FAF3E291435468607857694DF5E45B68851555'
        Certificate         = ''
        # OutputName: The name of the output assembly. When this is not specified, this will be the root script name.
        OutputName          = 'MyScript'
        # Host: Specifies the PowerShell host to use. The Default host will use the .NET SDK to create and package a script executable. The Ironman PowerShell hosts do not function this way, lacking support for PowerShell 7, Obfuscation, Services, and Resources. You can read more about hosts here: https://docs.poshtools.com/powershell-pro-tools-documentation/packaging/package-hosts.
        #   The supported values are: Default, IronmanPowerShellHost, IronmanPowerShellWinFormsHost
        Host                = 'IronmanPowerShellWinFormsHost'
        # Lightweight: Removes WinForms and WPF support from .NET 7\PowerShell 7 executables. This reduces the overall footprint of the executable by about 45%.
        Lightweight         = $false
        # ServiceName: The name of the service when packaging a service (e.g. "MyService").
        ServiceName       = 'MyService'
        # ServiceDisplayName: The display name of the service when packaging a service (e.g. "My Utility Service").
        ServiceDisplayName  = 'My Amazing Service'
    }
    Bundle     = @{
        # Enabled: Bundling will include referenced scripts and modules in the resulting executable.
        Enabled             = $true
        # Modules: Whether to bundle modules with the script executable. Modules will only be bundled when imported with Import-Module.
        Modules             = $false
        # NestedModules: Whether to include nested modules of packaged modules. Requires Modules = $true.
        NestedModules       = $false
        # IgnoredModules: An array of modules to ignore during packaging.
        IgnoredModules      = @(
            "ActiveDirectory"
            "PSReadLine"
        )
    }
}
