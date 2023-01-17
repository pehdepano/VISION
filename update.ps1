[Net.ServicePointManager]::SecurityProtocol = 'tls12, tls11, tls'
$URL="https://raw.githubusercontent.com/pehdepano/PRTG/main/passagens.ps1"
$PATH="C:\DGT\OCR\passagens.ps1"
Invoke-Webrequest -URI $URL -OutFile $Path
$URL="https://raw.githubusercontent.com/pehdepano/PRTG/main/config.ps1"
$PATH="C:\DGT\OCR\config.ps1"
Invoke-Webrequest -URI $URL -OutFile $Path
