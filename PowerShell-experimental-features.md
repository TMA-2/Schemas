---
layout: Conceptual
monikers:
- powershell-5.1
- powershell-7.4
- powershell-7.5
- powershell-7.6
- powershell-7.7
- powershell-7.x
defaultMoniker: powershell-7.6
versioningType: Ranged
title: Using Experimental Features in PowerShell - PowerShell | Microsoft Learn
canonicalUrl: https://learn.microsoft.com/en-us/powershell/scripting/learn/experimental-features?view=powershell-7.6
config_moniker_range: '>=powershell-5.1'
ROBOTS: INDEX, FOLLOW
apiPlatform: powershell
archive_url: https://learn.microsoft.com/previous-versions/powershell/scripting/overview
breadcrumb_path: /powershell/scripting/bread/toc.json
feedback_product_url: https://github.com/powershell/powershell/issues/new
feedback_help_link_url: https://learn.microsoft.com/powershell/scripting/community/community-support
feedback_help_link_type: ask-the-community
feedback_system: OpenSource
hideScope: false
author: sdwheeler
ms.author: sewhee
manager: jasongroce
ms.devlang: powershell
ms.service: powershell
ms.tgt_pltfr: windows, macos, linux
ms.update-cycle: 365-days
toc_preview: true
uhfHeaderId: MSDocsHeader-Powershell
ms.subservice: conceptual
ms.topic: tutorial
products:
- https://authoring-docs-microsoft.poolparty.biz/devrel/2bdae855-045f-4535-b365-7b2e23824328
- https://authoring-docs-microsoft.poolparty.biz/devrel/8bce367e-2e90-4b56-9ed5-5e4e9f3a2dc3
description: Lists the currently available experimental features and how to use them.
ms.date: 2026-04-20T00:00:00.0000000Z
locale: en-us
document_id: 451cebe7-9762-98b1-8888-d8ff0e049bdb
document_version_independent_id: 106fcfb2-3609-f8ee-142e-91ed3616346e
updated_at: 2026-04-28T19:46:00.0000000Z
original_content_git_url: https://github.com/MicrosoftDocs/PowerShell-Docs/blob/live/reference/docs-conceptual/learn/experimental-features.md
gitcommit: https://github.com/MicrosoftDocs/PowerShell-Docs/blob/2cb1f087e1599e355397e91c0f088d25e137f9cd/reference/docs-conceptual/learn/experimental-features.md

---

# Using Experimental Features in PowerShell - PowerShell | Microsoft Learn

The Experimental Features support in PowerShell provides a mechanism for experimental features to coexist with existing stable features in PowerShell or PowerShell modules.

An experimental feature is one where the design isn't finalized. The feature is available for users to test and provide feedback. Once an experimental feature is finalized, the design changes become breaking changes.

Caution

