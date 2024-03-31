# get list all containers
$containers = docker ps --format "{{.Names}}"
$count = $containers.Count
if($count -lt 2){
	Write-Host "Only $count containers is running. restart all."
	Write-Output "Restarting $container due to 0% CPU usage..."
	.\start_io_worker.bat
}
else{
	foreach ($container in $containers) {
		$stats = docker stats --no-stream --format "{{.CPUPerc}}" $container
		$cpuUsage = $stats -replace "%", "" -as [float]
		if ($cpuUsage -eq 0) {
			Write-Output "Restarting $container due to 0% CPU usage..."
			.\start_io_worker.bat
			break
		}
		else {
			Write-Output "$container is running with CPU usage at $cpuUsage%"
		}
	}
}

