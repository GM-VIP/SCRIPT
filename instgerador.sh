## Actualizado 10/02/2025

#!/bin/bash
IVAR="/etc/http-instas"
SCPT_DIR="/etc/SCRIPT"
SCPresq="aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL0dNLVZJUC9TQ1JJUFQvbWFpbi9nZXJhZG9y"
SUB_DOM='base64 -d'
rm $(pwd)/$0

# Función para limpiar archivos temporales
cleanup() {
    rm -rf $HOME/lista-arq
    rm -rf $HOME/gerar.sh
    rm -rf $HOME/http-server.py
    history -c
    echo "Limpieza completada."
}

trap cleanup EXIT

if [ `whoami` != 'root' ] 
then 
clear && clear
tput cup 6 0
echo -e "\e[1;31m PARA PODER USAR EL INSTALADOR ES NECESARIO SER ROOT\n AUN NO SABES COMO INICAR COMO ROOT?\n DIGITA ESTE COMANDO EN TU TERMINAL \e[1;32m( sudo -i )\e[0m" 
rm * 
sleep 1
checkroot
fi

###ROOT_ACCESS
checkroot (){
clear && clear
tput cup 6 0
echo -e "\e[1;33m     DESEAS APLICAR ACCESO ROOT FORMAL A TU VPS???   \e[0m"
read -p "    Responde [ s | n ] : " -e -i "n" x
[[ $x = @(s|S|y|Y) ]] && vpsroot || exit
vpsroot () {
clear && clear
tput cup 6 0
echo -e  "\033[1;32m             >>>> APLICANDO ACCESO ROOT <<<<<                  \033[1;34m "
msg -bar
sudo service ssh restart > /dev/null 2>&1
sed -i "s;PermitRootLogin prohibit-password;PermitRootLogin yes;g" /etc/ssh/sshd_config
sed -i "s;PermitRootLogin without-password;PermitRootLogin yes;g" /etc/ssh/sshd_config
sed -i "s;PasswordAuthentication no;PasswordAuthentication yes;g" /etc/ssh/sshd_config
msg -bar
echo -e "\e[4;49;37m Escriba su contraseña root actual o coloque una nueva. \e[0m"
msg -bar
read  -p " Nuevo passwd: " pass
(echo $pass; echo $pass)|passwd 2>/dev/null
sleep 1s
msg -bar
echo -e "\e[1;32m CONFIGURACIONES APLICADAS CON EXITO!!!! "
echo -e "\e[1;32m Su contraseña ahora es: \e[1;31m$pass\e[0m"
sudo service ssh restart > /dev/null 2>&1
msg -bar
}
}

os_system() {
  system=$(cat -n /etc/issue | grep 1 | cut -d ' ' -f6,7,8 | sed 's/1//' | sed 's/      //')
  distro=$(echo "$system" | awk '{print $1}')

  case $distro in
  Debian) vercin=$(echo $system | awk '{print $3}' | cut -d '.' -f1) ;;
  Ubuntu) vercin=$(echo $system | awk '{print $2}' | cut -d '.' -f1,2) ;;
  esac
}

repo() {
 link="https://raw.githubusercontent.com/GM-VIP/SCRIPT/main/Install/Source-List/$1.list"
  case $1 in
  8 | 9 | 10 | 11 | 16.04 | 18.04 | 20.04 | 20.10 | 21.04 | 21.10 | 22.04 | 24.04) wget -O /etc/apt/sources.list ${link} &>/dev/null ;;
  esac
}

entrada (){
echo "====================================================="
echo -e "                     \e[93mB I E N V E N I D O !!!\e[0m"
echo "====================================================="
tput bold
echo "
INSTALARAS EL GENERADOR OFICIAL DE LLAVES PARA LOS SCRIPT
VIP-GHOST. HAS BUEN USO DE LAS LLAVES Y DEL GENERADOR....."
echo "====================================================="
echo
sleep 1.5
echo -e "     \e[1;97m     IDENTIFICANDO SISTEMA OPERATIVO   \e[0m"
echo -e "          \e[1;32m         | $distro $vercin |"
}

check_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
echo "$IP" > /usr/bin/vendor_code
}

function_verify () {
 permited=$(curl -sSL "https://raw.githubusercontent.com/GM-VIP/SCRIPT/main/Control/Control-IP")
  [[ $(echo $permited|grep "${IP}") = "" ]] && {
  clear
  echo -e "\n\n\n\e[31m====================================================="
  echo -e "\e[31m         ¡LA IP $(wget -qO- ipv4.icanhazip.com) NO ESTA AUTORIZADO!\n     SI DESEAS USAR EL GENERADOR CONTACTE A @GENKEY_BOT\n                       VIA TELEGRAM."
  echo -e "\e[31m=====================================================\n\n\n\e[0m"
  sleep 5
  [[ -d /etc/ADM-db ]] && rm -rf /etc/ADM-db
[[ ! -e "/bin/ShellBot.sh" ]] && rm /bin/ShellBot.sh
  exit 1
  } || {
 ### INTALAR VERCION DE SCRIPT
  clear
  echo -e "\n\n\n\e[32m====================================================="
  echo -e "\e[32m        ¡LA IP $(wget -qO- ipv4.icanhazip.com) ESTA AUTORIZADA!\n   AUTORIZADO CORRECTAMENTE PARA EL USO DEL GENERADOR.\n                   ESPERE PORFAVOR..."
  echo -e "\e[32m=====================================================\n\n\n\e[0m"
  sleep 5
  CIDdir=/etc/ADM-db && [[ ! -d ${CIDdir} ]] && mkdir ${CIDdir}
  v1=$(curl -sSL "https://raw.githubusercontent.com/GM-VIP/BOT/main/Vercion")
  echo "$v1" > /etc/ADM-db/vercion
  echo "@GENKEY_BOT" > ${CIDdir}/resell
  
  }
}

