############################################################################
#Project: Counting files per hour
#Developer: Tiago Cerveira (https://github.com/pehdepano)
#Tools : PowerShell 5.1.22621.963
#E-Mail: tiago.cerveira@gmail.com
###########################################################################

#[Net.ServicePointManager]::SecurityProtocol = 'tls12, tls11, tls'
#$URL="https://raw.githubusercontent.com/pehdepano/VISION/main/update.ps1"
#$PATH="C:\DGT\OCR\update.ps1"
#Invoke-Webrequest -URI $URL -OutFile $Path

# Import csv file from de $arg[0]
$csvFile = ".\config.csv"
$csvData = Import-Csv -Path $csvFile #-Header "Nome_Ponto","Estrutura_Enviadas"

$Client = $args[0]
$Ext = $args[1]
$Date = (Get-Date).Date
$Hour = get-date -format dd/MM/yyyy" "HH:00:00
$HourVal1 = (get-date -format HH) - 1
$HourVal2 = get-date -format HH

#Create csv file
Write-Output ('"Hora",') -NoNewline | Out-File (".\{0}.csv" -f $Client) -Append -Encoding utf8

#fill header with names
foreach ($line in $csvData) {
	$Name = $line.Nome_Ponto
	Write-Output ('"{0}",' -f $Name) -NoNewline | Out-File (".\{0}.csv" -f $Client) -Append -Encoding utf8
}
$DateF = Get-Date
Write-Output ('"Time Stamp"' -f $DateF) | Out-File (".\{0}.csv" -f $Client) -Append -Encoding utf8

#input time
Write-Output ('"$Hour",') -NoNewline | Out-File (".\{0}.csv" -f $Client) -Append -Encoding utf8

#fill data
foreach ($line in $csvData) {
	$Path = $line.Estrutura_Enviadas
		$Counter = (Get-ChildItem $Path -filter $Ext |
		Where-Object { $_.LastWriteTime -gt ($Date).AddHours($HourVal1) -and $_.LastWriteTime -lt ($Date).AddHours($HourVal2) }).Count
		Write-Output ('"{0}",' -f $Counter) -NoNewline | Out-File (".\{0}.csv" -f $Client) -Append -Encoding utf8
}
#Timestamp in last col
$DateF = Get-Date
Write-Output ('"{0}",' -f $DateF) | Out-File (".\{0}.csv" -f $Client) -Append -Encoding utf8
