function  confirmButton_Click {
  if (-not $updateTokenTextBox.Text) {
    invoke-modal "Non e' stato inserito alcun token"
    return 
  }
   
  if (-not (Test-Path $npmrcPath)) {
    invoke-modal "$npmrcPath non esiste "
    return
  }

  $npmrcContent = (Get-Content -Path $npmrcPath)
  if (-not $npmrcContent) {
    Write-Host ".npmrc sembra essere vuoto, impossibile recuperare l'username"
    return
  }

  $user = ""
  foreach ($row in $npmrcContent) {
    if ($row -match ":username=" -and $row -match "devops.codearchitects")  { 
      $user = "$(($row -split ":username=")[0])" 
      break
    }
  }

  if (-not $user) {
    Write-Host "Username non trovato all'interno del .nmprc"
    return
  }

  if (-not (invoke-check-npm-credential $user $updateTokenTextBox.Text)) { return }
  
  $token = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($updateTokenTextBox.Text))
  $newNpmrcContent = @()
  foreach ($row in $npmrcContent) {
    if ($row -match ":_password=" -and $row -match "devops.codearchitects")  { $row = "$(($row -split ":_password=")[0]):_password=`"$token`"" }
    $newNpmrcContent += $row 
  }

  Set-Content -Path "~/.npmrc" -Value $newNpmrcContent
  updateCloseButton_Click
}

function updateCloseButton_Click {
  $updateTokenTextBox.Text = "";
  $updateTokenForm.Hide();
}

. .\src\components\updateToken\Form.ps1