echo -e " ✓Verificando: "
check_ip
function_verify

ofus () {
unset server
server=$(echo ${txt_ofuscatw}|cut -d':' -f1)
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")txt[$i]="*";;
"*")txt[$i]=".";;
"1")txt[$i]="@";;
"@")txt[$i]="1";;
"2")txt[$i]="?";;
"?")txt[$i]="2";;
"4")txt[$i]="%";;
"%")txt[$i]="4";;
"-")txt[$i]="K";;
"K")txt[$i]="-";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}

veryfy_fun () {
[[ ! -d ${IVAR} ]] && touch ${IVAR}
[[ ! -d ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
unset ARQ
case $1 in
"gerar.sh")ARQ="/usr/bin/";;
"http-server.py")ARQ="/bin/";;
*)ARQ="${SCPT_DIR}/";;
esac
mv -f $HOME/$1 ${ARQ}/$1
chmod +x ${ARQ}/$1
}

tput clear
os_system
repo "${vercin}"
entrada
sleep 3
tput clear
meu_ip

echo -e "\033[1;36m-----------------------------------------------------------------\033[0m"
meu_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
echo "$IP" > /usr/bin/vendor_code
}
meu_ip
echo -e "\033[1;33m Descargando archivos para GENERADOR..."
echo -e "\033[1;36m-----------------------------------------------------------------\033[0m"

cd $HOME
REQUEST=$(echo $SCPresq|$SUB_DOM)
wget -O "$HOME/lista-arq" ${REQUEST}/GERADOR > /dev/null 2>&1
sleep 1s
[[ -e $HOME/lista-arq ]] && {
for arqx in `cat $HOME/lista-arq`; do
echo -ne "\033[1;33m ▪︎Bajando Lista.... \033[1;31m[$arqx] "
wget -O $HOME/$arqx ${REQUEST}/${arqx} > /dev/null 2>&1 && {
echo -e "\033[1;31m ▪︎\033[1;32mRecibido Con Éxito!!!"
[[ -e $HOME/$arqx ]] && veryfy_fun $arqx
} || echo -e "\033[1;31m ▪︎\033[1;31mFallo (No Se Recibió)"
done
[[ ! -e /usr/bin/trans ]] && wget -O /usr/bin/trans https://raw.githubusercontent.com/GM-VIP/SCRIPT/main/Install/trans &> /dev/null
[[ -e /bin/http-server.py ]] && mv -f /bin/http-server.py /bin/http-server.sh && chmod +x /bin/http-server.sh
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || apt-get install bc -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "screen"|head -1) ]] || apt-get install screen -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "nano"|head -1) ]] || apt-get install nano -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || apt-get install netcat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] || apt-get install apache2 -y &>/dev/null
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart > /dev/null 2>&1 &
IVAR2="/etc/key-gerador"
echo "$Key" > $IVAR2
cp /bin/http-server.sh /etc/SCRIPT
mv /etc/SCRIPT/http-server.sh /etc/SCRIPT/http-server.py
cp /usr/bin/gerar.sh /etc/SCRIPT
cd /etc/SCRIPT
rm -rf FERRAMENTA KEY KEY! INVALIDA!
rm $HOME/lista-arq
sed -i -e 's/\r$//' /usr/bin/gerar.sh
echo
echo -e "\033[1;36m-----------------------------------------------------------------\033[0m"
echo "/usr/bin/gerar.sh" > /usr/bin/gerar && chmod +x /usr/bin/gerar
echo -e "\033[1;33m Excelente!!!, Use el Comando \033[1;31mgerar.sh o gerar \033[1;33mPara Administrar Sus Keys y/o Actualizar la Base del Servidor"
echo -e "\033[1;36m-----------------------------------------------------------------\033[0m"
} || {
echo -e "\033[1;36m-----------------------------------------------------------------\033[0m"
echo -e "\033[1;33m XXX Key Invalida! XXX"
echo -e "\033[1;36m-----------------------------------------------------------------\033[0m"
}
echo -ne "\033[0m"
echo "qra-atsilK?29@%6087%?66d5K8888:%05+08+@@?+91" > /etc/key-gerador
apt-get install netcat -y &>/dev/null