Experimental features aren't intended to be used in production since the changes are allowed to be breaking. Experimental features aren't officially supported. However, we appreciate any feedback and bug reports. You can file issues in the [GitHub source repository](https://github.com/PowerShell/PowerShell/issues/new/choose).

For more information about enabling or disabling these features, see [about_Experimental_Features](/en-us/powershell/module/microsoft.powershell.core/about/about_experimental_features).

## Experimental feature lifecycle

The [Get-ExperimentalFeature](../../module/microsoft.powershell.core/get-experimentalfeature) cmdlet returns all experimental features available to PowerShell. Experimental features can come from modules or the PowerShell engine. Module-based experimental features are only available after you import the module. In the following example, the **PSDesiredStateConfiguration** isn't loaded, so the `PSDesiredStateConfiguration.InvokeDscResource` feature isn't available.

```powershell
Get-ExperimentalFeature
```

```Output
Name                            Enabled Source   Description
----                            ------- ------   -----------
PSFeedbackProvider                 True PSEngine Replace the hard-coded suggestion framework with the extensible feedb…
PSLoadAssemblyFromNativeCode      False PSEngine Expose an API to allow assembly loading from native code
PSNativeWindowsTildeExpansion      True PSEngine On windows, expand unquoted tilde (`~`) with the user's current home …
PSRedirectToVariable               True PSEngine Add support for redirecting to the variable drive
PSSerializeJSONLongEnumAsNumber    True PSEngine Serialize enums based on long or ulong as an numeric value rather tha…
PSSubsystemPluginModel             True PSEngine A plugin model for registering and un-registering PowerShell subsyste…
```

Use the [Enable-ExperimentalFeature](../../module/microsoft.powershell.core/enable-experimentalfeature) and [Disable-ExperimentalFeature](../../module/microsoft.powershell.core/disable-experimentalfeature) cmdlets to enable or disable a feature. You must start a new PowerShell session for this change to be in effect. Run the following command to enable the `PSCommandNotFoundSuggestion` feature:

```powershell
Enable-ExperimentalFeature PSFeedbackProvider
```

```Output
WARNING: Enabling and disabling experimental features do not take effect until next start
of PowerShell.
```

When an experimental feature becomes *mainstream*, it's no longer available as an experimental feature because the functionality is now part of the PowerShell engine or module. For example, the `PSAnsiRenderingFileInfo` feature became mainstream in PowerShell 7.3. You get the functionality of the feature automatically.

Note

Some features have configuration requirements, such as preference variables, that must be set to get the desired results from the feature.

When an experimental feature is *discontinued*, that feature is no longer available in the PowerShell. For example, the `PSNativePSPathResolution` feature was discontinued in PowerShell 7.3.

## Available features

This article describes the experimental features that are available and how to use the feature.

Legend

- The ![Experimental][01] icon indicates that the experimental feature is available in the version of PowerShell
- The ![Mainstream][02] icon indicates the version of PowerShell where the experimental feature became mainstream
- The ![Discontinued](../../media/shared/cross-mark-274c.svg) icon indicates the version of PowerShell where the experimental feature was removed

| Name                             | 7.4                 | 7.5                 | 7.6                 | 7.7                 |
| -------------------------------- | ------------------- | ------------------- | ------------------- | ------------------- |
| PSCommandNotFoundSuggestion      | ![Experimental][01] | ![Mainstream][02]   | ![Mainstream][02]   | ![Mainstream][02]   |
| PSCommandWithArgs                | ![Experimental][01] | ![Mainstream][02]   | ![Mainstream][02]   | ![Mainstream][02]   |
| PSFeedbackProvider               | ![Experimental][01] | ![Experimental][01] | ![Mainstream][02]   | ![Mainstream][02]   |
| PSLoadAssemblyFromNativeCode     | ![Experimental][01] | ![Experimental][01] | ![Experimental][01] | ![Experimental][01] |
| PSModuleAutoLoadSkipOfflineFiles | ![Experimental][01] | ![Mainstream][02]   | ![Mainstream][02]   | ![Mainstream][02]   |
| PSNativeWindowsTildeExpansion    |                     | ![Experimental][01] | ![Mainstream][02]   | ![Mainstream][02]   |
| PSProfileDSCResource             |                     |                     | ![Experimental][01] | ![Experimental][01] |
| PSRedirectToVariable             |                     | ![Experimental][01] | ![Mainstream][02]   | ![Mainstream][02]   |
| PSSerializeJSONLongEnumAsNumber  |                     | ![Experimental][01] | ![Experimental][01] | ![Experimental][01] |
| PSSubsystemPluginModel           | ![Experimental][01] | ![Experimental][01] | ![Mainstream][02]   | ![Mainstream][02]   |

PSDesiredStateConfiguration module v2 and higher

- PSDesiredStateConfiguration.InvokeDscResource

### PSCommandNotFoundSuggestion

Note

This feature became mainstream in PowerShell 7.5-preview.5.

Recommends potential commands based on fuzzy matching search after a **CommandNotFoundException**.

```powershell
PS> get
```

```Output
get: The term 'get' isn't recognized as the name of a cmdlet, function, script file,
or operable program. Check the spelling of the name, or if a path was included, verify
that the path is correct and try again.

Suggestion [4,General]: The most similar commands are: set, del, ft, gal, gbp, gc, gci,
gcm, gdr, gcs.
```

### PSCommandWithArgs

Note

This feature became mainstream in PowerShell 7.5-preview.5.

This feature enables the `-CommandWithArgs` parameter for `pwsh`. This parameter allows you to execute a PowerShell command with arguments. Unlike `-Command`, this parameter populates the `$args` built-in variable that can be used by the command.

The first string is the command and subsequent strings delimited by whitespace are the arguments.

For example:

```powershell
pwsh -CommandWithArgs '$args | % { "arg: $_" }' arg1 arg2
```

This example produces the following output:

```Output
arg: arg1
arg: arg2
```

This feature was added in PowerShell 7.4-preview.2.

### PSDesiredStateConfiguration.InvokeDscResource

Enables compilation to MOF on non-Windows systems and enables the use of `Invoke-DSCResource` without an LCM.

Beginning with PowerShell 7.2, the **PSDesiredStateConfiguration** module was removed and this feature is disabled by default. To enable this feature you must install the **PSDesiredStateConfiguration** v2.0.5 module from the PowerShell Gallery and enable the feature.

DSC v3 doesn't have this experimental feature. DSC v3 only supports `Invoke-DSCResource` and doesn't use or support MOF compilation. For more information, see [PowerShell Desired State Configuration v3](/en-us/powershell/dsc/overview?view=dsc-3.0&amp;preserve-view=true).

### PSFeedbackProvider

Note

This experimental feature was added in PowerShell 7.4-preview.3. This feature became mainstream in PowerShell 7.6-preview.6.

When you enable this feature, PowerShell uses a new feedback provider to give you feedback when a command can't be found. The feedback provider is extensible, and can be implemented by third-party modules. The feedback provider can be used by other subsystems, such as the predictor subsystem, to provide predictive IntelliSense results.

This feature includes two built-in feedback providers:

- **GeneralCommandErrorFeedback** serves the same suggestion functionality existing today
- **UnixCommandNotFound**, available on Linux, provides feedback similar to bash.

    The **UnixCommandNotFound** serves as both a feedback provider and a predictor. The suggestion from command-not-found command is used both for providing the feedback when command can't be found in an interactive run, and for providing predictive IntelliSense results for the next command line.

### PSLoadAssemblyFromNativeCode

Exposes an API to allow assembly loading from native code.

### PSModuleAutoLoadSkipOfflineFiles

Note

This feature became mainstream in PowerShell 7.5-preview.5.

With this feature enabled, if a user's **PSModulePath** contains a folder from a cloud provider, such as OneDrive, PowerShell no longer triggers the download of all files contained within that folder. Any file marked as not downloaded are skipped. Users who use cloud providers to sync their modules between machines should mark the module folder as **Pinned** or the equivalent status for providers other than OneDrive. Marking the module folder as **Pinned** ensures that the files are always kept on disk.

This feature was added in PowerShell 7.4-preview.1.

### PSNativeWindowsTildeExpansion

Note

This experimental feature was added in PowerShell 7.5-preview.2. This feature became mainstream in PowerShell 7.6-preview.6.

When this feature is enabled, PowerShell expands unquoted tilde (`~`) to the user's current home folder before invoking native commands. The following examples show how the feature works.

With the feature disabled, the tilde is passed to the native command as a literal string.

```powershell
PS> cmd.exe /c echo ~
~
```

With the feature enabled, PowerShell expands the tilde before it's passed to the native command.

```powershell
PS> cmd.exe /c echo ~
C:\Users\username
```

This feature only applies to Windows. On non-Windows platforms, tilde expansion is handled natively.

### PSProfileDSCResource

Note

This experimental feature was added in PowerShell 7.6-preview.6.

The PowerShell 7.6-preview.6 release added this feature as an advertisement for a new DSCv3 resource. The experimental feature flag doesn't do anything. You can use the new DSC v3 resource regardless of whether this feature is enabled or disabled.

The `Microsoft.PowerShell/Profile` resource enables you to manage PowerShell profiles using Desired State Configuration (DSC) v3. This release includes two new files in the `$PSHOME` folder:

- `pwsh.profile.dsc.resource.json` - DSC v3 resource manifest file
- `pwsh.profile.resource.ps1` - DSC v3 resource implementation file

The resource supports operations to get, set, and export profile content for different profile types. For more information, see the notes in the PR [PowerShell/PowerShell#26157](https://github.com/PowerShell/PowerShell/pull/26157).

### PSRedirectToVariable

Note

This experimental feature was added in PowerShell 7.5-preview.4. This feature became mainstream in PowerShell 7.6-preview.6.

When enabled, this feature adds support for redirecting to the Variable: drive. This feature allows you to redirect data to a variable using the `Variable:name` syntax. PowerShell inspects the target of the redirection and if it uses the Variable provider it calls `Set-Variable` rather than `Out-File`.

The following example shows how to redirect the output of a command to a Variable:

```powershell
. {
    "Output 1"
    Write-Warning "Warning, Warning!"
    "Output 2"
} 3> Variable:warnings
$warnings
```

```Output
Output 1
Output 2
WARNING: Warning, Warning!
```

### PSSerializeJSONLongEnumAsNumber

Note

This experimental feature was added in PowerShell 7.5-preview.5.

This feature enables the cmdlet [ConvertTo-Json](../../module/microsoft.powershell.utility/convertto-json) to serialize any enum values based on `Int64/long` or `UInt64/ulong` as a numeric value rather than the string representation of that enum value. This aligns the behavior of enum serialization with other enum base types where the cmdlet serializes enums as their numeric value. Use the **EnumsAsStrings** parameter to serialize as the string representation.

For example:

```powershell
# PSSerializeJSONLongEnumAsNumber disabled
@{
    Key = [System.Management.Automation.Tracing.PowerShellTraceKeywords]::Cmdlets
} | ConvertTo-Json
# { "Key": "Cmdlets" }

# PSSerializeJSONLongEnumAsNumber enabled
@{
    Key = [System.Management.Automation.Tracing.PowerShellTraceKeywords]::Cmdlets
} | ConvertTo-Json
# { "Key": 32 }

# -EnumsAsStrings to revert back to the old behaviour
@{
    Key = [System.Management.Automation.Tracing.PowerShellTraceKeywords]::Cmdlets
} | ConvertTo-Json -EnumsAsStrings
# { "Key": "Cmdlets" }
```

### PSSubsystemPluginModel

Note

This feature became mainstream in PowerShell 7.6-preview.6.

This feature enables the subsystem plugin model in PowerShell. The feature makes it possible to separate components of `System.Management.Automation.dll` into individual subsystems that reside in their own assembly. This separation reduces the disk footprint of the core PowerShell engine and allows these components to become optional features for a minimal PowerShell installation.

Currently, only the **CommandPredictor** subsystem is supported. This subsystem is used along with the PSReadLine module to provide custom prediction plugins. In future, **Job**, **CommandCompleter**, **Remoting** and other components could be separated into subsystem assemblies outside of `System.Management.Automation.dll`.

The experimental feature includes a new cmdlet, [Get-PSSubsystem](../../module/microsoft.powershell.core/get-pssubsystem). This cmdlet is only available when the feature is enabled. This cmdlet returns information about the subsystems that are available on the system.

[01]: ../../media/shared/construction-sign-1f6a7.svg
[02]: ../../media/shared/check-mark-button-2705.svg
