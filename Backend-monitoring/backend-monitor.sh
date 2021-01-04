#! /bin/bash


#Var Resource
tanggal=$(date +"%y-%m-%d")
jam=$(date -d "today" | awk '{print $4}')
cpu=$(top -n 1 -b | awk '/^%Cpu/{print $2}')
core=$(grep -c ^processor /proc/cpuinfo)
totalmem=$(top -n 1 -b | awk '/KiB Mem/{print $4}')
memfree=$(top -n 1 -b | awk '/KiB Mem/{print $6}')
memused=$(top -n 1 -b | awk '/KiB Mem/{print $8}')
storgtotal=$(df -h | grep /dev/vda1 | awk '{ if($1 == "/dev/vda1") print $2;}')
storgused=$(df -h | grep /dev/vda1 | awk '{ if($1 == "/dev/vda1") print $3;}')
storgfree=$(df -h | grep /dev/vda1 | awk '{ if($1 == "/dev/vda1") print $4;}')
server='1' #Server Web 1
#Var Activity
sshstat=$(sudo service ssh status | awk '/Active/{print $2 $3}')
ufwstat=$(sudo service ufw status | awk '/Active/{print $2 $3}')
errorstat=$(cat /var/log/apache2/access.log | cut -d ' ' -f 9 | sort | uniq -c | sort -nr | awk '{print "                      "$2 " : " $1}' | sort)
apache2stat=$(sudo service apache2 status | awk '/Active/{print $2 $3}')
pengunjung=$(cat /var/log/apache2/access.log |awk '{print $1}' | sort | uniq | wc -l)
traffic=$(cat /var/log/apache2/access.log | sed 's/utm_/ /g' | awk '{print $12}' | grep source= |  sort | uniq -c | sort -nr | sed 's/&/ /g')
#Var Security
denyfirewall=$(sudo ufw status | grep DENY)
snortstat=$(sudo service snort status | awk '/Active/{print $2 $3}')
detectzombie=$(top -n 1 -b | awk '/Tasks/{print $10}')


i="1"
while [ $i = "1" ]
do
echo "+---------------------Server--------------------------+"
echo "1. Server Resource"
echo "2. Server Activity"
echo "3. Server Security"
echo "4. Server Web Activity"
echo "+-----------------------------------------------------+"
echo "Masukan perintah : "
read ch
case $ch in
1)echo "+----------------------------------------------------+" #server resource
echo "+-----------------Server Resource--------------------+"
echo "Tanggal                   : $tanggal "
echo "Jam                       : $jam "
echo "CPU Usage                 : $cpu "
echo "Total Core                : $core "
echo "Memory Total              : $totalmem "
echo "Memory Terpakai           : $memused "
echo "Memory Tersisa            : $memfree "
echo "Storage Total             : $storgtotal"
echo "Storage Terpakai          : $storgused"
echo "Storage Tersisa           : $storgfree"
echo "+----------------------------------------------------+";;
2)echo "+-----------------Server Activity--------------------+" #server activity
echo "Apache2 Status            : $apache2stat "
echo "Pengunjung Unik           : $pengunjung "
echo "Firewall Status           : $ufwstat"
echo "SSH Status                : $sshstat"
echo "Error Status              :"
echo "$errorstat"
echo "+-----------------------------------------------------+";;
3)echo "+-----------------Server Security--------------------+" #server security
echo "Status Snort              : $snortstat "
echo "Zombie Check              : $detectzombie "
echo "+----------------------------------------------------+"
echo "Blocked Ip address"
echo "  Port                    Status          From"
echo "$denyfirewall                                     "
echo "+----------------------------------------------------+";;
4)echo "+--------------------Web Traffic--------------------+" #Server web trafic
echo "$tottraffic"
echo "+----------------------------------------------------+";;
*)
echo "Tidak ada perintah"
esac
echo "1. Untuk Kembali ke menu"
echo "masukan apa saja untuk keluar" 
read i
if [ $i != "1" ]
then
exit
fi
done

#

#insert
#DB_USER="gmxsrv1"
#DB_PASSWD="*!M4ngRup4Prj2419xx?"
#DB_NAME="serverlogs"
#DB_HOST="128.199.231.145"
#TABLE="logs"
#mysql --user=$DB_USER --password=$DB_PASSWD --host=$DB_HOST $DB_NAME << EOF
#INSERT INTO $TABLE (\`id\`, \`tanggal\`, \`jam\`, \`cpu\`, \`totalmem\`, \`memfree\`, \`memused\`, \`rxtx\`, \`uniq_visitor\`, \`server\`) 
#VALUES (NULL, "$tanggal", "$jam", "$cpu", "$totalmem", "$memfree", "$memused", "$pengunjung", "$server");
#EOF
