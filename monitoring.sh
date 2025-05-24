System=$(hostnamectl | grep "Operating" | awk '{print $3 " " $4 " " $5}')
Kernel=$(hostnamectl | grep "Kernel" | awk '{print $2 " " $3}')
CPU=$(lscpu | grep "^CPU(s):" | awk '{print $2}')
vCPU=$(lscpu | grep "Core(s) per socket:" | awk '{print $4}')
memorytotal=$(free -m | grep Mem: | awk '{print $2}')
memoryused=$(free -m | grep Mem: | awk '{print $3}')
memorypercentage=$(echo "scale=2; $memoryused * 100 / $memorytotal" | bc)
mb=MB
disktotal=$(dh -m | grep )
diskused=

echo "	#Architecture:	$Kernel $System
	#CPU physical:	$CPU
	#vCPU:		$vCPU
	#Memory Usage:	$memoryused/$memorytotal$mb ($memorypercentage%)"