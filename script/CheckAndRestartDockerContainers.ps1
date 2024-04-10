# get list all containers
$Containers = docker ps --format "{{.Names}}"
$Containers = ($Containers -replace 'failed to get console mode for stdout: The handle is invalid.', '') -split '\r?\n' | Where-Object { $_ }
$count = $Containers.Count
Write-Host "$count containers is running."
if($count -ne 2){
	Write-Host "Only $count containers is running. restart all."
	Write-Output "Restarting $container due to 0% CPU usage..."
	.\start_io_worker.bat
}
else{
	$isRestart = $true
	foreach ($c in $Containers) {
		$stats = docker stats --no-stream --format "{{.CPUPerc}}" $c
		Write-Output "stat:$stats"
		$stats = ($stats -replace 'failed to get console mode for stdout: The handle is invalid.', '').Trim() -split '\r?\n' | Where-Object { $_ }[0]
		$cpuUsage = $stats.Trim().TrimEnd('%').TrimStart() -as [float]
		Write-Output "stat:$stats"
		Write-Output "cpu usage: $cpuUsage"
		if ($cpuUsage -ne 0) {
			Write-Output "Container: $c, CPU Usage: $cpuUsage%"
			$isRestart = $false
		}
		else {
			Write-Output "$c is running with CPU usage at $cpuUsage %"
		}
	}
	if($isRestart){
			.\start_io_worker.bat
			break
	}
}

