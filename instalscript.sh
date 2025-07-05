#!/bin/bash
#SYSTEM MODS BY: Razhiel && GHOST
#04/07/2025

cp .bashrc .bashrc.backup

if [ `whoami` != 'root' ] 
then 
clear && clear
echo
echo -e "\e[1;31m AL PARECER TU VPS NO POSEE PERMISOS ROOT PARA INSTALAR \e[0m"
sleep 1
echo
echo -e  "\033[1;47;30m       APLICANDO ACCESO ROOT       \033[0m"
sudo service ssh restart
sed -i "s;PermitRootLogin prohibit-password;PermitRootLogin yes;g" /etc/ssh/sshd_config
sed -i "s;PermitRootLogin without-password;PermitRootLogin yes;g" /etc/ssh/sshd_config
sed -i "s;PasswordAuthentication no;PasswordAuthentication yes;g" /etc/ssh/sshd_config
echo -e "\033[1;36m-----------------------------------------------------------------\033[0m"
echo -e " Escriba su contraseña root actual o cambiela"
echo -e "\033[1;36m-----------------------------------------------------------------\033[0m"
read  -p " Nuevo passwd: " pass
(echo $pass; echo $pass)|passwd >/dev/null
sleep 1s
echo -e "\033[1;36m-----------------------------------------------------------------\033[0m"
echo -e "\e[32m Configuraciones aplicadas con exito!"
echo -e "\e[32m Su contraseña ahora es: \e[33m$pass\e[0m"
sudo service ssh restart > /dev/null
echo -e "\033[1;36m-----------------------------------------------------------------\033[0m"
fi

instinic () {
killall apt apt-get
dpkg --configure -a
apt-get install software-properties-common -y
apt-add-repository universe -y
rm -rf /etc/localtime &>/dev/null
ln -s /usr/share/zoneinfo/America/Lima /etc/localtime &>/dev/null
apt-get install lolcat -y &>/dev/null
apt-get install figlet &>/dev/null
rm $(pwd)/$0 &> /dev/null
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
   link="https://raw.githubusercontent.com/GM-VIP/SCRIPT/main/Repositorios/$1.list"
  case $1 in
  8 | 9 | 10 | 11 | 16.04 | 18.04 | 20.04 | 20.10 | 21.04 | 21.10 | 22.04 | 24.04 | 24.04) wget -O /etc/apt/sources.list ${link} &>/dev/null ;;
  esac
}

### COLORES Y BARRA 
msg () {
BRAN='\033[1;37m' && VERMELHO='\e[31m' && VERDE='\e[32m' && AMARELO='\e[33m'
AZUL='\e[34m' && MAGENTA='\e[35m' && MAG='\033[1;36m' &&NEGRITO='\e[1m' && SEMCOR='\e[0m'
 case $1 in
  -ne)cor="${VERMELHO}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -ama)cor="${AMARELO}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm)cor="${AMARELO}${NEGRITO}[!] ${VERMELHO}" && echo -e "${cor}${2}${SEMCOR}";;
  -azu)cor="${MAG}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verd)cor="${VERDE}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -bra)cor="${VERMELHO}" && echo -ne "${cor}${2}${SEMCOR}";;
  "-bar2"|"-bar")cor="${VERMELHO}————————————————————————————————————————————————————" && echo -e "${SEMCOR}${cor}${SEMCOR}";;
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
echo -ne "         \033[1;33m["
while true; do
   for((i=0; i<40; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 1s
   tput cuu1
   tput dl1
   echo -ne "         \033[1;33m["
done
echo -e "\033[1;33m]\033[1;31m -\033[1;32m 100%\033[1;37m"
sleep 1
}

#Logo ADM_OS
Logo () {
figlet -f block " VIP_PERU SYSTEM" | lolcat
echo -e "                  MODS SCRIPT BY: GHOST"
}

tput clear
os_system
repo "${vercin}"
tput cup 6 0
echo -e "              \e[7;3m   >>>> INICIANDO INSTALADOR<<<<   \e[0m"
echo -e "          \e[1;97m    🔎 IDENTIFICANDO SISTEMA OPERATIVO   \e[0m"
echo -e "          \e[1;32m           | $distro $vercin |"
echo
fun_bar 'instinic'
clear && clear
tput cup 6 0
Logo
sleep 3
tput clear

 tput cup 6 0
 echo -e "\e[1;33m ▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎\e[0m"
 tput cup 7 0
 msg -verd "           [ V I P _ P E R U - O . S \033[1;97m By: ©⚜ GHOST ⚜\033[1;33m ]"
 tput cup 8 0
 echo -e "\e[1;33m ▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎\e[0m"
 echo
 tput cup 10 0
 echo -e  "\033[1;33m      >>>> DESCARGANDO E INSTALANDO PAQUETES NECESARIOS <<<<<          \033[1;34m "
 echo
 
## Script name
SCRIPT_NAME=vpsmxup
## Install directory
WORKING_DIR_ORIGINAL="$(pwd)"
INSTALL_DIR_PARENT="/usr/local/vpsmxup/"
INSTALL_DIR=${INSTALL_DIR_PARENT}${SCRIPT_NAME}/

## /etc/ config directory
mkdir -p "/etc/vpsmxup/"

## Install/update
if [ ! -d "$INSTALL_DIR" ]; then
    paqts () {
    apt-get update -y
    apt-get upgrade -y
    apt-get install net-tools -y
    apt-get install software-properties-common -y
    apt-get install curl -y
    sudo apt-add-repository universe -y
    service ssh restart
    }

    echo
    fun_bar 'paqts'
    echo
    
   mkdir -p "$INSTALL_DIR_PARENT"
   cd "$INSTALL_DIR_PARENT"
   wget https://raw.githubusercontent.com/GM-VIP/SCRIPT/main/Install/zzupdate.default.conf -O /usr/local/vpsmxup/vpsmxup.default.conf  &> /dev/null
   rm -rf /usr/local/vpsmxup/vpsmxup.sh
   wget https://raw.githubusercontent.com/GM-VIP/SCRIPT/main/Install/zzupdate.sh -O /usr/local/vpsmxup/vpsmxup.sh &> /dev/null
   chmod +x /usr/local/vpsmxup/vpsmxup.sh
    rm -rf /usr/bin/vpsmxup
    wget https://raw.githubusercontent.com/GM-VIP/SCRIPT/main/Install/zzupdate.sh -O /usr/bin/vpsmxup &> /dev/null
    chmod +x /usr/bin/vpsmxup
    
else
echo ""
fi
sleep 1

## Restore working directory
cd $WORKING_DIR_ORIGINAL
clear
vpsmxup
sleep 2
#fin
