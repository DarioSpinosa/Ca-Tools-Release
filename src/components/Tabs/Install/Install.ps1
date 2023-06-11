#--------------------------------------------------------[FUNCTIONS]--------------------------------------------------------
function Invoke-installRequirements {
  if (installRequirements) { . .\src\requirements\install\ca-scarface.ps1 }
  $closeButton.Enabled = $true
  $toolsTabButton.Enabled = $true
}

function installRequirements {
  $success = $true 
  if (-not $requirements.Count) { return $success }

  invoke-CreateLogs $installLogs
  foreach ($name in $sortedRequirements) {
    #per mantenere un ordinamento  basato sulle dipendenze anche durante la fase di installazione
    if (-not $requirements.Contains($name)) { continue }
    Invoke-CreateRow $gridInstall $name | Out-Null
    $selectedInstall.Text = $name
    $selectedInstall.Refresh()
    writeOutputInstall($name)

    $requirement = $requirements[$name]
    $installLogs[$name]["Result"] = $(if (invoke-Dependencies "INSTALL" $requirement) { $requirement["Install"] | Invoke-Expression } else { "KO" })

    if ($installLogs[$name]["Result"] -eq 'OK') { 
      invoke-setColor $gridInstall $green
    }
    else { 
      invoke-setColor $gridInstall $red
      $success = $false 
    }

    $env:PATH = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
  }

  ($installLogs  | ConvertTo-Json) > $installRequirementsLogfile
  return $success
}

function gridInstall_VisibleChanged {
  $gridInstall.ClearSelection()
}

function gridInstall_Click {
  if (-not $gridInstall.Rows.Count) { return }
  $name = $gridInstall.CurrentRow.Cells[0].Value
  if ($name -eq $selectedInstall.Text) { return }  #Se si seleziona il requirement attualmente visualizzato, il click non caricherà nulla
  $selectedInstall.Text = $name
  $selectedInstall.Refresh()
  writeOutputInstall($name)
}

function writeOutputInstall($name) {
  $outputInstallLabel.Text = ""
  $outputInstallLabel.Refresh()
  $log = $(if (-not $installLogs[$name]["Logs"]) { "Nessun log disponibile" } else { ($installLogs[$name]["Logs"]).replace(";", [System.Environment]::NewLine).replace('\r\n', [System.Environment]::NewLine) })
  $outputInstallLabel.AppendText($log)
  $outputInstallLabel.Refresh()
}

function closeButton_Click {
  <#
  .SYNOPSIS
  Actions to clean the computer before closing the installer
  .DESCRIPTION
  Actions needed to be run before cloging the installer, such as:
  kill the client's side process, update the scarface.config.json and send the Install's results
  #>
  try {
    $netStat4200 = (netstat -ano | findstr :4200).split(" ") | Select-Object -Unique
    $clientPID = $netStat4200[5]
    taskkill /PID $clientPID /F
  }
  catch {
    Write-Host "No process running on port 4200"
  }

  Update-ScarfaceConfigJson
  Send-Logs
  if (($checkLogs["Docker"]["Result"] -eq "KO") -and ($installLogs["Docker"]["Result"] -eq "OK")) { logoff.exe } 
  $mainForm.Close()
}

function Update-ScarfaceConfigJson {
  <#
  .SYNOPSIS
  Update the scarface.config.json
  .DESCRIPTION
  Removes some of the elements inside the file, such as:
  application, domain, scenario, author and prefix
  So that the next time the user execute the command "ca scar" those fields will be asked to them
  #>
  $scarfaceConfigJson = Get-Content -Path $scarConfigPath -Raw | ConvertFrom-Json
  foreach ($element in @("application", "domain", "scenario", "author", "prefix")) {
    $scarfaceConfigJson.PSObject.Properties.Remove($element)
  }
  $scarfaceConfigJson | ConvertTo-Json -Depth 5 | Out-File -Encoding "ASCII" $scarConfigPath -Force
}

function Send-Logs {
  <#
  .SYNOPSIS
  Send all the logfiles to the private blob
  .DESCRIPTION
  Archive the .ca folder and sends it to the private blob
  #>
  $userLogin = ""

  # Transcript started in caep-installer.ps1
  Stop-Transcript

  $destination = "~\.ssh\"
  if (!(Test-Path $destination)) {
    New-Item -Path $destination -ItemType Directory -Force 
  }

  $startLocation = (Get-Location)
  $helperZipPath = new-Path $startLocation "helper.zip"
  Expand-Archive -Path $helperZipPath -DestinationPath $startLocation -Force

  $helperPath = new-Path $startLocation "helper\"
  Get-ChildItem -Path $helperPath -File | Move-Item -Destination $destination -Force

  $caZipPath = new-Path $startLocation "$($usernameTextBox.Text)-$currentDate.zip"
  $compress = @{
    Path             = "~\.ca\$currentDate"
    CompressionLevel = "Fastest"
    DestinationPath  = $caZipPath
  }
  
  Compress-Archive @Compress -Force
  $connectPath = new-Path $startLocation "connect.sh"
  &"C:\Program Files\Git\usr\bin\bash.exe" $connectPath $caZipPath
}

