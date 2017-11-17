#functions for backing up and restoring powershell repository
#backup script outputs JSON
#restore script expects JSON as input
$Exclusions = new-object psobject -Property @{
    PSRepository = @('Registered','ProviderOptions','Trusted')
}
Function BackupRepositorySettings {
    $AllPSRepositories = @()
    Foreach ($Repository in (Get-PSRepository)){
        $PSRepositoryBackup = @{}
        $Repository.psobject.properties |
            where-object {$_.value -ne $Null} |
            where-object {$exclusions.PSRepository -notcontains $_.name} |
            ForEach-Object {$PSRepositoryBackup[$_.name] = $_.value}
        $AllPSRepositories += $PSRepositoryBackup
    }
    return $AllPSRepositories | ConvertTo-Json
}

Function RestoreRepositorySettings{
    Param($RepositorySettings)
    Foreach ($object in ($RepositorySettings | ConvertFrom-Json)){
        $Props = @{}
        $object.psobject.properties |
            where-object {$_.value -ne $Null} |
            where-object {$Exclusions.PSRepository -notcontains $_.name} |
            ForEach-Object {$Props[$_.name] = $_.value}
        Register-PSRepository @Props
    }
}