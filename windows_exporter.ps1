# Список серверов
$servers=@("server01", "server02", "server03")

foreach ($server in $servers) {
    Invoke-Command -ComputerName $server {
        $WINDOWS_EXPORTER_VERSION="0.29.2" #https://github.com/prometheus-community/windows_exporter/releases
        $URL="https://github.com/prometheus-community/windows_exporter/releases/download/v$WINDOWS_EXPORTER_VERSION/windows_exporter-$WINDOWS_EXPORTER_VERSION-amd64.msi"
        Invoke-WebRequest -Uri $URL -OutFile windows_exporter.msi
        Start-Process "msiexec.exe" -ArgumentList "/i windows_exporter.msi /qn" -Wait
        Remove-Item windows_exporter.msi
        Get-Service windows_exporter
    }
}
