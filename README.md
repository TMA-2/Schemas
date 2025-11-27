# Schemas
Various JSON and XML schemas, either original, or which don't exist elsewhere.

## AnyConnectProfile.xsd
This is just a copy of the Cisco Secure Client profile schema. It can normally be found under "c:\ProgramData\Cisco\Cisco Secure Client\VPN\Profile\AnyConnectProfile.xsd".

## ISESnippetFormat.xsd
For the ISE snippet format, taken from the Visual Studio snippet schema and modified, since the schema URL is no longer available and doesn't exist in any cache that I've looked in.
I don't even know what the original schema filename might be, nor is there any local copy to the best of my knowledge.
Despite being clearly influenced by the Visual Studio snippet format, it definitely doesn't support all the same features, but it likely supports more than the included ones.

A number of possible examples of elements and features it supports *might* be found in the snippets included with the [ISE Steroids module](https://www.powershellgallery.com/packages/ISESteroids/2.7.1.9/) under `/Snippets`.
However, some of the features may be unique to the module, such as Requirements, Declarations, etc.

## powershell.config.schema.json
A simple schema for the PowerShell Core configuration file found in your profile (`Documents\PowerShell\powershell.config.json`). Nothing fancy. [Documentation here](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_powershell_config).

## PowerShellModuleManifest.jsonc
A stupid idea for having JSON-based module manifests instead of psd1, since the latter doesn't support schema (even though it damn well should by now). I probably won't do anything with this.

## PropertyList-1.0.xsd
An updated XSD schema for the *stupid* PList format which I honestly despise. Another thing I likely won't do anything with. (what is wrong with me?)

## PSScriptAnalyzer.schema.json
A test schema for a potential JSON PSScriptAnalyzer settings file format, which is currently PSD1-based. It includes all the rules as of PSScriptAnalyzer 1.24.0, with their descriptions included.

## PSProToolsPackage.schema.json
A schema for a JSON version of the PowerShell Pro Tools package format, which is originally psd1-based, but which I've suggested should be JSON. Notes are in [PSProTools-Package-Notes.md](PSProTools-Package-Notes.md).

## Tanium-Software-Package.schema.jsonc
A schema I partially vibe-generated for the Tanium `software-package.json` format which can be exported and imported.
Of course, it's broken by default due to there being two "installed" keys with different capitalization, so it has to be cleaned right off the bat before anything further can be done.
Working on a PowerShell script to process these... or in other words, to do exactly what Tanium does with them. Kind of stupid, honestly, but once completed, it may be easier than using the web interface.

## VSSnippetFormat.xsd
Just a copy of the Visual Studio snippet schema.

## XmlDocumentation.xsd
Needs a better, less generic name. Slightly modified custom schema for the .NET assembly XML documentation format.

Taken from [csharptest.net](http://csharptest.net/493/xsd-for-xml-comments-for-net-documentation/index.html), so thanks to the original author for starting it!
