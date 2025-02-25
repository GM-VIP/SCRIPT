## Actualizado 10/02/2025
#!/bin/bash

# Función para limpiar archivos temporales
cleanup() {
    rm -rf $HOME/lista-arq
    rm -rf $HOME/gerar.sh
    rm -rf $HOME/http-server.py
    history -c
    echo "Limpieza completada."
}

trap cleanup EXIT

cp .bashrc .bashrc.backup
killall apt apt-get
dpkg --configure -a
apt-get install software-properties-common -y
apt-add-repository universe -y
rm -rf /etc/localtime &>/dev/null
ln -s /usr/share/zoneinfo/America/Lima /etc/localtime &>/dev/null
rm $(pwd)/$0 &> /dev/null

apt-get install figlet
apt-get install lolcat
apt-get install neofetch &>/dev/null
apt-get install boxes -y &>/dev/null

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
#Parametros Aplicados
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

tput clear
os_system
repo "${vercin}"
 msg -bar2
 msg -ama "         [ VPS - GHOST - SCRIPT \033[1;97m ❗ WELCOME ❗\033[1;33m ]"
 echo -e  "        \033[1;97m     EJECUTANDO ACTUALIZADOR  \033[1;34m "
 msg -bar2
 echo -e "         \e[1;97m   🔎 IDENTIFICANDO SISTEMA OPERATIVO   \e[0m"
echo -e "          \e[1;32m         | $distro $vercin |"
echo
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
    wget https://raw.githubusercontent.com/GM-VIP/SCRIPT/main/Install/zzupdate.default.conf -O /usr/local/vpsmxup/vpsmxup.default.conf  &> /dev/null
	rm -rf /usr/local/vpsmxup/vpsmxup.sh
    wget https://raw.githubusercontent.com/GM-VIP/SCRIPT/main/Install/zzupdate.sh -O /usr/local/vpsmxup/vpsmxup.sh &> /dev/null
	chmod +x /usr/local/vpsmxup/vpsmxup.sh
	rm -rf /usr/bin/vpsmxup
    wget https://raw.githubusercontent.com/GM-VIP/SCRIPT/main/Install/zzupdate.sh -O /usr/bin/vpsmxup &> /dev/null
	chmod +x /usr/bin/vpsmxup
	echo -e  "\033[1;97m              Copiando Instalador Interno "
	
	echo "           --------------------------------"	
	msg -bar2
	sleep 2
else
	echo ""
fi
sleep 5

## Restore working directory
cd $WORKING_DIR_ORIGINAL
clear
vpsmxup
#fin