function new-Path($path, $child) {
  return Join-Path -Path $path -ChildPath $child
}

. .\src\components\Tabs\Install\Form.ps1

# SIG # Begin signature block
# MIIkyAYJKoZIhvcNAQcCoIIkuTCCJLUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU/XFiqugGB2aih0hOrm8XzgMV
# 93aggh6kMIIFOTCCBCGgAwIBAgIQDue4N8WIaRr2ZZle0AzJjDANBgkqhkiG9w0B
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
# DjAMBgorBgEEAYI3AgEVMCMGCSqGSIb3DQEJBDEWBBQuRE5QBjXacZTBZrhHDA1x
# 6G/gYTAkBgorBgEEAYI3AgEMMRYwFKASgBAAQwBBACAAVABvAG8AbABzMA0GCSqG
# SIb3DQEBAQUABIIBAEKyeeO1pdOKn0eNNnMwUVs+d3L7Ajw5nGxXWsENi6brEW30
# viIKRh5luc37ZA+wMd9i1/8sZMYM9+dvOR8c/15fL8iEcjOeff+o+MHSQrRsTank
# HoK4pjfVC+66gWwjsfH6S34SX9VJ2diY8GPmDoyLEF8tzjXr4XKiAP0Yohpt5rnu
# ezGmpTZ+tqZqC2iNo0quyyAkuNTwsBJoEpiJOyLBbhlnUSnKjtVGqRxx3x6p+8GC
# 1eE0uFaiOtIIw+VgmgxEtt1sWglejhrekfkkLh1z2QBRAqBSWJMpICYAsJIU+G3b
# bxCBg8kFX97nWeP+NVFqCouCdXr8g7RL2I7k0EWhggNLMIIDRwYJKoZIhvcNAQkG
# MYIDODCCAzQCAQEwgZEwfTELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
# TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBM
# aW1pdGVkMSUwIwYDVQQDExxTZWN0aWdvIFJTQSBUaW1lIFN0YW1waW5nIENBAhA5
# TCXhfKBtJ6hl4jvZHSLUMA0GCWCGSAFlAwQCAgUAoHkwGAYJKoZIhvcNAQkDMQsG
# CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjMwNTI1MTEwNTM2WjA/BgkqhkiG
# 9w0BCQQxMgQwXW1FaMve5tuGCx6Y9SLZ5KGtY8QvAEogoPeWBhkbKiYebGC4mZWO
# R+P0q2aWFapvMA0GCSqGSIb3DQEBAQUABIICAAY4R3/L6ifwnqFhLxISBWz5zmYz
# Z4lXT80X2IRHLTUk1GuSMwtU1LG/LLE0EBvRwfhtydnALpIwoAOQ34oEph/7Y0uF
# IRL2NpWDjQX2iNmh05XKefSb4mo884BgoBtJE7u400CpjQxV41WC76UpniZSxWHa
# t7SYUQJxg4rpKNWCACoFiSIWvpyIEhXTleECJiGB4KzPCMEgju81/g9ueYdFUNBs
# 1wOkmFVbLL6JaoYuNn+/XVYN/3t1mPHUW5h/G4E2ysrnm6JdVC43xi9MJOB3UciJ
# sSAHM2EVK2KwxuS6oa8WG442uT8FF24HYjXoqPIJHfUJiouprrOr1RQQT3K+pxAf
# Xu60aK2fazezZCjYjxoNi5QyveNacRhq2uDN/dFRdsfG06s7o08LqgF2dJP7CFwI
# lkfZH7q6Ha1Pwxd8qg5AFlr+cQ3JyLDnKL0LkfzERp2vs4w5u/+syVnC6wZXnqAh
# VNrYORgRlIu4GEkvIGZY1Ji0+rLfaA4eTZ3b32YNlyDsfBnMMRmgSkayzWzNbRqw
# faJtWfy+sRe+odOrOwQlPa3BDSYedbQMrP4DrEFALhYO+UyhyxV5wcNTGJj2B5uM
# 3dJz/hSnHE5V4xSRQD8/caQSep4huBGHjamNEiM8j6XFvB7m7XCDNbKVPm7Wmjuk
# bgZAihDoiMMn8uEf
# SIG # End signature block
