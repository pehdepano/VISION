#################################################################################
#	Project: Create config.novo.csv file v0.2									#
#	Developer: Tiago Cerveira (https://github.com/pehdepano)					#
#	Tools : PowerShell 5.1.22621.963											#
#	E-Mail: tiago.cerveira@gmail.com											#
#################################################################################

# Import csv file from de $arg[0]
$csvFile = $args[0]
$csvData = Import-Csv -Path $csvFile #-Header "Nome_Ponto","Modalidade","IP_Raspberry","Raspberry_User","Raspberry_Pass","SSH_Port","IP_Camera_01","IP_Camera_02","IP_Camera_03","IP_Camera_04","FTP_Enable","NTP_Server","Folder_Pattern","FTP_User","FTP_Pass","FTP_Port","Protocol","Server_IP","Server_Port","Server_User","Server_Pass","Maintenance","Nome_Equipamento","Sentido_01","Sentido_02","Sentido_03","Sentido_04","Len_01","Len_02","Len_03","Len_04","Latitude","Longitude","Ambiente","Separador","Segmentos","Local","Estrutura_Pasta","Estrutura_Imagem","Estrutura_Antigas","Estrutura_Rejeitadas","Estrutura_Enviadas","Estrutura_Zeradas","Estrutura_Duplicadas","Estrutura_Homologacao","Estrutura_MalFormadas","ID_01","ID_02","ID_03","ID_04","CNPJ_Operador","Cod_UF","Tempo_Homologacao","Placa_Invalida","URL_Painel","Formato_Data","Replace_HTTP","IP_HTTP","Status_Antigas","Status_Rejeitadas","Status_Enviadas","Status_Zeradas","Status_Duplicadas","Status_Homologacao","Status_MalFormadas"

#Create header in a new file "config.novo.csv"
Write-Output ('"Nome_Ponto","Estrutura_Enviadas"') | Out-File (".\config.novo.csv") -Encoding utf8

#select data and replace chars to match path
foreach ($line in $csvData) {
	$name = $line.Nome_Ponto
	$name2 = $line.Nome_Ponto.replace("Ponto_","")
	$separador = $line.Separador
	$IP1 = $line.IP_Camera_01.replace('.',$separador)
	$IP2 = $line.IP_Camera_02.replace('.',$separador)
	$IP3 = $line.IP_Camera_03.replace('.',$separador)
	$IP4 = $line.IP_Camera_04.replace('.',$separador)
	$estEnviadas = $line.Estrutura_Enviadas.replace('%l',$name)
	$enviadas1 = $estEnviadas.replace('%i',$IP1)
	$enviadas2 = $estEnviadas.replace('%i',$IP2)
	$enviadas3 = $estEnviadas.replace('%i',$IP3)
	$enviadas4 = $estEnviadas.replace('%i',$IP4)
	$enviadas1 = $estEnviadas.replace('%1i',$line.IP_Camera_01)
	$enviadas2 = $estEnviadas.replace('%1i',$line.IP_Camera_02)
	$enviadas3 = $estEnviadas.replace('%1i',$line.IP_Camera_03)
	$enviadas4 = $estEnviadas.replace('%1i',$line.IP_Camera_04)
	
#fill "config.novo.csv" with selected data
	Write-Output ('"{0}.1","{1}"' -f $name2,$enviadas1) | Out-File (".\config.novo.csv") -Append -Encoding utf8
	if ($IP2) {
	Write-Output ('"{0}.2","{1}"' -f $name2,$enviadas2) | Out-File (".\config.novo.csv") -Append -Encoding utf8}
	if ($IP3) {
	Write-Output ('"{0}.3","{1}"' -f $name2,$enviadas3) | Out-File (".\config.novo.csv") -Append -Encoding utf8}
	if ($IP4) {
	Write-Output ('"{0}.4","{1}"' -f $name2,$enviadas4) | Out-File (".\config.novo.csv") -Append -Encoding utf8}
}
