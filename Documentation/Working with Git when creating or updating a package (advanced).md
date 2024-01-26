# Working with Git when creating or updating a package (advanced)

See [Working with Git when creating or updating a package](Working%20with%20Git%20when%20creating%20or%20updating%20a%20package.md) for a simpler flow.

## Requirements

This is a list of requiremnts the seloution needs to work. You should also have a look at the Recommendations section.

### Service Account

You are goint to need a service account with administartor rights to CapaInstaller and the server you wish to run the GitHub Actions Runner on.

The service account needs local administrator rights on the server to run the Capa.PowerShell.Module, which requires local administrator rights to funtion.

In CapaInstaller the service account needs to be able to:

- Create a package
- Update the packages kit folder
- Promote the package
- Export the package to a location

### GitHub Actions Runner

#### Local

To use the GitHub Actions Runner locally and acrross multiple repositories (packages) you need to create a self-hosted runner in a GitHub Organization. So do the following:

1. [Create a GitHub Organization](https://docs.github.com/en/organizations/collaborating-with-groups-in-organizations/creating-a-new-organization-from-scratch)
2. Add a self-hosted runner to your organization and when asked for a labe us `CapaServer`, if you don't use this label you need to change the `runs-on` property in the `main.yml` file in the `.github/workflows` folder in the repository. Follow this guide to setup the runner: [Adding self-hosted runners](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/adding-self-hosted-runners#adding-a-self-hosted-runner-to-an-organization)

#### Cloud

### CapaInstaller

#### Development and production environment

## Recommendations

### Security setup in CapaInstaller

### Git Large File Storage (LFS)

### Branch protection rules

## Creating a new package

## Updating an existing package

## CapaPackages

## How to have multiple versions of the same software

## Repo structure

### .github/workflows

#### main.yml

#### versioning.yml

### Kit

### Scripts

### .gitingore

### Settings.json

### UpdatePackage.ps1