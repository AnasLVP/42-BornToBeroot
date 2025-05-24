System=$(hostnamectl | grep "Operating" | awk '{print $3 " " $4 " " $5}')
Kernel=$(hostnamectl | grep "Kernel" | awk '{print $2 " " $3}')

CPU=$(lscpu | grep "^CPU(s):" | awk '{print $2}')
vCPU=$(lscpu | grep "Core(s) per socket:" | awk '{print $4}')
CpuUsage=$(top -b -n1 | grep "Cpu(s)" | awk '{print 100 - $8 "%"}')

memorytotal=$(free -m | grep Mem: | awk '{print $2}')
memoryused=$(free -m | grep Mem: | awk '{print $3}')
memorypercentage=$(($memoryused * 10000 / $memorytotal))
memorypercentage=$(echo "${memorypercentage:0:-2}.${memorypercentage: -2}")

disktotal=$(df -h --total | grep total | awk '{ print $2 }')
diskused=$(df -m --total | grep total |awk '{print $3}')
diskmb=$(df -m --total | grep total |awk '{print $2}')
diskpercentage=$(($diskused * 100 / $diskmb))

lastboot=$(who -b | awk '{print $3 " " $4}')

LVM=$(lsblk | grep -q lvm && echo yes || echo no)

tcp_connections="$(ss -tan  | grep ESTAB | wc -l) ESTABLISHED"

user_online=$(users | wc -w)

ip=$(hostname -I)
MACAddress=$(ip -h addr | grep link/ether | awk '{ print $ 2}')

sudo_count=$(grep -c "COMMAND=" /var/log/sudo/sudo.log)

echo "	#Architecture:		$Kernel $System
	#CPU physical:		$CPU
	#vCPU:			$vCPU
	#Memory Usage:		$memoryused/$memorytotal"MB" ($memorypercentage%)
	#Disk Usage:		$diskused/$disktotal ($diskpercentage%)
	#CPU Load:		$CpuUsage
	#Last Boot:		$lastboot
	#LVM Use:		$LVM
	#Connections tcp:	$tcp_connections
	#User Log:		$user_online
	#Network:		IP $ip ($MACAddress)
	#Sudo:			$sudo_count cmd"