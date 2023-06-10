#---------------------------------------------------------[Initialisations]--------------------------------------------------------
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$tabStart = New-Object System.Windows.Forms.Panel
$tabStart.Location = "175, 25"
$tabStart.Size = "800, 500"
$tabStart.BackColor = "White"
$tabStart.BorderStyle = "1"
$tabStart.BackColor = "#00ffffff"

$welcomeLabel = New-Object System.Windows.Forms.Label
$welcomeLabel.Text = "Benvenuti nel setup del Code Architects Enterprise Platform"
$welcomeLabel.AutoSize = $true
$welcomeLabel.Location = "75, 15"
$welcomeLabel.Font = 'Century Gothic, 17'
$welcomeLabel.BackColor = "Transparent"

$startButton = New-Object System.Windows.Forms.Button
$startButton.BackColor = "#19c5ff"
$startButton.Text = "Inizia"
$startButton.Size = "125, 40"
$startButton.Location = "337, 55"
$startButton.Font = 'Century Gothic, 15'
$startButton.ForeColor = "#ffffff"
$startButton.FlatStyle = "Flat"
$startButton.FlatAppearance.BorderSize = 0;
$startButton.FlatAppearance.MouseOverBackColor = "#0463ca"

$updateTokenButton = New-Object System.Windows.Forms.Button
$updateTokenButton.BackColor = "#19c5ff"
$updateTokenButton.Text = "Aggiorna Token"
$updateTokenButton.Size = "125, 50"
$updateTokenButton.Location = "115, 50"
$updateTokenButton.Font = 'Century Gothic, 15'
$updateTokenButton.ForeColor = "#ffffff"
$updateTokenButton.FlatStyle = "Flat"
$updateTokenButton.FlatAppearance.BorderSize = 0;
$updateTokenButton.FlatAppearance.MouseOverBackColor = "#0463ca"

$logRegistryButton = New-Object System.Windows.Forms.Button
$logRegistryButton.BackColor = "#19c5ff"
$logRegistryButton.Text = "Aggiungi registry progetto"
$logRegistryButton.Size = "145, 50"
$logRegistryButton.Location = "550, 50"
$logRegistryButton.Font = 'Century Gothic, 13'
$logRegistryButton.ForeColor = "#ffffff"
$logRegistryButton.FlatStyle = "Flat"
$logRegistryButton.FlatAppearance.BorderSize = 0;
$logRegistryButton.FlatAppearance.MouseOverBackColor = "#0463ca"

$horizontalLine = New-Object System.Windows.Forms.Label
$horizontalLine.Text = ""
$horizontalLine.BorderStyle = "Fixed3D"
$horizontalLine.AutoSize = $false
$horizontalLine.Width = $tabStart.ClientSize.Width
$horizontalLine.Height = 3
$horizontalLine.Location = "0, 110"

$gridConnections = New-Object System.Windows.Forms.DataGridView
$gridConnections.Name = "Grid"
$gridConnections.BorderStyle = 0
$gridConnections.RowHeadersVisible = $false
$gridConnections.EnableHeadersVisualStyles = $false
$gridConnections.BackgroundColor = "#ededed"
$gridConnections.DefaultCellStyle.BackColor = "#ffffff"
$gridConnections.DefaultCellStyle.SelectionBackColor = "Transparent"
$gridConnections.DefaultCellStyle.SelectionForeColor = "Transparent"
$gridConnections.DefaultCellStyle.Alignment = "MiddleCenter"
$gridConnections.AdvancedCellBorderStyle.All = "None"
$gridConnections.AllowUserToResizeRows = $false
$gridConnections.AutoSizeRowsMode = "AllCells";
$linkColumn = New-Object System.Windows.Forms.DataGridViewLinkColumn
$linkColumn.Width = "200";
$linkColumn.HeaderText = "Connessione a"
$linkColumn.SortMode = "NotSortable";
$linkColumn.ActiveLinkColor = "Blue";
$linkColumn.VisitedLinkColor  = "Blue";
$linkColumn.DefaultCellStyle.Font = "Century Gothic, 13"
$gridConnections.Columns.Insert(0, $linkColumn)
$imageColumn = New-Object System.Windows.Forms.DataGridViewImageColumn
$imageColumn.Width = "100";
$imageColumn.HeaderText = "Status"
$imageColumn.SortMode = "NotSortable";
$gridConnections.Columns.Insert(1, $imageColumn)
$gridConnections.AllowUserToResizeColumns = $false;
$gridConnections.ColumnHeadersBorderStyle = 4
$gridConnections.ColumnHeadersDefaultCellStyle.Font = "Century Gothic, 15"
$gridConnections.ColumnHeadersDefaultCellStyle.ForeColor = "#ffffff"
$gridConnections.ColumnHeadersDefaultCellStyle.BackColor = "#555555"
$gridConnections.ColumnHeadersDefaultCellStyle.Alignment = "MiddleCenter"
$gridConnections.ColumnHeadersHeightSizeMode = "DisableResizing"
$gridConnections.Size = "300, 125"
$gridConnections.Location = "25, 120"
$gridConnections.MultiSelect = $false
$gridConnections.AllowUserToAddRows = $false
$gridConnections.ReadOnly = $true

