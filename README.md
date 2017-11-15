# PSBackup

Idea to create a method for backing up powershell environment to a remote website, for restoration later to a new environment.  Thought is that it could be used on a new machine or borrowed machine to get the shell back to the way you're used to it.  Things that could be backed up:
    all profile.ps1 scripts
    any dot-sourced scripts from the profiles
    references to any modules installed from the PSGallery
    any imported modules that didn't come from PSGallery
    psget repository settings

Current idea is that the backup could just be a large block of JSON.  For the private modules maybe make a catalog or zip file, backup as base64 string or something.  Not sure exactly
There would be two parts to this project, the "server" side and the "client" side

Cross-platform support would be cool.  Save on windows, restore on linux and vice-versa.
## Server

Create a webserver and API with POSH Universal Dashboards with OAuth login support.  Web interface would be a dashboard showing backup stats (number of backups, log of which machines were backed up) and maybe the most recent backup in JSON format.
Associated API would be used for the writing and retrieving the backup data.  The client cmdlets would interface with this API.

Code will be available to stand up the server on any web server, for use in corporate environments.  Also potentially publish the whole thing to Azure for a publicly-available repository for all to use.

## Client

Powershell module to include commands for saving the backup to the API server and restoring it.
* Save-PSBackup (parameters to pick which items to backup)
* Get-PSBackup (options for selecting hostname and datetime)
* Restore-PSBackup (options for selecting which things to restore. in the case of modules select user or machine scope)
* Connect-PSBackupServer

## To-Do

* everything!
* need to figure out what kind of database to use that the POSHUD can interface with
* decide on list of things to backup, and define JSON data structure
* probably start with the client side, just backing up to and restoring from a text file.