# TODO

## General
- [x] Update TODO.

## AnyConnectProfile
> [!INFO]
> Only for backup reasons.

## ISESnippetFormat.xsd
> [!WARNING]
> LOW PRIORITY.
- [ ] Strip out everything Visual Studio-only.
- [ ] More research needed for other settings (if any).
  - [ ] Load ISE or the ISE module (like the -Snippet cmdlets) into ILSpy and figure out how snippets are handled to determine supported elements.
- [ ] Perform a broad GitHub file search for xml containing `<snippets>` root element or the apparent `schemas.microsoft.com/powershell/snippets` schema URL

## PackageTemplate
- [ ] Sync with Template package schema

## PowerShell Config
- [ ] Check for new features in 7.6.1
- [ ] Possibly separate by PS minor version?
  - [ ] Check newer JSON Schema drafts for advanced conditionals

## PowerShell Module Manifest
> [!WARNING]
> LOW PRIORITY.
- [ ] Only work on this if there's even the *slightest* interest.
- [ ] Make some type of sense of all the example files.

## PropertyList (lol no)
- [x] Leave it alone ffs.

## PowerShell Pro Tools
> [!WARNING]
> Low priority
- [ ] Wait until you or someone else has the ability / time to integrate JSON-based packaging settings.

## PS Script Analyzer
- [ ] Update to include v1.25 `PSAlignAssignmentStatement` description & settings.
- [ ] Update [`Build-ScriptAnalyzerSchema.ps1`](Build-ScriptAnalyzerSchema.ps1) to check for new PSSA versions (from the github repo or `find-module`) and rules by parsing repo docs or updating to the latest version before running `Get-ScriptAnalyzerRule`.
  - [ ] Parse the markdown help docs for the full descriptions.
- [ ] Semi-related task: Unify the help format for rule info (severity, configurable, default, etc.), description, configuration info, examples.
  - [ ] Write a GitHub Copilot agent to apply this standard to all documentation
  - [ ] Or, write a script to parse the markdown and output a pscustomobject showing which rules are followed along with their content. Kind of... linting the linter docs?
  - [ ] Add markdownlinter settings according to MS Learn standards.

## Specter
- [ ] Copy PS Script Analyzer schema and modify to taste.

## SpeedCrunch
- [x] This is... done.

## Tanium Software Package
> [!WARNING]
> Low priority
- [ ] Decide if this is even worth fucking with. Is it in service of a script that parses and runs these? Is *that* worth doing, or should Tanium do their fucking job instead?

## THR Drive Mapping
- [ ] Don't work on this unless there's even a *shred* of interest in the idea.

## VS Snippet Format
- [x] Nothing to do here, really.

## XML Documentation (for .NET Assembly)
- [ ] Build out further... but it's **low priority**.