$gridEnvVar = New-Object System.Windows.Forms.DataGridView
$gridEnvVar.Name = "Grid"
$gridEnvVar.BorderStyle = 0
$gridEnvVar.RowHeadersVisible = $false
$gridEnvVar.EnableHeadersVisualStyles = $false
$gridEnvVar.BackgroundColor = "#ededed"
$gridEnvVar.DefaultCellStyle.Font = "Century Gothic, 13"
$gridEnvVar.DefaultCellStyle.BackColor = "#ffffff"
$gridEnvVar.DefaultCellStyle.SelectionBackColor = "Transparent"
$gridEnvVar.DefaultCellStyle.SelectionForeColor = "Transparent"
$gridEnvVar.AdvancedCellBorderStyle.All = "None"
$gridEnvVar.AllowUserToResizeRows = $false
$gridEnvVar.AutoSizeRowsMode = "AllCells";
$gridEnvVar.ColumnCount = 2
$gridEnvVar.Columns[0].Name = "Variabile d'ambiente";
$gridEnvVar.Columns[0].Width = "450";
$gridEnvVar.Columns[0].SortMode = "NotSortable";
$gridEnvVar.Columns[1].Name = "Stato";
$gridEnvVar.Columns[1].Width = "135";
$gridEnvVar.Columns[1].SortMode = "NotSortable";
$gridEnvVar.AllowUserToResizeColumns = $false;
$gridEnvVar.ColumnHeadersBorderStyle = 4
$gridEnvVar.ColumnHeadersDefaultCellStyle.Font = "Century Gothic, 15"
$gridEnvVar.ColumnHeadersDefaultCellStyle.ForeColor = "#ffffff"
$gridEnvVar.ColumnHeadersDefaultCellStyle.BackColor = "#555555"
$gridEnvVar.ColumnHeadersDefaultCellStyle.Alignment = "MiddleCenter"
$gridEnvVar.ColumnHeadersHeightSizeMode = "DisableResizing"
$gridEnvVar.Size = "585, 225"
$gridEnvVar.Location = "25, 255"
$gridEnvVar.MultiSelect = $false
$gridEnvVar.AllowUserToAddRows = $false
$gridEnvVar.ReadOnly = $true

$infoEnvVarutton = New-Object System.Windows.Forms.Button
$infoEnvVarutton.BackColor = "#19c5ff"
$infoEnvVarutton.Text = "?"
$infoEnvVarutton.Size = "25, 25"
$infoEnvVarutton.Location = "625, 280"
$infoEnvVarutton.Font = 'Century Gothic, 11'
$infoEnvVarutton.ForeColor = "#ffffff"
$infoEnvVarutton.FlatStyle = "Flat"
$infoEnvVarutton.FlatAppearance.BorderSize = 0;
$infoEnvVarutton.FlatAppearance.MouseOverBackColor = "#0463ca"

$infoProxyButton = New-Object System.Windows.Forms.Button
$infoProxyButton.BackColor = "#19c5ff"
$infoProxyButton.Text = "?"
$infoProxyButton.Size = "25, 25"
$infoProxyButton.Location = "365, 130"
$infoProxyButton.Font = 'Century Gothic, 11'
$infoProxyButton.ForeColor = "#ffffff"
$infoProxyButton.FlatStyle = "Flat"
$infoProxyButton.FlatAppearance.BorderSize = 0;
$infoProxyButton.FlatAppearance.MouseOverBackColor = "#0463ca"

$proxyLabel = New-Object System.Windows.Forms.Label
$proxyLabel.Text = "Proxy:"
$proxyLabel.AutoSize = $true
$proxyLabel.Location = "400, 130"
$proxyLabel.Font = 'Century Gothic, 15'
$proxyLabel.BackColor = "Transparent"

$proxyCheck = New-Object System.Windows.Forms.PictureBox
$proxyCheck.Size = "30, 24"
$proxyCheck.Location = "460, 130"
$proxyCheck.SizeMode = "Zoom"
$proxyCheck.BackColor = "Transparent"

$infoVmButton = New-Object System.Windows.Forms.Button
$infoVmButton.BackColor = "#19c5ff"
$infoVmButton.Text = "?"
$infoVmButton.Size = "25, 25"
$infoVmButton.Location = "520, 130"
$infoVmButton.Font = 'Century Gothic, 11'
$infoVmButton.ForeColor = "#ffffff"
$infoVmButton.FlatStyle = "Flat"
$infoVmButton.FlatAppearance.BorderSize = 0;
$infoVmButton.FlatAppearance.MouseOverBackColor = "#0463ca"

$vmLabel = New-Object System.Windows.Forms.Label
$vmLabel.Text = "Virtual machine:"
$vmLabel.AutoSize = $true
$vmLabel.Location = "555, 130"
$vmLabel.Font = 'Century Gothic, 15'
$vmLabel.BackColor = "Transparent"

