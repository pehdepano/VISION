############################################################################
#Project: Counting files per hour
#Developer: Tiago Cerveira (https://github.com/pehdepano/PRTG)
#Tools : PowerShell 5.1.22621.963
#E-Mail: tiago.cerveira@gmail.com
###########################################################################

# Set arguments to filter: $Path $Hour and $Ext
$usage = "Please inform a ","Path","","
PS .\script.ps1 C:\Temp\ftp\ *.jpg
PS .\script.ps1 C:\Temp\ftp\"
$Path = $args[0]
$Ext = $args[1]
$Date = ((Get-Date).Date).AddDays(-1) # Set date to yesterday
$Day = 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23

if (!$args) {
	Write-Host "
Without args
	
Please inform a " -ForegroundColor Red -NoNewline; Write-Host "Path" -ForegroundColor Blue -NoNewline; Write-Host " to search with or without file extension:" -ForegroundColor Red -NoNewline;
	Write-Host "
	
	PS .\script.ps1 C:\Temp\ftp\ *.jpg
	PS .\script.ps1 C:\Temp\ftp\" -ForegroundColor Blue;
	exit }

#Filtering only $Ext files in $Path between $Hour and $HourB in actual day

##	(Get-ChildItem $Path -filter $Ext |
##	Where-Object { $_.LastWriteTime -gt ((Get-Date).Date).AddHours($Hour) -and $_.LastWriteTime -lt ((Get-Date).Date).AddHours($HourB) }).Count

#Loop filtering only $Ext files in $Path in each hour of yesterday and output XML

Write-Host ('<?xml version="1.0" encoding="UTF-8"?>
<prtg>')

For ($i=0; $i -le 23; $i++) {
	$o=$i+1
		$Day[$i]=(Get-ChildItem $Path -filter $Ext |
		Where-Object { $_.LastWriteTime -gt ($Date).AddHours($i) -and $_.LastWriteTime -lt ($Date).AddHours($o) }).Count
Write-Host ('	<result>
		<Channel>{0}h - {1}h</Channel>
		<Value>{2}</Value>
		<Mode>Absolute</Mode>
		<Unit>Custom</Unit>
		<CustomUnit>Carros</CustomUnit>
	</result>' -f $i,$o,$Day[$i])
}
#$Day # Print results
Write-Host '</prtg>'
