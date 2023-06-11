function logRegistryButton_Click {
  $folderDialog.ShowDialog()
  $folderSelected = $folderDialog.SelectedPath
  if (-not $folderSelected) { return }
  
  $projectNpmrcPath = Join-Path $folderSelected ".npmrc.txt"
  if (-not (Test-Path $projectNpmrcPath)) {
    invoke-modal ".npmrc non trovato"
    return
  }
  
  $npmrcContent = (Get-Content $projectNpmrcPath)
  if (-not $npmrcContent) {
    invoke-modal ".npmrc sembra essere vuoto"
    return
  }
  
  foreach ($row in $npmrcContent) {
    if ($row -match "devops.codearchitects") { invoke-log-registry $row.Split("/")[3] }
  }

  invoke-modal "Login sui registry di progetto completato"
}

function updateTokenButton_Click {
  if (-not $updateTokenText.Text) {
    invoke-modal "Non e' stato inserito alcun token"
    return 
  }
   
  $user = (invoke-getCredentialsFromNpmrc)[0]
  
  if (-not $user) {
    invoke-modal "Username non trovato all'interno del .nmprc"
    return
  }

  if (-not (invoke-check-npm-credential $user $updateTokenText.Text)) { return }
  
  $token = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($updateTokenText.Text))
  $npmrcContent = (Get-Content $npmrcPath)
  $newNpmrcContent = @()
  foreach ($row in $npmrcContent) {
    if ($row -match ":_password=" -and $row -match "devops.codearchitects") { $row = "$(($row -split ":_password=")[0]):_password=`"$token`"" }
    $newNpmrcContent += $row 
  }

  Set-Content -Path $npmrcPath -Value $newNpmrcContent

  [xml]$nuGetFile = Get-Content "~/AppData/Roaming/NuGet/nuget.config"
  ($nuGetFile.SelectNodes("/configuration/packageSourceCredentials/back-office-nuget/add") | Where-Object { $_.key -eq 'ClearTextPassword' }).value = $updateTokenText.Text
  $nuGetFile.save("$env:USERPROFILE/AppData/Roaming/NuGet/nuget.config")

  invoke-modal "Token aggiornato con successo"
}

function downloadScarfaceConfig_Click {
  invoke-DownloadScarConfigJson
  $credentials = invoke-getCredentialsFromNpmrc
  invoke-setCredentialScarfaceConfig $credentials[0] $credentials[1]
}

. .\src\components\Tabs\Tools\Form.ps1