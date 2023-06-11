$tabTools = New-Object System.Windows.Forms.Panel
$tabTools.Location = "175, 25"
$tabTools.Size = "800, 500"
$tabTools.BackColor = "White"
$tabTools.BorderStyle = "1"
$tabTools.BackColor = "#00ffffff"

$updateTokenLabel = New-Object System.Windows.Forms.Label
$updateTokenLabel.Text = "Nuovo Token:"
$updateTokenLabel.AutoSize = $true
$updateTokenLabel.Size = '25, 20'
$updateTokenLabel.Height = 20
$updateTokenLabel.Location = '30, 50'
$updateTokenLabel.Font = 'Century Gothic, 10, style=Bold'
$updateTokenLabel.BackColor = "Transparent"

$updateTokenText = New-Object System.Windows.Forms.TextBox
$updateTokenText.Multiline = $false
$updateTokenText.Size = '350, 20'
$updateTokenText.Location = '30, 70'
$updateTokenText.Font = 'Century Gothic, 10'
$updateTokenText.TabStop = $false

$updateTokenButton = New-Object System.Windows.Forms.Button
$updateTokenButton.BackColor = "#19c5ff"
$updateTokenButton.Text = "Aggiorna Token"
$updateTokenButton.Size = "175, 35"
$updateTokenButton.Location = "30, 100"
$updateTokenButton.Font = 'Century Gothic, 15'
$updateTokenButton.ForeColor = "#ffffff"
$updateTokenButton.FlatStyle = "Flat"
$updateTokenButton.FlatAppearance.BorderSize = 0;
$updateTokenButton.FlatAppearance.MouseOverBackColor = "#0463ca"

$logRegistryButton = New-Object System.Windows.Forms.Button
$logRegistryButton.BackColor = "#19c5ff"
$logRegistryButton.Text = "Login npm registry di progetto"
$logRegistryButton.Size = "175, 50"
$logRegistryButton.Location = "30, 170"
$logRegistryButton.Font = 'Century Gothic, 13'
$logRegistryButton.ForeColor = "#ffffff"
$logRegistryButton.FlatStyle = "Flat"
$logRegistryButton.FlatAppearance.BorderSize = 0;
$logRegistryButton.FlatAppearance.MouseOverBackColor = "#0463ca"

$downloadScarfaceConfig = New-Object System.Windows.Forms.Button
$downloadScarfaceConfig.BackColor = "#19c5ff"
$downloadScarfaceConfig.Text = "Scarica scarface config"
$downloadScarfaceConfig.Size = "140, 50"
$downloadScarfaceConfig.Location = "30, 255"
$downloadScarfaceConfig.Font = 'Century Gothic, 13'
$downloadScarfaceConfig.ForeColor = "#ffffff"
$downloadScarfaceConfig.FlatStyle = "Flat"
$downloadScarfaceConfig.FlatAppearance.BorderSize = 0;
$downloadScarfaceConfig.FlatAppearance.MouseOverBackColor = "#0463ca"

$tabTools.controls.AddRange(@($logRegistryButton, $updateTokenLabel, $updateTokenText, $updateTokenButton, $downloadScarfaceConfig))

#---------------------------------------------------------[Events]--------------------------------------------------------

$logRegistryButton.Add_Click({ logRegistryButton_Click })
$updateTokenButton.Add_Click({ updateTokenButton_Click })
$downloadScarfaceConfig.Add_Click({ downloadScarfaceConfig_Click })