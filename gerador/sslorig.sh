#!/bin/bash
#REMASTERIZADO por CHUMOGH
#REEDITADO POR RAZHIEL

msg () {
local colors="/etc/new-adm-color"
if [[ ! -e $colors ]]; then
COLOR[0]='\033[1;37m' #BRAN='\033[1;37m'
COLOR[1]='\e[31m' #VERMELHO='\e[31m'
COLOR[2]='\e[32m' #VERDE='\e[32m'
COLOR[3]='\e[33m' #AMARELO='\e[33m'
COLOR[4]='\e[34m' #AZUL='\e[34m'
COLOR[5]='\e[91m' #MAGENTA='\e[35m'
COLOR[6]='\033[1;97m' #MAG='\033[1;36m'
else
local COL=0
for number in $(cat $colors); do
case $number in
1)COLOR[$COL]='\033[1;37m';;
2)COLOR[$COL]='\e[31m';;
3)COLOR[$COL]='\e[32m';;
4)COLOR[$COL]='\e[33m';;
5)COLOR[$COL]='\e[34m';;
6)COLOR[$COL]='\e[35m';;
7)COLOR[$COL]='\033[1;36m';;
esac
let COL++
done
fi
NEGRITO='\e[1m'
SEMCOR='\e[0m'
 case $1 in
  -ne)ccor="${COLOR[1]}${NEGRITO}" && echo -ne "${ccor}${2}${SEMCOR}";;
  -ama)ccor="${COLOR[3]}${NEGRITO}" && echo -e "${ccor}${2}${SEMCOR}";;
  -verm)ccor="${COLOR[3]}${NEGRITO}[!] ${COLOR[1]}" && echo -e "${ccor}${2}${SEMCOR}";;
  -verm2)ccor="${COLOR[1]}${NEGRITO}" && echo -e "${ccor}${2}${SEMCOR}";;
  -azu)ccor="${COLOR[6]}${NEGRITO}" && echo -e "${ccor}${2}${SEMCOR}";;
  -verd)ccor="${COLOR[2]}${NEGRITO}" && echo -e "${ccor}${2}${SEMCOR}";;
  -bra)ccor="${COLOR[0]}${SEMCOR}" && echo -e "${ccor}${2}${SEMCOR}";;
  "-bar2"|"-bar")ccor="${COLOR[1]}⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊" && echo -e "${SEMCOR}${ccor}${SEMCOR}";;
 esac
}


fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
echo -ne "\033[1;33m ["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m##"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 1s
   tput cuu1
   tput dl1
   echo -ne "\033[1;33m ["
done
echo -e "\033[1;33m]\033[1;31m -\033[1;32m 100%\033[1;37m"
}

selection_fun () {
local selection="null"
local range
for((i=0; i<=$1; i++)); do range[$i]="$i "; done
while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do
echo -ne "\033[1;37m Opcion: " >&2
read selection
tput cuu1 >&2 && tput dl1 >&2
done
echo $selection
}

fun_barin () {
#==comando a ejecutar==
comando="$1"
#==interfas==
in=' ['
en=' ] '
full_in="➛"
full_en='100%'
bar=(────────────────────
═───────────────────
▇═──────────────────
▇▇═─────────────────
═▇▇═────────────────
─═▇▇═───────────────
──═▇▇═──────────────
───═▇▇═─────────────
────═▇▇═────────────
─────═▇▇═───────────
──────═▇▇═──────────
───────═▇▇═─────────
────────═▇▇═────────
─────────═▇▇═───────
──────────═▇▇═──────
───────────═▇▇═─────
────────────═▇▇═────
─────────────═▇▇═───
──────────────═▇▇═──
───────────────═▇▇═─
────────────────═▇▇═
─────────────────═▇▇
──────────────────═▇
───────────────────═
──────────────────═▇
─────────────────═▇▇
────────────────═▇▇═
───────────────═▇▇═─
──────────────═▇▇═──
─────────────═▇▇═───
────────────═▇▇═────
───────────═▇▇═─────
──────────═▇▇═──────
─────────═▇▇═───────
────────═▇▇═────────
───────═▇▇═─────────
──────═▇▇═──────────
─────═▇▇═───────────
────═▇▇═────────────
───═▇▇═─────────────
──═▇▇═──────────────
─═▇▇═───────────────
═▇▇═────────────────
▇▇═─────────────────
▇═──────────────────
═───────────────────
────────────────────);
#==color==
in="\033[1;33m$in\033[0m"
en="\033[1;33m$en\033[0m"
full_in="\033[1;31m$full_in"
full_en="\033[1;32m$full_en\033[0m"

 _=$(
$comando > /dev/null 2>&1
) & > /dev/null
pid=$!
while [[ -d /proc/$pid ]]; do
	for i in "${bar[@]}"; do
		echo -ne "\r $in"
		echo -ne "ESPERE $en $in \033[1;31m$i"
		echo -ne " $en"
		sleep 0.2
	done
done
echo -e " $full_in $full_en"
sleep 0.1s
}


