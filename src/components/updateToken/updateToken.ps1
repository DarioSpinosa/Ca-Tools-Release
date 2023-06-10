function  confirmButton_Click {
  if (-not $updateTokenTextBox.Text) {
    invoke-modal "Non e' stato inserito alcun token"
    return 
  }
   
  if (-not (Test-Path $npmrcPath)) {
    invoke-modal "$npmrcPath non esiste "
    return
  }
  
  $token = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($updateTokenTextBox.Text))
  $npmrcContent = (Get-Content -Path "~/.npmrc").Split('')
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