[xml]$a = Get-Content "~/AppData/Roaming/NuGet/nuget.config"
($a.SelectNodes("/configuration/packageSourceCredentials/back-office-nuget/add") | Where-Object{$_.key -eq 'ClearTextPassword'}).value = "asjkhdioasjd"
$a.save("$env:USERPROFILE/AppData/Roaming/NuGet/nuget.config")