############

SCPdir="/etc/newadm" 
declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;31m" [3]="\033[1;33m" [4]="\033[1;32m" [5]="\e[1;36m" )

#LISTA PORTAS
mportas () {
unset portas
portas_var=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
while read port; do
var1=$(echo $port | awk '{print $1}') && var2=$(echo $port | awk '{print $9}' | awk -F ":" '{print $2}')
[[ "$(echo -e $portas|grep "$var1 $var2")" ]] || portas+="$var1 $var2\n"
done <<< "$portas_var"
i=1
echo -e "$portas"
} 

fun_bar () { 
comando="$1"  
_=$( $comando > /dev/null 2>&1 ) & > /dev/null 
pid=$! 
while [[ -d /proc/$pid ]]; do 
echo -ne " \033[1;33m["    
for((i=0; i<20; i++)); do    
echo -ne "\033[1;31m##"    
sleep 0.5    
done 
echo -ne "\033[1;33m]" 
sleep 1s 
#tput cuu1 tput dl1 
done 
echo -e " \033[1;33m[\033[1;31m########################################\033[1;33m] - \033[1;32m100%\033[0m" 
sleep 1s 
}  
ssl_stunel () { 
[[ $(mportas|grep stunnel4|head -1) ]] && { 
echo -e "\033[1;33m Deteniendo Stunnel"
msg -bar 
service stunnel4 stop > /dev/null 2>&1 
rm -rf /etc/stunnel/stunnel.conf 
apt-get purge stunnel4 -y &>/dev/null
echo -e "\e[31m DETENIENDO SERVICIO SSL\e[0m"
apt-get purge stunnel4 &>/dev/null 
apt-get remove stunnel4 &>/dev/null 
msg -bar 
echo -e "\033[1;33m Detenido Con Exito!"
msg -bar 
return 0 
} 
clear 
msg -bar 
pt=$(netstat -nplt |grep 'sshd' | awk -F ":" NR==1{'print $2'} | cut -d " " -f 1)
echo -e "\033[1;33m  Selecione un Puerto De Redirecionamento Interna"
echo -e "\033[1;33m  Ingrese su Puerta Servidor Para o SSL/TLS"
echo -e "$barra"
    while true; do
    echo -ne "\033[1;37m"
    echo "  Ingresa el Puerto Local de tu VPS (Default 22) "
    read -p "  Local-Port: " -e -i $pt redir
	tput cuu1 >&2 && tput dl1 >&2
    [[ $(mportas | grep $redir) ]] && break
    echo -e "\033[1;33m  El puerto seleccionado no existe"
    unset redir
	echo -e "$barra"
    done
echo -e "$barra"
DPORT="$(mportas|grep $redir|awk '{print $2}'|head -1)" 
echo -e "\033[1;33m Ahora Que Puerto sera SSL"
msg -bar     
while true; do 
echo -ne "\033[1;37m"     
read -p " Puerto SSL: " SSLPORT 
echo ""     
[[ $(mportas|grep -w "$SSLPORT") ]] || break     
echo -e "\033[1;33m Esta puerta está¡ en uso"  
unset SSLPORT     
done 
msg -bar 
echo -e "\033[1;33m Instalando SSL"
msg -bar 
fun_bar "apt-get install stunnel4 -y" 
apt-get install stunnel4 -y > /dev/null 2>&1 
echo -e "client = no\n[SSL]\ncert = /etc/stunnel/stunnel.pem\naccept = ${SSLPORT}\nconnect = 127.0.0.1:${DPORT}" > /etc/stunnel/stunnel.conf 
####Coreccion2.0#####  
openssl genrsa -out stunnel.key 2048 > /dev/null 2>&1  
(echo "" ; echo "" ; echo "Speed" ; echo "@GHOST" ; echo "@NewSript" ; echo "@VIP" ; echo "@GHOST_Oficial" )|openssl req -new -key stunnel.key -x509 -days 1000 -out stunnel.crt > /dev/null 2>&1  
cat stunnel.crt stunnel.key > stunnel.pem   
mv stunnel.pem /etc/stunnel/ 
######------- 
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4 
service stunnel4 restart > /dev/null 2>&1 
msg -bar 
echo -e "\033[1;33m INSTALADO CON EXITO"
msg -bar 
rm -rf /etc/ger-frm/stunnel.crt > /dev/null 2>&1 
rm -rf /etc/ger-frm/stunnel.key > /dev/null 2>&1 
rm -rf /root/stunnel.crt > /dev/null 2>&1 
rm -rf /root/stunnel.key > /dev/null 2>&1 
return 0 
} 

ssl_stunel_2 () { 
echo -e "\033[1;32m              AGREGAR MAS PUERTOS SSL"
msg -bar 
echo -e "\033[1;33m Seleccione una puerta de redirecciÃ³n interna."
echo -e "\033[1;33m Un puerto SSH/DROPBEAR/SQUID/OPENVPN/SSL"
msg -bar          
while true; do          
echo -ne "\033[1;37m"          
read -p " Puerto-Local: " 
portx=$(netstat -nplt |grep 'sshd' | awk -F ":" NR==1{'print $2'} | cut -d " " -f 1)
echo ""          
if [[ ! -z $portx ]]; then              
if [[ $(echo $portx|grep [0-9]) ]]; then                 
[[ $(mportas|grep $portx|head -1) ]] && break || echo -e "\033[1;31m Puerto Invalido"

fi          
fi          
done 
msg -bar 
DPORT="$(mportas|grep $portx|awk '{print $2}'|head -1)" 
echo -e "\033[1;33m Ahora Que Puerto sera SSL"
msg -bar     
while true; do 
echo -ne "\033[1;37m"     
read -p " Listen-SSL: " SSLPORT 
[[ $(mportas|grep -w "$SSLPORT") ]] || break     
echo -e "\033[1;33m Esta puerta estÃ¡ en uso"
unset SSLPORT     
done 
msg -bar 
echo -e "\033[1;33m Instalando SSL"
msg -bar 
fun_bar "apt-get install stunnel4 -y" 
echo -e "client = no\n[SSL+]\ncert = /etc/stunnel/stunnel.pem\naccept = ${SSLPORT}\nconnect = 127.0.0.1:${DPORT}" >> /etc/stunnel/stunnel.conf 
######------- 
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4 
service stunnel4 restart > /dev/null 2>&1 
msg -bar 
echo -e "${cor[4]}            INSTALADO CON EXITO" 
msg -bar
rm -rf /etc/ger-frm/stunnel.crt > /dev/null 2>&1 
rm -rf /etc/ger-frm/stunnel.key > /dev/null 2>&1 
rm -rf /root/stunnel.crt > /dev/null 2>&1 
rm -rf /root/stunnel.key > /dev/null 2>&1 
return 0 
} 
sslpython(){ 
msg -bar 
echo -e "\033[1;37mSe Requiere tener el puerto 80 y el 443 libres" 
sleep 1 
install_python(){   
apt-get install python -y &>/dev/null && echo -e "\033[1;97m Activando Python Direc 80\n"
sleep 1    
screen -dmS pydic-80 python ${SCPinst}/python.py 80 "@GHOST" && echo "80 @GHOST" >> /etc/newadm/PySSL.log
msg -bar
 }     

install_ssl(){    
apt-get install stunnel4 -y &>/dev/null && echo -e "\033[1;97m Activando Servicios SSL 443\n"
apt-get install stunnel4 -y > /dev/null 2>&1   
echo -e "client = no\n[SSL]\ncert = /etc/stunnel/stunnel.pem\naccept = 443\nconnect = 127.0.0.1:80" > /etc/stunnel/stunnel.conf   
openssl genrsa -out stunnel.key 2048 > /dev/null 2>&1   
(echo ""; echo ""; echo ""; echo speed; echo internet; echo adm; echo @GHOST)|openssl req -new -key stunnel.key -x509 -days 1095 -out stunnel.crt > /dev/null 2>&1  
cat stunnel.crt stunnel.key > stunnel.pem     
mv stunnel.pem /etc/stunnel/   
######-------   
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4   
service stunnel4 restart > /dev/null 2>&1    
rm -rf /root/stunnel.crt > /dev/null 2>&1   
rm -rf /root/stunnel.key > /dev/null 2>&1   
}  

install_python  
install_ssl  
msg -bar 
echo -e "${cor[4]}               INSTALACION COMPLETA" 
msg -bar 

}  

unistall(){ 
clear 
msg -bar 
msg -ama "DETENIENDO SERVICIOS SSL Y PYTHON" 
msg -bar 
service stunnel4 stop > /dev/null 2>&1 
apt-get purge stunnel4 -y &>/dev/null 
apt-get purge stunnel -y &>/dev/null 
kill -9 $(ps aux |grep -v grep |grep -w "python.py"|grep dmS|awk '{print $2}') &>/dev/null 
rm /etc/newadm/PySSL.log &>/dev/null 
clear 
msg -bar 
msg -verd "LOS SERVICIOS SE HAN DETENIDO" 
msg -bar 
}  
# 
certif(){ 
msg -bar 
msg -tit 
echo -e "\e[1;37m ACONTINUACION DEBES TENER LISTO EL LINK DEL CERTIFICADO.zip\n VERIFICADO EN ZEROSSL, DESCARGALO Y SUBELO\n EN TU GITHUB O DROPBOX" 
echo -ne " Desea Continuar? [S/N]: "; read seg 
[[ $seg = @(n|N) ]] && msg -bar && return 
clear 
####Cerrificado ssl/tls##### 
msg -bar 
echo -e "\e[1;33mðŸ‘‡ LINK DEL CERTIFICADO.zip ðŸ‘‡           \n     \e[0m" 
echo -e "\e[1;36m LINK \e[37m: \e[34m\c " 
#extraer certificado.zip 
read linkd 
wget -O /etc/stunnel/certificado.zip $linkd &>/dev/null 
cd /etc/stunnel/ 
unzip certificado.zip &>/dev/null 
cat private.key certificate.crt ca_bundle.crt > stunnel.pem 
rm -rf certificado.zip 
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4 
service stunnel restart > /dev/null 2>&1 
service stunnel4 restart &>/dev/null 
msg -bar 
echo -e "${cor[4]} CERTIFICADO INSTALADO CON EXITO \e[0m"  
msg -bar 
}

certificadom(){ 
if [ -f /etc/stunnel/stunnel.conf ]; then 
insapa2(){ 
for pid in $(pgrep python);do 
kill $pid 
done
for pid in $(pgrep apache2);do
kill $pid 
done 
service dropbear stop 
apt install apache2 -y
echo "Listen 80  <IfModule ssl_module>
         Listen 443 </IfModule>  
		 <IfModule mod_gnutls.c>         
		 Listen 443 </IfModule> 
		 " > /etc/apache2/ports.conf 
		 service apache2 restart 
} 
clear 
msg -bar 
insapa2 &>/dev/null && echo -e " \e[1;33mCONFIGURANDO WEB PARA VERIFICACION "
msg -bar 
echo -e "\e[1;37m VERIFICAR DOMINIO ENLAZADO EN ZEROSSL \e[0m" 
msg -bar 
read -p " LLAVE: " keyy 
msg -bar 
read -p " DATOS: " dat2w 
mkdir -p /var/www/html/.well-known/pki-validation/ 
datfr1=$(echo "$dat2w"|awk '{print $1}') 
datfr2=$(echo "$dat2w"|awk '{print $2}') 
datfr3=$(echo "$dat2w"|awk '{print $3}') 
echo -ne "${datfr1}\n${datfr2}\n${datfr3}" >/var/www/html/.well-known/pki-validation/$keyy.txt 
msg -bar 
echo -e "\e[1;37m VERIFIQUE EN LA PAGINA ZEROSSL \e[0m" 
msg -bar 
read -p " ENTER PARA CONTINUAR" 
clear
msg -bar 
echo -e "\e[1;33mðŸ‘‡ LINK DEL CERTIFICADO ðŸ‘‡       \n     \e[0m" 
echo -e "\e[1;36m LINK \e[37m: \e[34m\c" 
read link 

incertis(){ 
wget $link -O /etc/stunnel/certificado.zip 
cd /etc/stunnel/ 
unzip certificado.zip  
cat private.key certificate.crt ca_bundle.crt > stunnel.pem 
service stunnel restart &>/dev/null 
service stunnel4 restart &>/dev/null 
} 

incertis &>/dev/null && echo -e " \e[1;33mDESCOMPRIMIENDO CERTIFICADO URL"
msg -bar 
echo -e "${cor[4]} CERTIFICADO INSTALADO \e[0m"  
msg -bar  
for pid in $(pgrep apache2);do 
kill $pid 
done 
echo -e " \e[1;33mCONFIGURANDO WEB EN SU ESTADO DEFAULD "
apt install apache2 -y &>/dev/null 
echo "Listen 81  <IfModule ssl_module>
         Listen 443 </IfModule>  
		 <IfModule mod_gnutls.c>         
		 Listen 443 </IfModule> 
" > /etc/apache2/ports.conf 
service apache2 restart &>/dev/null 
service dropbear start &>/dev/null 
service dropbear restart &>/dev/null 
for port in $(cat /bin/ejecutar/PortPD.log| grep -v "nobody" |cut -d' ' -f1); do 
PIDVRF3="$(ps aux|grep pydic-"$port" |grep -v grep|awk '{print $2}')" 
if [[ -z $PIDVRF3 ]]; then 
screen -dmS pydic-"$port" python /etc/newadm/PDirect.py "$port" 
else 
for pid in $(echo $PIDVRF3); do
echo "" 
done
fi 
done 
else 
msg -bar 
echo -e "${cor[3]} SSL/TLS NO INSTALADO \e[0m" 
msg -bar
 fi
 }   
 
 clear 
if netstat -tnlp |grep 'stunnel4' &>/dev/null; then 
stunel="\e[32m[ ON ]" 
else 
stunel="\e[31m[ OFF ]" 
fi 

[[ -e /root/name ]] && figlet -p -f smslant < /root/name | lolcat || echo -e "\033[0;101m     >>>    VPS-PERU  || SSL ORIGINAL    <<<    \033[0m"
msg -bar 
echo -e "${cor[3]}              INSTALADOR MULTI SSL " 
msg -bar 
echo -e "${cor[1]}            Escoja la opcion deseada." 
msg -bar 
echo -e "\033[0;37m [\033[0;31m1\033[0;37m]\033[0;31m ➳ ${cor[3]}INSTALAR || REMOVER SSL $stunel" 
echo -e "\033[0;37m [\033[0;31m2\033[0;37m]\033[0;31m ➳ ${cor[3]}""$(msg -azu "ADICIONAR + PUERTOS SSL")" 
msg -bar 
echo -e "\033[0;37m [\033[0;31m3\033[0;37m]\033[0;31m ➳ ${cor[3]}""$(msg -azu "SSL+WEBSOCKET DIRECTO")" 
echo -e "\033[0;37m [\033[0;31m4\033[0;37m]\033[0;31m ➳ ${cor[3]}\e[1;31mDETENER SERVICIO SSL+WEBSOCKET" 
msg -bar 
echo -e "\033[0;37m [\033[0;31m5\033[0;37m]\033[0;31m ➳ ${cor[3]}""$(msg -azu "CERTIFICADO SSL/TLS")" 
msg -bar 
echo -e "\033[0;37m [\033[0;31m0\033[0;37m]\033[0;31m ➳ $(msg -bra "\033[1;41m| REGRESAR |\e[0m")"
msg -bar
echo -e "\033[1;37m >>>Selecione una opción [0/5]: " 
msg -bar
selection=$(selection_fun 5)
case ${selection} in
0)
exit
;;
1)
msg -bar 
ssl_stunel ;; 
2)
msg -bar 
ssl_stunel_2 
sleep 3 
exit ;; 
3)
sslpython 
exit ;; 
4)
unistall ;; 
5)
clear 
msg -bar 
msg -ama "?CERTIFICADO SSL/TLS" 
msg -bar 
echo -e "\033[0;35m [\033[0;36m1\033[0;35m]\033[0;31m ➮ ${cor[3]}""$(msg -azu " CERTIFICADO ZIP DIRECTO")" 
echo -e "\033[0;35m [\033[0;36m2\033[0;35m]\033[0;31m ➮ ${cor[3]}""$(msg -azu " CERTIFICADO MANUAL ZEROSSL   ")" 
msg -bar 
echo -e " \033[0;35m [\033[0;36m0\033[0;35m]\033[0;31m ➮ $(msg -bra "\033[1;41m[ REGRESAR ]\e[0m")"
msg -bar
echo -e "\033[1;37m Selecione Una Opcion [0/2]: " 
selection=$(selection_fun 2)
case ${selection} in
	1) certif 
	exit ;; 
	2) certificadom 
	exit ;; 
	esac 
