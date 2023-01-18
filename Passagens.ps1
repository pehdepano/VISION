#############################################################################
#	Project: Counting files per hour										#
#	Developer: Tiago Cerveira (https://github.com/pehdepano)				#
#	Tools : PowerShell 5.1.22621.963										#
#	E-Mail: tiago.cerveira@gmail.com										#
#############################################################################

#[Net.ServicePointManager]::SecurityProtocol = 'tls12, tls11, tls'
#$URL="https://raw.githubusercontent.com/pehdepano/VISION/main/update.ps1"
#$PATH="C:\DGT\OCR\update.ps1"
#Invoke-Webrequest -URI $URL -OutFile $Path

# Import csv file from de $arg[0] to $csvData.
$csvFile = ".\config.csv"
$csvData = Import-Csv -Path $csvFile
# Assigns the arguments passed to the script to the variables $Client $Ext.
$Client = $args[0]
$Ext = $args[1]
# Assigns date formats to filters and logs.
$Date = (Get-Date).Date
$DateT = get-date -format yyyy-MM-dd
$HourVal1 = get-date -format HH
$HourVal2 = $HourVal1 - 1
# If a third argument was passed to the script, it assigns that value to the variable $HourVal1.
if ($args[2]){
	$HourVal1 = $args[2]
	$HourVal2 = $HourVal1 - 1
}
# Create empty arrays to header and data.
$nomes = @()
$carros = @()
# Add the first data in arrays.
$nomes += 'Hora'
$carros += ((Get-Date).Date).AddHours($HourVal1)
# Verify if exists a proper csv already.
$csvExist = (Get-ChildItem .\ -filter (".\{0}.{1}.csv" -f $Client,$DateT)).Count
# Create a csv and fill the first line with $nomes array, if $csvExist = 0.
if (!$csvExist) {
	foreach ($line in $csvData) {
		$nomes += $line.Nome_Ponto
	}
	$nomes += "Time_Stamp"
	$nomesT = '"{0}"' -f ($nomes -join '","')
	Write-Output $nomesT | Out-File (".\{0}.{1}.csv" -f $Client,$DateT) -Append -Encoding utf8
}
# Fill $carros array with counter result.
foreach ($line in $csvData) {
	$Path = $line.Estrutura_Enviadas
		$carros += (Get-ChildItem $Path -filter $Ext |
		Where-Object { $_.LastWriteTime -gt ($Date).AddHours($HourVal2) -and $_.LastWriteTime -lt ($Date).AddHours($HourVal1) }).Count
}
$carros += (get-date -format dd/MM/yyyy" "HH:mm:ss)
# Add '","' to each value
$carrosT = '"{0}"' -f ($carros -join '","')
# Append $carrosT array in the next line to csv file.
Write-Output $carrosT | Out-File (".\{0}.{1}.csv" -f $Client,$DateT) -Append -Encoding utf8
# Call db_ocr.exe
.\db_ocr.exe