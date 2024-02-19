# How to Update a Module

Semantic Release will handle the update process based on the rules defined in your `release` configuration in `package.json`. Ensure your commit messages follow the required format to trigger Semantic Release:

Use the following tag in the beginning of your commit messages:
- Use the `fix:` tag for bug fixes.
- Use the `feat:` tag for new features.
- Use the `breaking:` tag for breaking changes.

## Description

### package.json

Handles the settings and flow of semantic release.

### release.yml

Run the flow and build, releases and publishes a new version.

### CreateInstaller.ps1

Does the following:

1. Update .psd1 files with the new module version and sets the required version for the required modules.
2. Import the functions to the .psm1 files
3. Generate Documentation based on the functions Get-Help text
4. Creates the msi installer files

### Publish.ps1

Publish the modules to PowerShell Gallery.
