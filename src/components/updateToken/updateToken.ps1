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
  $npmrcContent = (Get-Content -Path $npmrcPath -raw).Split('')
  $newNpmrcContent = @()
  $spaces = 0
  for ($i = 0; $i -lt $npmrcContent.Count; $i++) {
    if ($npmrcContent[$i] -match ":_password=") { $npmrcContent[$i] = "$(($npmrcContent[$i] -split ":_password=")[0]):_password=`"$token`"" }
    if ($npmrcContent[$i]) { $newNpmrcContent += $npmrcContent[$i] }
    else {
      $spaces = 0
      do {
        $i += 1
        $spaces += 1
      } while ((-not $npmrcContent[$i] -and $i -lt $npmrcContent.Count))
      if ($spaces -gt 1) {
        for ($j = 0; $j -lt $spaces; $j++) {
          $newNpmrcContent += ""
        }
      }
      $i -= 1
    }
  }
  Set-Content -Path $npmrcPath -Value $newNpmrcContent
  updateCloseButton_Click
}

function updateCloseButton_Click {
  $updateTokenForm.Hide();
}

. .\src\components\updateToken\Form.ps1