#!/bin/bash

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

killall apt apt-get
dpkg --configure -a
apt-get install software-properties-common -y
apt-add-repository universe -y
rm -rf /etc/localtime &>/dev/null
ln -s /usr/share/zoneinfo/America/Lima /etc/localtime &>/dev/null
rm $(pwd)/$0 &> /dev/null

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
clear
 msg -bar2
 msg -ama "        [ VPS - GHOST - SCRIPT \033[1;97m ❗ WELCOME❗\033[1;33m ]"
 echo -e  "\033[1;97m               EJECUTANDO ACTUALIZADOR  \033[1;34m "
 msg -bar2
 
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
	echo -e  "\033[1;97m           Instalando Paquetes Prioritarios"
	echo "           --------------------------------"
	sleep 2
	mkdir -p "$INSTALL_DIR_PARENT"
	cd "$INSTALL_DIR_PARENT"
    wget https://raw.githubusercontent.com/ELITE-MUNDIAL/VIP/main/Install/zzupdate.default.conf -O /usr/local/vpsmxup/vpsmxup.default.conf  &> /dev/null
	rm -rf /usr/local/vpsmxup/vpsmxup.sh
    wget https://raw.githubusercontent.com/ELITE-MUNDIAL/VIP/main/Install/zzupdate.sh -O /usr/local/vpsmxup/vpsmxup.sh &> /dev/null
	chmod +x /usr/local/vpsmxup/vpsmxup.sh
	rm -rf /usr/bin/vpsmxup
    wget https://raw.githubusercontent.com/ELITE-MUNDIAL/VIP/main/Install/zzupdate.sh -O /usr/bin/vpsmxup &> /dev/null
	chmod +x /usr/bin/vpsmxup
	echo -e  "\033[1;97m              Copiando Instalador Interno "
	
	echo "           --------------------------------"	
	msg -bar2
	sleep 2
else
	echo ""
fi
sleep 2

## Restore working directory
cd $WORKING_DIR_ORIGINAL
clear
vpsmxup
#fin
