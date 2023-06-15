function logRegistryButton_Click {
  $folderDialog.ShowDialog()
  $folderSelected = $folderDialog.SelectedPath
  if (-not $folderSelected) { return }
  
  $projectNpmrcPath = Join-Path $folderSelected ".npmrc"
  if (-not (Test-Path $projectNpmrcPath)) {
    invoke-modal ".npmrc non trovato"
    return
  }
  
  $npmrcContent = (Get-Content $projectNpmrcPath)
  if (-not $npmrcContent) {
    invoke-modal ".npmrc sembra essere vuoto"
    return
  }
  
  $projectNuGetPath = Join-Path $folderSelected "NuGet.config"
  if (-not (Test-Path $projectNuGetPath)) {
    invoke-modal "nuGet non trovato"
    return
  }
  
  [xml]$nuGetContent = (Get-Content $projectNuGetPath)
  if (-not $nuGetContent) {
    invoke-modal "nuGet sembra essere vuoto"
    return
  }
  
  foreach ($row in $npmrcContent) {
    if ($row -match "devops.codearchitects") { invoke-log-registry $row.Split("/")[5] }
  }

  $credentials = invoke-getCredentialsFromNpmrc
  $nodes = ($nuGetContent.SelectNodes("/configuration/packageSources/*") | Where-Object { $_.key -ne 'nuget.org' })
  foreach ($node in $nodes) {
    dotnet nuget add source "$($node.value)" --valid-authentication-types basic -u "$($credentials.User)" -p "$($credentials.Token)" --store-password-in-clear-text -n "$($node.key)"
  }
  
  invoke-modal "Login sui registry di progetto completato"
}

function updateTokenButton_Click {
  if (-not $updateTokenText.Text) {
    invoke-modal "Non e' stato inserito alcun token"
    return 
  }
   
  $user = (invoke-getCredentialsFromNpmrc).User
  
  if (-not $user) {
    invoke-modal "Username non trovato all'interno del .nmprc"
    return
  }

  if (-not (invoke-check-npm-credential $user $updateTokenText.Text)) { 
    invoke-modal "Le credenziali risultano errate$([System.Environment]::NewLine)Utente: $user$([System.Environment]::NewLine)Token: $($updateTokenText.Text)"
    return 
  }
  
  $token = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($updateTokenText.Text))
  $npmrcContent = (Get-Content $npmrcPath)
  $newNpmrcContent = @()
  foreach ($row in $npmrcContent) {
    if ($row -match ":_password=" -and $row -match "devops.codearchitects") { $row = "$(($row -split ":_password=")[0]):_password=`"$token`"" }
    $newNpmrcContent += $row 
  }

  Set-Content -Path $npmrcPath -Value $newNpmrcContent

  [xml]$nuGetFile = Get-Content "~/AppData/Roaming/NuGet/nuget.config"
  $nugetRegistries = ($nuGetFile.SelectNodes("/configuration/packageSources/*") | Where-Object { $_.value.Contains("devops.codearchitects")}).key
  Write-Host $nugetRegistries
  foreach ($registry in $nugetRegistries) { 
   ($nuGetFile.SelectNodes("/configuration/packageSourceCredentials/$registry/add") | Where-Object { $_.key -eq 'ClearTextPassword' }).value = $updateTokenText.Text
  }
  $nuGetFile.save("$env:USERPROFILE/AppData/Roaming/NuGet/nuget.config")

  invoke-modal "Token aggiornato con successo"
}

function repairNpmrcButton_Click {
  if (Test-Path $npmrcPath) {
    Remove-Item -Path $npmrcPath -Force
    New-Item -Path $npmrcPath -Force | Out-Null
  }

  $loginForm.ShowDialog() | Out-Null
  invoke-modal ".npmrc rigenerato con successo."
}

function downloadScarfaceConfig_Click {
  invoke-DownloadScarConfigJson
  $credentials = invoke-getCredentialsFromNpmrc
  if (-not ($credentials.User -and $credentials.Token)) { 
    invoke-modal "Impossibile completare l'operazione.$([System.Environment]::NewLine).npmrc non trovato o corrotto.$([System.Environment]::NewLine)Rigenerare .nmprc e poi riprovare" 
    return
  }
  invoke-setCredentialScarfaceConfig $credentials.User $credentials.Token
  invoke-modal "File scaricato con successo$([System.Environment]::NewLine)Location:$scarConfigPath"
}

. .\src\components\Tabs\Tools\Form.ps1