$vmCheck = New-Object System.Windows.Forms.PictureBox
$vmCheck.Size = "30, 24"
$vmCheck.Location = "720, 130"
$vmCheck.SizeMode = "Zoom"
$vmCheck.BackColor = "Transparent"

$infoWSLButton = New-Object System.Windows.Forms.Button
$infoWSLButton.BackColor = "#19c5ff"
$infoWSLButton.Text = "?"
$infoWSLButton.Size = "25, 25"
$infoWSLButton.Location = "365, 170"
$infoWSLButton.Font = 'Century Gothic, 11'
$infoWSLButton.ForeColor = "#ffffff"
$infoWSLButton.FlatStyle = "Flat"
$infoWSLButton.FlatAppearance.BorderSize = 0;
$infoWSLButton.FlatAppearance.MouseOverBackColor = "#0463ca"

$WSLLabel = New-Object System.Windows.Forms.Label
$WSLLabel.Text = "Windows Subsystem for Linux:"
$WSLLabel.AutoSize = $true
$WSLLabel.Location = "400, 170"
$WSLLabel.Font = 'Century Gothic, 15'
$WSLLabel.BackColor = "Transparent"

$WSLCheck = New-Object System.Windows.Forms.PictureBox
$WSLCheck.Size = "30, 24"
$WSLCheck.Location = "700, 170"
$WSLCheck.SizeMode = "Zoom"
$WSLCheck.BackColor = "Transparent"

$infoVMPlatformButton = New-Object System.Windows.Forms.Button
$infoVMPlatformButton.BackColor = "#19c5ff"
$infoVMPlatformButton.Text = "?"
$infoVMPlatformButton.Size = "25, 25"
$infoVMPlatformButton.Location = "365, 210"
$infoVMPlatformButton.Font = 'Century Gothic, 11'
$infoVMPlatformButton.ForeColor = "#ffffff"
$infoVMPlatformButton.FlatStyle = "Flat"
$infoVMPlatformButton.FlatAppearance.BorderSize = 0;
$infoVMPlatformButton.FlatAppearance.MouseOverBackColor = "#0463ca"

$VMPlatformLabel = New-Object System.Windows.Forms.Label
$VMPlatformLabel.Text = "Virtual Machine Platform:"
$VMPlatformLabel.AutoSize = $true
$VMPlatformLabel.Location = "400, 210"
$VMPlatformLabel.Font = 'Century Gothic, 15'
$VMPlatformLabel.BackColor = "Transparent"

$VMPlatformCheck = New-Object System.Windows.Forms.PictureBox
$VMPlatformCheck.Size = "30, 24"
$VMPlatformCheck.Location = "660, 210"
$VMPlatformCheck.SizeMode = "Zoom"
$VMPlatformCheck.BackColor = "Transparent"

$folderDialog = New-Object System.Windows.Forms.FolderBrowserDialog
$folderDialog.Description = "Seleziona una cartella"
$tabStart.controls.AddRange(@($welcomeLabel, $startButton, $updateTokenButton, $logRegistryButton, $horizontalLine, $gridConnections, $gridEnvVar, $infoEnvVarutton, $infoProxyButton, $proxyLabel, $proxyCheck, $infoVmButton, $vmLabel, $vmCheck, $infoWSLButton, $WSLLabel, $WSLCheck, $infoVMPlatformButton, $VMPlatformLabel, $VMPlatformCheck))
# $welcomeForm.controls.AddRange(@($logo, $panel, $horizontalLine))

#---------------------------------------------------------[Events]--------------------------------------------------------