;;
esac 

###############

borrado () {
x=$(( $x +1 ))
sleep 0.5s
echo "LINEA $x"
sleep 0.5s
x=$(( $x +1 ))
echo "LINEA $x"
sleep 0.5s
x=$(( $x +1 ))
echo "LINEA $x"
sleep 0.5s
x=$(( $x +1 ))
echo "LINEA $x"
sleep 0.5s
x=$(( $x +1 ))
echo "LINEA $x"
sleep 0.5s
x=$(( $x +1 ))

echo "LINEA $x"
sleep 0.5s
x=$(( $x +1 ))
echo "LINEA $x"
sleep 0.5s
x=$(( $x +1 ))
echo "LINEA $x"
sleep 0.5s
echo "FUNCIONES TPUT"
x=$(( $x - 1 ))
sleep 0.5s
tput cuu1 && tput dl1
sleep 0.5s
tput cuu1 && tput dl1
sleep 0.5s
tput cuu1 && tput dl1
sleep 0.5s
tput cuu1 && tput dl1
sleep 0.5s
tput cuu1 && tput dl1
sleep 0.5s
tput cuu1 && tput dl1
sleep 0.5s
tput cuu1 && tput dl1
sleep 0.5s
tput cuu1 && tput dl1
sleep 0.5s
tput cuu1 && tput dl1
sleep 0.5s
tput cuu1 && tput dl1
sleep 0.5s
x=$(( $x - 1 ))
sleep 0.5s
echo "finalizando"

#fun_barin
}
echo -e "Escribe \e[1;34mG\e[0m\e[1;31mo\e[0m\e[1;33mo\e[0m\e[1;34mg\e[0m\e[1;32ml\e[0m\e[1;31me\e[0m"

remove_all(){ 
sed -i '/net.core.default_qdisc/d' /etc/sysctl.conf 
sed -i '/net.ipv4.tcp_congestion_control/d' /etc/sysctl.conf 
echo -e "\e[1;31m ACELERADOR BBR DESINSTALADA\e[0m" 
}  

startbbr(){ 
remove_all 
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf 
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf 
sysctl -p 
echo -e "${Info}¡BBR comenzó con éxito!" 
msg -bar 
}  
#Habilitar BBRplus 
startbbrplus(){ 
remove_all 
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf 
echo "net.ipv4.tcp_congestion_control=bbrplus" >> /etc/sysctl.conf 
sysctl -p 
echo -e "${Info}BBRplus comenzó con éxito!！" 
msg -bar 
}  


