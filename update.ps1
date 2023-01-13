[Net.ServicePointManager]::SecurityProtocol = 'tls12, tls11, tls'
$URL="https://raw.githubusercontent.com/pehdepano/PRTG/main/passagens.ps1"
$PATH="C:\Program Files (x86)\PRTG Network Monitor\Custom Sensors\EXEXML\passagens.ps1"
Invoke-Webrequest -URI $URL -OutFile $Path