$tabStart.Add_VisibleChanged({ tabStart_VisibleChanged })
$startButton.Add_Click({ startButton_Click })
$updateTokenButton.Add_Click({ updateTokenButton_Click })
$logRegistryButton.Add_Click({ logRegistryButton_Click })
$infoEnvVarutton.Add_Click({ infoEnvVarutton_Click })
$infoVmButton.Add_Click({ infoVmButton_Click })
$infoProxyButton.Add_Click({ infoProxyButton_Click })
$infoVMPLatformButton.Add_Click({ infoVMPLatformButton_Click })
$infoWSLButton.Add_Click({ infoWSLButton_Click })
$gridConnections.Add_CellContentClick({ gridConnections_CellContentClick })
$gridEnvVar.Add_Click({ gridEnvVar_Click })
# SIG # Begin signature block
# MIIkyAYJKoZIhvcNAQcCoIIkuTCCJLUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUYmSl/5/gTU6FFR+e+4/um1SS
# MoOggh6kMIIFOTCCBCGgAwIBAgIQDue4N8WIaRr2ZZle0AzJjDANBgkqhkiG9w0B
# AQsFADB8MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
# MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxJDAi
# BgNVBAMTG1NlY3RpZ28gUlNBIENvZGUgU2lnbmluZyBDQTAeFw0yMTAxMjUwMDAw
# MDBaFw0yNDAxMjUyMzU5NTlaMIGgMQswCQYDVQQGEwJJVDEOMAwGA1UEEQwFNzAw
# MjkxDTALBgNVBAgMBEJhcmkxGzAZBgNVBAcMElNhbnRlcmFtbyBpbiBDb2xsZTEZ
# MBcGA1UECQwQVmlhIENhbXBhbmlhLDEvMzEcMBoGA1UECgwTQ29kZSBBcmNoaXRl
# Y3RzIFNybDEcMBoGA1UEAwwTQ29kZSBBcmNoaXRlY3RzIFNybDCCASIwDQYJKoZI
# hvcNAQEBBQADggEPADCCAQoCggEBALaj4vlKflM4B+dR8Cz8Z7RA4CUe2iR2WGp9
# /qTN2Eg+7RG74V7gBsOqyllqNdmUecwqwbiRbPB4+s83rYxwRZf1s/cEmtcKWUpu
# g4Kde2XKIMz8IigS5P+4qFStWeY5VkybU1CDWyHpj4iUiYyy3D6BbLxIhwTyjVDz
# 6h/VIlAqDt6tNSIkACdp0CRPDe1/I3HLVLVRqSbek473Enbijb4H3oSrsnCqF7Xx
# +UBa7zUNo5fZNBRJb4IfRq17uKQ8oNz+2KcIB74hsXm1X2v8Igm6upua/Td8kZ0b
# CuuogqPoUbEKXTNMd5D32JUAi7KpgKWE4CCbG7zk7ivGpAii6OUCAwEAAaOCAZAw
# ggGMMB8GA1UdIwQYMBaAFA7hOqhTOjHVir7Bu61nGgOFrTQOMB0GA1UdDgQWBBTz
# X2/Q/EHWaGVPiGGw0uJSmluXeDAOBgNVHQ8BAf8EBAMCB4AwDAYDVR0TAQH/BAIw
# ADATBgNVHSUEDDAKBggrBgEFBQcDAzARBglghkgBhvhCAQEEBAMCBBAwSgYDVR0g
# BEMwQTA1BgwrBgEEAbIxAQIBAwIwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0
# aWdvLmNvbS9DUFMwCAYGZ4EMAQQBMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9j
# cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNvZGVTaWduaW5nQ0EuY3JsMHMGCCsG
# AQUFBwEBBGcwZTA+BggrBgEFBQcwAoYyaHR0cDovL2NydC5zZWN0aWdvLmNvbS9T
# ZWN0aWdvUlNBQ29kZVNpZ25pbmdDQS5jcnQwIwYIKwYBBQUHMAGGF2h0dHA6Ly9v
# Y3NwLnNlY3RpZ28uY29tMA0GCSqGSIb3DQEBCwUAA4IBAQBlnIYjhWZ4sTIbd/yg
# CjBcY2IKtXvL5Nts38z5c/7NtoJrP5C7MyjdVfgP5hTcXGVsKbZu1FwI+qlmcKcl
# YO9fiNP8qOIxDKrlETyduXknx70mjok/ZrrbrPYiCIRf3imGWb0dU6U1iDsphhng
# My2352B8K4RICeHd/pLY8PGyM276RIVRL9qv/welyakOoqs9n8JPz4SkQKZ1LELb
# rHtxU9gSC6M/Sz3T0wLCF+qZw388HgpT0iv1PCWr3LFuzY1FxD9hOaGrVQKu1GeM
# VBqF3Ac+jRy308kqZlzwvR5s6mYFyEvxS9CoUNBERBEFgULSkGH5O7SVjUcbiK8w
# BlToMIIFgTCCBGmgAwIBAgIQOXJEOvkit1HX02wQ3TE1lTANBgkqhkiG9w0BAQwF
# ADB7MQswCQYDVQQGEwJHQjEbMBkGA1UECAwSR3JlYXRlciBNYW5jaGVzdGVyMRAw
# DgYDVQQHDAdTYWxmb3JkMRowGAYDVQQKDBFDb21vZG8gQ0EgTGltaXRlZDEhMB8G
# A1UEAwwYQUFBIENlcnRpZmljYXRlIFNlcnZpY2VzMB4XDTE5MDMxMjAwMDAwMFoX
# DTI4MTIzMTIzNTk1OVowgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcgSmVy
# c2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVT
# VCBOZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRpb24g
# QXV0aG9yaXR5MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAgBJlFzYO
# w9sIs9CsVw127c0n00ytUINh4qogTQktZAnczomfzD2p7PbPwdzx07HWezcoEStH
# 2jnGvDoZtF+mvX2do2NCtnbyqTsrkfjib9DsFiCQCT7i6HTJGLSR1GJk23+jBvGI
# GGqQIjy8/hPwhxR79uQfjtTkUcYRZ0YIUcuGFFQ/vDP+fmyc/xadGL1RjjWmp2bI
# cmfbIWax1Jt4A8BQOujM8Ny8nkz+rwWWNR9XWrf/zvk9tyy29lTdyOcSOk2uTIq3
# XJq0tyA9yn8iNK5+O2hmAUTnAU5GU5szYPeUvlM3kHND8zLDU+/bqv50TmnHa4xg
# k97Exwzf4TKuzJM7UXiVZ4vuPVb+DNBpDxsP8yUmazNt925H+nND5X4OpWaxKXwy
# hGNVicQNwZNUMBkTrNN9N6frXTpsNVzbQdcS2qlJC9/YgIoJk2KOtWbPJYjNhLix
# P6Q5D9kCnusSTJV882sFqV4Wg8y4Z+LoE53MW4LTTLPtW//e5XOsIzstAL81VXQJ
# SdhJWBp/kjbmUZIO8yZ9HE0XvMnsQybQv0FfQKlERPSZ51eHnlAfV1SoPv10Yy+x
# UGUJ5lhCLkMaTLTwJUdZ+gQek9QmRkpQgbLevni3/GcV4clXhB4PY9bpYrrWX1Uu
# 6lzGKAgEJTm4Diup8kyXHAc/DVL17e8vgg8CAwEAAaOB8jCB7zAfBgNVHSMEGDAW
# gBSgEQojPpbxB+zirynvgqV/0DCktDAdBgNVHQ4EFgQUU3m/WqorSs9UgOHYm8Cd
# 8rIDZsswDgYDVR0PAQH/BAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wEQYDVR0gBAow
# CDAGBgRVHSAAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwuY29tb2RvY2Eu
# Y29tL0FBQUNlcnRpZmljYXRlU2VydmljZXMuY3JsMDQGCCsGAQUFBwEBBCgwJjAk
# BggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMA0GCSqGSIb3DQEB
# DAUAA4IBAQAYh1HcdCE9nIrgJ7cz0C7M7PDmy14R3iJvm3WOnnL+5Nb+qh+cli3v
# A0p+rvSNb3I8QzvAP+u431yqqcau8vzY7qN7Q/aGNnwU4M309z/+3ri0ivCRlv79
# Q2R+/czSAaF9ffgZGclCKxO/WIu6pKJmBHaIkU4MiRTOok3JMrO66BQavHHxW/BB
# C5gACiIDEOUMsfnNkjcZ7Tvx5Dq2+UUTJnWvu6rvP3t3O9LEApE9GQDTF1w52z97
# GA1FzZOFli9d31kWTz9RvdVFGD/tSo7oBmF0Ixa1DVBzJ0RHfxBdiSprhTEUxOip
# akyAvGp4z7h/jnZymQyd/teRCBaho1+VMIIF9TCCA92gAwIBAgIQHaJIMG+bJhjQ
# guCWfTPTajANBgkqhkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgT
# Ck5ldyBKZXJzZXkxFDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUg
# VVNFUlRSVVNUIE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlm
# aWNhdGlvbiBBdXRob3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMxMjM1OTU5
# WjB8MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAw
# DgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxJDAiBgNV
# BAMTG1NlY3RpZ28gUlNBIENvZGUgU2lnbmluZyBDQTCCASIwDQYJKoZIhvcNAQEB
# BQADggEPADCCAQoCggEBAIYijTKFehifSfCWL2MIHi3cfJ8Uz+MmtiVmKUCGVEZ0
# MWLFEO2yhyemmcuVMMBW9aR1xqkOUGKlUZEQauBLYq798PgYrKf/7i4zIPoMGYmo
# bHutAMNhodxpZW0fbieW15dRhqb0J+V8aouVHltg1X7XFpKcAC9o95ftanK+ODtj
# 3o+/bkxBXRIgCFnoOc2P0tbPBrRXBbZOoT5Xax+YvMRi1hsLjcdmG0qfnYHEckC1
# 4l/vC0X/o84Xpi1VsLewvFRqnbyNVlPG8Lp5UEks9wO5/i9lNfIi6iwHr0bZ+UYc
# 3Ix8cSjz/qfGFN1VkW6KEQ3fBiSVfQ+noXw62oY1YdMCAwEAAaOCAWQwggFgMB8G
# A1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0GA1UdDgQWBBQO4TqoUzox
# 1Yq+wbutZxoDha00DjAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIB
# ADAdBgNVHSUEFjAUBggrBgEFBQcDAwYIKwYBBQUHAwgwEQYDVR0gBAowCDAGBgRV
# HSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9V
# U0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDB2BggrBgEFBQcB
# AQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNlcnRydXN0LmNvbS9VU0VS
# VHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcwAYYZaHR0cDovL29jc3Au
# dXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEATWNQ7Uc0SmGk295qKoyb
# 8QAAHh1iezrXMsL2s+Bjs/thAIiaG20QBwRPvrjqiXgi6w9G7PNGXkBGiRL0C3da
# nCpBOvzW9Ovn9xWVM8Ohgyi33i/klPeFM4MtSkBIv5rCT0qxjyT0s4E307dksKYj
# alloUkJf/wTr4XRleQj1qZPea3FAmZa6ePG5yOLDCBaxq2NayBWAbXReSnV+pbjD
# bLXP30p5h1zHQE1jNfYw08+1Cg4LBH+gS667o6XQhACTPlNdNKUANWlsvp8gJRAN
# GftQkGG+OY96jk32nw4e/gdREmaDJhlIlc5KycF/8zoFm/lv34h/wCOe0h5DekUx
# wZxNqfBZslkZ6GqNKQQCd3xLS81wvjqyVVp4Pry7bwMQJXcVNIr5NsxDkuS6T/Fi
# kyglVyn7URnHoSVAaoRXxrKdsbwcCtp8Z359LukoTBh+xHsxQXGaSynsCz1XUNLK
# 3f2eBVHlRHjdAd6xdZgNVCT98E7j4viDvXK6yz067vBeF5Jobchh+abxKgoLpbn0
# nu6YMgWFnuv5gynTxix9vTp3Los3QqBqgu07SqqUEKThDfgXxbZaeTMYkuO1dfih
# 6Y4KJR7kHvGfWocj/5+kUZ77OYARzdu1xKeogG/lU9Tg46LC0lsa+jImLWpXcBw8
# pFguo/NbSwfcMlnzh6cabVgwggbsMIIE1KADAgECAhAwD2+s3WaYdHypRjaneC25
# MA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMKTmV3IEpl
# cnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJV
# U1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0aW9u
# IEF1dGhvcml0eTAeFw0xOTA1MDIwMDAwMDBaFw0zODAxMTgyMzU5NTlaMH0xCzAJ
# BgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcT
# B1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDElMCMGA1UEAxMcU2Vj
# dGlnbyBSU0EgVGltZSBTdGFtcGluZyBDQTCCAiIwDQYJKoZIhvcNAQEBBQADggIP
# ADCCAgoCggIBAMgbAa/ZLH6ImX0BmD8gkL2cgCFUk7nPoD5T77NawHbWGgSlzkeD
# tevEzEk0y/NFZbn5p2QWJgn71TJSeS7JY8ITm7aGPwEFkmZvIavVcRB5h/RGKs3E
# Wsnb111JTXJWD9zJ41OYOioe/M5YSdO/8zm7uaQjQqzQFcN/nqJc1zjxFrJw06PE
# 37PFcqwuCnf8DZRSt/wflXMkPQEovA8NT7ORAY5unSd1VdEXOzQhe5cBlK9/gM/R
# EQpXhMl/VuC9RpyCvpSdv7QgsGB+uE31DT/b0OqFjIpWcdEtlEzIjDzTFKKcvSb/
# 01Mgx2Bpm1gKVPQF5/0xrPnIhRfHuCkZpCkvRuPd25Ffnz82Pg4wZytGtzWvlr7a
# TGDMqLufDRTUGMQwmHSCIc9iVrUhcxIe/arKCFiHd6QV6xlV/9A5VC0m7kUaOm/N
# 14Tw1/AoxU9kgwLU++Le8bwCKPRt2ieKBtKWh97oaw7wW33pdmmTIBxKlyx3GSuT
# lZicl57rjsF4VsZEJd8GEpoGLZ8DXv2DolNnyrH6jaFkyYiSWcuoRsDJ8qb/fVfb
# Enb6ikEk1Bv8cqUUotStQxykSYtBORQDHin6G6UirqXDTYLQjdprt9v3GEBXc/Bx
# o/tKfUU2wfeNgvq5yQ1TgH36tjlYMu9vGFCJ10+dM70atZ2h3pVBeqeDAgMBAAGj
# ggFaMIIBVjAfBgNVHSMEGDAWgBRTeb9aqitKz1SA4dibwJ3ysgNmyzAdBgNVHQ4E
# FgQUGqH4YRkgD8NBd0UojtE1XwYSBFUwDgYDVR0PAQH/BAQDAgGGMBIGA1UdEwEB
# /wQIMAYBAf8CAQAwEwYDVR0lBAwwCgYIKwYBBQUHAwgwEQYDVR0gBAowCDAGBgRV
# HSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9V
# U0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDB2BggrBgEFBQcB
# AQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNlcnRydXN0LmNvbS9VU0VS
# VHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcwAYYZaHR0cDovL29jc3Au
# dXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEAbVSBpTNdFuG1U4GRdd8D
# ejILLSWEEbKw2yp9KgX1vDsn9FqguUlZkClsYcu1UNviffmfAO9Aw63T4uRW+VhB
# z/FC5RB9/7B0H4/GXAn5M17qoBwmWFzztBEP1dXD4rzVWHi/SHbhRGdtj7BDEA+N
# 5Pk4Yr8TAcWFo0zFzLJTMJWk1vSWVgi4zVx/AZa+clJqO0I3fBZ4OZOTlJux3LJt
# QW1nzclvkD1/RXLBGyPWwlWEZuSzxWYG9vPWS16toytCiiGS/qhvWiVwYoFzY16g
# u9jc10rTPa+DBjgSHSSHLeT8AtY+dwS8BDa153fLnC6NIxi5o8JHHfBd1qFzVwVo
# mqfJN2Udvuq82EKDQwWli6YJ/9GhlKZOqj0J9QVst9JkWtgqIsJLnfE5XkzeSD2b
# NJaaCV+O/fexUpHOP4n2HKG1qXUfcb9bQ11lPVCBbqvw0NP8srMftpmWJvQ8eYtc
# ZMzN7iea5aDADHKHwW5NWtMe6vBE5jJvHOsXTpTDeGUgOw9Bqh/poUGd/rG4oGUq
# NODeqPk85sEwu8CgYyz8XBYAqNDEf+oRnR4GxqZtMl20OAkrSQeq/eww2vGnL8+3
# /frQo4TZJ577AWZ3uVYQ4SBuxq6x+ba6yDVdM3aO8XwgDCp3rrWiAoa6Ke60WgCx
# jKvj+QrJVF3UuWp0nr1Irpgwggb1MIIE3aADAgECAhA5TCXhfKBtJ6hl4jvZHSLU
# MA0GCSqGSIb3DQEBDAUAMH0xCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVy
# IE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28g
# TGltaXRlZDElMCMGA1UEAxMcU2VjdGlnbyBSU0EgVGltZSBTdGFtcGluZyBDQTAe
# Fw0yMzA1MDMwMDAwMDBaFw0zNDA4MDIyMzU5NTlaMGoxCzAJBgNVBAYTAkdCMRMw
# EQYDVQQIEwpNYW5jaGVzdGVyMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxLDAq
# BgNVBAMMI1NlY3RpZ28gUlNBIFRpbWUgU3RhbXBpbmcgU2lnbmVyICM0MIICIjAN
# BgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEApJMoUkvPJ4d2pCkcmTjA5w7U0Rzs
# aMsBZOSKzXewcWWCvJ/8i7u7lZj7JRGOWogJZhEUWLK6Ilvm9jLxXS3AeqIO4OBW
# ZO2h5YEgciBkQWzHwwj6831d7yGawn7XLMO6EZge/NMgCEKzX79/iFgyqzCz2Ix6
# lkoZE1ys/Oer6RwWLrCwOJVKz4VQq2cDJaG7OOkPb6lampEoEzW5H/M94STIa7GZ
# 6A3vu03lPYxUA5HQ/C3PVTM4egkcB9Ei4GOGp7790oNzEhSbmkwJRr00vOFLUHty
# 4Fv9GbsfPGoZe267LUQqvjxMzKyKBJPGV4agczYrgZf6G5t+iIfYUnmJ/m53N9e7
# UJ/6GCVPE/JefKmxIFopq6NCh3fg9EwCSN1YpVOmo6DtGZZlFSnF7TMwJeaWg4Ga
# 9mBmkFgHgM1Cdaz7tJHQxd0BQGq2qBDu9o16t551r9OlSxihDJ9XsF4lR5F0zXUS
# 0Zxv5F4Nm+x1Ju7+0/WSL1KF6NpEUSqizADKh2ZDoxsA76K1lp1irScL8htKycOU
# QjeIIISoh67DuiNye/hU7/hrJ7CF9adDhdgrOXTbWncC0aT69c2cPcwfrlHQe2zY
# HS0RQlNxdMLlNaotUhLZJc/w09CRQxLXMn2YbON3Qcj/HyRU726txj5Ve/Fchzpk
# 8WBLBU/vuS/sCRMCAwEAAaOCAYIwggF+MB8GA1UdIwQYMBaAFBqh+GEZIA/DQXdF
# KI7RNV8GEgRVMB0GA1UdDgQWBBQDDzHIkSqTvWPz0V1NpDQP0pUBGDAOBgNVHQ8B
# Af8EBAMCBsAwDAYDVR0TAQH/BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcDCDBK
# BgNVHSAEQzBBMDUGDCsGAQQBsjEBAgEDCDAlMCMGCCsGAQUFBwIBFhdodHRwczov
# L3NlY3RpZ28uY29tL0NQUzAIBgZngQwBBAIwRAYDVR0fBD0wOzA5oDegNYYzaHR0
# cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBVGltZVN0YW1waW5nQ0EuY3Js
# MHQGCCsGAQUFBwEBBGgwZjA/BggrBgEFBQcwAoYzaHR0cDovL2NydC5zZWN0aWdv
# LmNvbS9TZWN0aWdvUlNBVGltZVN0YW1waW5nQ0EuY3J0MCMGCCsGAQUFBzABhhdo
# dHRwOi8vb2NzcC5zZWN0aWdvLmNvbTANBgkqhkiG9w0BAQwFAAOCAgEATJtlWPrg
# ec/vFcMybd4zket3WOLrvctKPHXefpRtwyLHBJXfZWlhEwz2DJ71iSBewYfHAyTK
# x6XwJt/4+DFlDeDrbVFXpoyEUghGHCrC3vLaikXzvvf2LsR+7fjtaL96VkjpYeWa
# OXe8vrqRZIh1/12FFjQn0inL/+0t2v++kwzsbaINzMPxbr0hkRojAFKtl9RieCqE
# eajXPawhj3DDJHk6l/ENo6NbU9irALpY+zWAT18ocWwZXsKDcpCu4MbY8pn76rSS
# ZXwHfDVEHa1YGGti+95sxAqpbNMhRnDcL411TCPCQdB6ljvDS93NkiZ0dlw3oJok
# nk5fTtOPD+UTT1lEZUtDZM9I+GdnuU2/zA2xOjDQoT1IrXpl5Ozf4AHwsypKOazB
# pPmpfTXQMkCgsRkqGCGyyH0FcRpLJzaq4Jgcg3Xnx35LhEPNQ/uQl3YqEqxAwXBb
# mQpA+oBtlGF7yG65yGdnJFxQjQEg3gf3AdT4LhHNnYPl+MolHEQ9J+WwhkcqCxuE
# dn17aE+Nt/cTtO2gLe5zD9kQup2ZLHzXdR+PEMSU5n4k5ZVKiIwn1oVmHfmuZHaR
# 6Ej+yFUK7SnDH944psAU+zI9+KmDYjbIw74Ahxyr+kpCHIkD3PVcfHDZXXhO7p9e
# IOYJanwrCKNI9RX8BE/fzSEceuX1jhrUuUAxggWOMIIFigIBATCBkDB8MQswCQYD
# VQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
# YWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxJDAiBgNVBAMTG1NlY3Rp
# Z28gUlNBIENvZGUgU2lnbmluZyBDQQIQDue4N8WIaRr2ZZle0AzJjDAJBgUrDgMC
# GgUAoIGEMBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3AgEEMBwGCisGAQQBgjcCAQsx
# DjAMBgorBgEEAYI3AgEVMCMGCSqGSIb3DQEJBDEWBBRqBf78sxynDynyb6V77xgl
# anOs3jAkBgorBgEEAYI3AgEMMRYwFKASgBAAQwBBACAAVABvAG8AbABzMA0GCSqG
# SIb3DQEBAQUABIIBAHXaMXXxl3RiCZsee4WPPKIDTcmBHIFdKC9IHkYHceCvjyMn
# cIms138bAlk3vC/mEjRMPQTG2P+iM/T/cTLSdEqPkbEZwlOPZCRCjZ2Vr7t84YQI
# bufO6MOt3m6tum85Drt9ZTVsIA8vAEjRakuwRI4E2p6oTTNWwmUZgPvS05J1yOSF
# 39kuduJhA+hOgeFGyJbS88RCNQGjuyVz80KkhepJOCgqhwwqmx6HSLgygTqOjhNX
# KWeQEB0F0ym+5/TUM3eiFmYzCM7RM+bgkI0jshMUkMD1zApE6GdSaeG1NzA++3d8
# DJ+nnh3w/rtax7hJp+AENZjL3KgCV6iAuR1NfQahggNLMIIDRwYJKoZIhvcNAQkG
# MYIDODCCAzQCAQEwgZEwfTELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
# TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBM
# aW1pdGVkMSUwIwYDVQQDExxTZWN0aWdvIFJTQSBUaW1lIFN0YW1waW5nIENBAhA5
# TCXhfKBtJ6hl4jvZHSLUMA0GCWCGSAFlAwQCAgUAoHkwGAYJKoZIhvcNAQkDMQsG
# CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjMwNTI1MTEwNTQxWjA/BgkqhkiG
# 9w0BCQQxMgQwKP50eszUJofTi7G4T6PjcfB8FN13WwThTfUYFezGq+69WNCD1UYu
# TlJqeo6na/HkMA0GCSqGSIb3DQEBAQUABIICABeUMFc6XgjKMlVHXtGaW8ykNUwZ
# l3JmT5vaRl/FJu6t+59X8L7A6zjoU/SdwZ+zj7KzV2wFmvg9FABH2ZfR6TR09RnF
# JebyZL/H774rLwoE8s8ooXyI3/D5ZFGYrxEnBBgvjJLvOPCH7/Tk6AQ6hEiZZ10w
# vqUd2C+eNucYDn98ovE5aCcuIAKQOcLUkj8OZh/aMqqbZvBCK43EuI4mL7X2c8hg
# 8v5Pfn2rS4ZncYL7tP0+exwO/Ul3eTi56SLKYSmghoq1WKqJDV7hhdI7knh+k4B9
# /+VFmeMdOHzX1KzsMR6UnUSWFKmyQDQlz+wlkr8wCywkP2DgMA/XFA1t74jmmUzD
# 1mhBweQVCtpalDYLlDgdei76JBhVJlFxxXD76nRX/6ZKCpMVSGsXjbvtOEVxwjPm
# xTwEYJybmdivp1AsqEbt+j46ADTpaGPM6+mzWpSFghaLwdCHsxc/Gv2+KBEz5SLf
# paGmV/iLU7ynis9VlibMWbWyV5ZbUVQTcZ9oZb0L9d0Yubp5jsxmKPDwbrMx4xiU
# nPqnPIb/JFaXotN0oWWAsCquQrsTmBup0h6Vqs0yG3m762QbS7AEeZIvRdZpuSVU
# FC5CCcbCiInExMXHJneCfbFncHFcV9VMSUe576U3gK65oUcOvIrdCuaY6rHLR02K
# kp5Tvb2AiG6fVHsx
# SIG # End signature block
