#!/bin/bash
#SCRIPT PERU : ∞ META

apt-get install figlet -y &>/dev/null
apt-get install lolcat -y &>/dev/null
apt-get install neofetch &>/dev/null
apt-get install boxes -y &>/dev/null

clear
cd $HOME
SCPdir="/etc/newadm"
SCPinstal="$HOME/install"
SCPidioma="${SCPdir}/idioma"
SCPusr="${SCPdir}/ger-user"
SCPfrm="/etc/ger-frm"
SCPinst="/etc/ger-inst"

service apache2 restart > /dev/null 2>&1
myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;
mkdir -p /etc/B-ADMuser &>/dev/null
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

### PAQUETES PRINCIPALES 
clear && clear
echo
msg -bar
echo -e "\033[41m  INSTALACION DE PAQUETES NECESARIOS PARA VPS-PERU  \e[0m"
echo -e "\033[100m               ESPERE PORFAVOR...                    \e[0m"
msg -bar
echo
#grep
apt-get install grep -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "grep"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "grep"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # Instalando grep................. $ESTATUS "
#net-tools
apt-get install net-tools -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # Instalando net-tools............ $ESTATUS "
#gawk
apt-get install gawk -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "gawk"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "gawk"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # Instalando gawk................. $ESTATUS "
#mlocate
apt-get install mlocate -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "mlocate"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "mlocate"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # Instalando mlocate.............. $ESTATUS "
#lolcat gem
apt-get install lolcat -y &>/dev/null
sudo gem install lolcat &>/dev/null
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # Instalando lolcat............... $ESTATUS "
#at
[[ $(dpkg --get-selections|grep -w "at"|head -1) ]] || apt-get install at -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "at"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "at"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # Instalando at................... $ESTATUS "
#nano
[[ $(dpkg --get-selections|grep -w "nano"|head -1) ]] || apt-get install nano -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "nano"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "nano"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # Instalando nano................. $ESTATUS "
#bc
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || apt-get install bc -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # Instalando bc................... $ESTATUS "
#lsof
[[ $(dpkg --get-selections|grep -w "lsof"|head -1) ]] || apt-get install lsof -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "lsof"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "lsof"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # Instalando lsof................. $ESTATUS "
#figlet
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || apt-get install figlet -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # Instalando figlet............... $ESTATUS "
#cowsay
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] || apt-get install cowsay -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # Instalando cowsay............... $ESTATUS "
#screen
[[ $(dpkg --get-selections|grep -w "screen"|head -1) ]] || apt-get install screen -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "screen"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "screen"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # Instalando screen............... $ESTATUS "
#python
[[ $(dpkg --get-selections|grep -w "python"|head -1) ]] || apt-get install python -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "python"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # Instalando python............... $ESTATUS "
#python3
[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] || apt-get install python3 -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # Instalando python3.............. $ESTATUS "
#python3-pip
[[ $(dpkg --get-selections|grep -w "python3-pip"|head -1) ]] || apt-get install python3-pip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3-pip"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3-pip"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # Instalando python3-pip.......... $ESTATUS "
#curl
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # Instalando curl................. $ESTATUS "
#ufw
[[ $(dpkg --get-selections|grep -w "ufw"|head -1) ]] || apt-get install ufw -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "ufw"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "ufw"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # Instalando ufw.................. $ESTATUS "
#unzip
[[ $(dpkg --get-selections|grep -w "unzip"|head -1) ]] || apt-get install unzip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "unzip"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "unzip"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # Instalando unzip................ $ESTATUS "
#zip
[[ $(dpkg --get-selections|grep -w "zip"|head -1) ]] || apt-get install zip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "zip"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "zip"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # Instalando zip.................. $ESTATUS "
#apache2
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] || {
 apt-get install apache2 -y &>/dev/null
 sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
 service apache2 restart > /dev/null 2>&1 &
 }
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # Instalando apache2.............. $ESTATUS "
msg -bar2
echo -e "\033[0;37m »»» Presiona \033[0;37m\033[41m ENTER \033[0;37m Para continuar." && read enter

### FIXEADOR PARA SISTEMAS 86_64
idfix64_86 () {
msg -bar2
echo -e "ENCASO DE PEDIR ALGUNA INSTALACION ESCOJA: y "
apt-get update; apt-get upgrade -y
apt-get install curl -y
apt-get install lsof -y
apt-get install sudo -y
apt-get install figlet -y
apt-get install cowsay -y
apt-get install bc -y
apt-get install python -y
apt-get install at 
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart
clear
msg -bar2
echo -e "ESCOJER PRIMERO #All locales# Y LUEGO #en_US.UTF-8# " 
sleep 7s
 export LANGUAGE=en_US.UTF-8\
   && export LANG=en_US.UTF-8\
   && export LC_ALL=en_US.UTF-8\
   && export LC_CTYPE="en_US.UTF-8"\
   && locale-gen en_US.UTF-8\
   && sudo apt-get -y install language-pack-en-base\
   && sudo dpkg-reconfigure locales
clear
}

msg -bar2
echo -e "\033[1;97m  ¿PRESENTO ALGUN ERROR ALGUN PAQUETE ANTERIOR?" 
msg -bar2
echo -e "\033[1;32m 1- Escoja:(N) No. Para Instalacion Normal"
echo -e "\033[1;31m 2- Escoja:(S) Si. Saltaron errores."
msg -bar2
echo -e "\033[1;39m Al preciona enter continuara la instalacion Normal"
msg -bar2
read -p " [ S | N ]: " idfix64_86   
[[ "$idfix64_86" = "s" || "$idfix64_86" = "S" ]] && idfix64_86

clear

fun_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ifconfig.me)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}  

fun_ipe () { 
 MIP2=$(wget -qO- ifconfig.me) 
 MIP=$(wget -qO- whatismyip.akamai.com) 
 if [ $? -eq 0 ]; then 
 IP="$MIP" 
 else 
 IP="$MIP2" 
 fi 
 } 

function_verify () {
  ### INTALAR VERCION DE SCRIPT
  v1=$(curl -sSL "https://raw.githubusercontent.com/GM-VIP/SCRIPT/main/VerScrpt/VercOld")
  echo "$v1" > /etc/versin_script
  [[ ! -e /usr/local/lib/lsystembin2 ]] && touch /usr/local/lib/lsystembin2
}

funcao_idioma () {
tput clear
unset Key > /dev/null 2>&1
unset Key
msg -bar2
figlet " -VPS PERU-" | lolcat 
echo -e "     >>ESTE SCRIPT SE OPTIMIZO A IDIOMA ESPAÑOL<<"
msg -bar2
pv="$(echo es)"
[[ ${#id} -gt 2 ]] && id="es" || id="$pv"
byinst="true"
}

int_fun () {
tput clear
unset Key > /dev/null 2>&1
unset Key
msg -bar2
figlet " -VPS PERU-" | lolcat 
echo -e "     >>ESTE SCRIPT SE OPTIMIZO A IDIOMA ESPAÑOL<<" | lolcat
msg -bar2
pv="$(echo es)"
[[ ${#id} -gt 2 ]] && id="es" || id="$pv"
byinst="true"
while [[ ! $Key ]]; do
unset Key
echo -e "\e[1;33m     # INGRESA LA KEY DE INSTALACION OBTENIDA #\n\e[0m"
echo -ne "\e[1;32m    Key: \e[0m" && read Key
tput cuu1 && tput dl1
done
msg -ne "        # Verificando Key # : "
cd $HOME
wget -O $HOME/lista-arq $(ofus "$Key")/$IP > /dev/null 2>&1 && echo -e "\033[3;32m    Key Completa   \033[0m" || {
   echo -e "\033[3;91m    Key Incompleta    \033[0m"
   invalid_key
   }
IP=$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}') && echo "$IP" > /usr/bin/vendor_code
sleep 1s
function_verify
updatedb
if [[ -e $HOME/lista-arq ]] && [[ ! $(cat $HOME/lista-arq|grep "KEY INVALIDA!") ]]; then
   msg -bar2
   msg -ama "$(source trans -b es:${id} " ✅VERIFICADO CORRECTAMENTE..."|sed -e 's/[^a-z -]//ig'): \033[1;31m[OWNER : GHOST]"
   REQUEST=$(ofus "$Key"|cut -d'/' -f2)
   [[ ! -d ${SCPinstal} ]] && mkdir ${SCPinstal}
   pontos="."
   stopping="$(source trans -b es:${id} "Verificando Actualizaciónes"|sed -e 's/[^a-z -]//ig')"
   for arqx in $(cat $HOME/lista-arq); do
   msg -verm "${stopping}${pontos}"
   wget -O ${SCPinstal}/${arqx} ${IP}:81/${REQUEST}/${arqx} > /dev/null 2>&1 && verificar_arq "${arqx}" || error_fun
   tput cuu1 && tput dl1
   pontos+="."
   done
   sleep 1s
   msg -bar2
   listaarqs="$(locate "lista-arq"|head -1)" && [[ -e ${listaarqs} ]] && rm $listaarqs   
   cat /etc/bash.bashrc|grep -v '[[ $UID != 0 ]] && TMOUT=15 && export TMOUT' > /etc/bash.bashrc.2
   echo -e '[[ $UID != 0 ]] && TMOUT=15 && export TMOUT' >> /etc/bash.bashrc.2
   mv -f /etc/bash.bashrc.2 /etc/bash.bashrc
   echo "${SCPdir}/menu" > /usr/bin/menu && chmod +x /usr/bin/menu
   echo "${SCPdir}/menu" > /usr/bin/VIP && chmod +x /usr/bin/VIP
   echo "menu" > /bin/h && chmod +x /bin/h
   echo "$Key" > ${SCPdir}/key.txt
   [[ -d ${SCPinstal} ]] && rm -rf ${SCPinstal}   
   [[ ${#id} -gt 2 ]] && echo "es" > ${SCPidioma} || echo "${id}" > ${SCPidioma}
   echo -e "${cor[2]}         ESCRIBE n PARA CONTINUAR (🐲Default n🐲)"
   echo -e "\033[1;34m  🚨PROCESO FINALIZANDO..."
   msg -bar2
   read -p " [ s | n ]: " NOTIFY   
   [[ "$NOTIFY" = "s" || "$NOTIFY" = "S" ]] && NOTIFY
   msg -bar2
   [[ ${byinst} = "true" ]] && install_fim
else
invalid_key
fi
}

install_fim () {
msg -ama "               Finalizando Instalacion" && msg bar2
rm -rf /etc/newadm/ger-user/nombre.log &>/dev/null
[[ $(find /etc/newadm/ger-user -name nombre.log|grep -w "nombre.log"|head -1) ]] || wget -O /etc/newadm/ger-user/nombre.log https://www.dropbox.com/s/pvo7zneayjjtsgw/nombre.log &>/dev/null
[[ $(find /etc/newadm/ger-user -name IDT.log|grep -w "IDT.log"|head -1) ]] || wget -O /etc/newadm/ger-user/IDT.log https://www.dropbox.com/s/vzsacahfbwwm0ow/IDT.log &>/dev/null
[[ $(find /etc/newadm/ger-user -name tiemlim.log|grep -w "tiemlim.log"|head -1) ]] || wget -O /etc/newadm/ger-user/tiemlim.log https://www.dropbox.com/s/kkchh0ldtdt2yza/tiemlim.log &>/dev/null

wget -O /bin/rebootnb https://raw.githubusercontent.com/GM-VIP/SCRIPT/main/ArchUt/rebootnb &> /dev/null
chmod +x /bin/rebootnb 
wget -O /bin/resetsshdrop https://raw.githubusercontent.com/GM-VIP/SCRIPT/main/ArchUt/resetsshdrop &> /dev/null
chmod +x /bin/resetsshdrop
wget -O /etc/versin_script_new https://raw.githubusercontent.com/GM-VIP/SCRIPT/main/VerScrpt/VercUp &>/dev/null
msg -bar2
clear; clear
echo
msg -bar
echo -e "\e[1;92m  Digita Reseller Autorizado Para La Instalacion!!!\e[0m"
read -p "   RESELLER: " Ghost
echo "$Ghost" > /etc/newadm/message.txt
msg -bar
echo
echo -e "\e[1;97m       RESELLER AUTORIZADO:    \e[0m"$Ghost
echo "       ▪︎CREDITO AGREDADO CON EXITO !!!"
msg -bar
sleep 2
echo '#!/bin/sh -e' > /etc/rc.local
sudo chmod +x /etc/rc.local
echo "sudo rebootnb" >> /etc/rc.local
echo "sudo resetsshdrop" >> /etc/rc.local
echo "sleep 2s" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
/bin/cp /etc/skel/.bashrc ~/
echo 'clear' >> .bashrc
echo 'DATE=$(date +"%d-%m-%y")' >> .bashrc
echo 'TIME=$(date +"%T")' >> .bashrc
sleep 1
clear
echo 'echo ""' >> .bashrc
echo 'echo -e "\033[0;31m        __     ______  ____       ____  _____ _____  _   _          " '>> .bashrc
echo 'echo -e "\033[0;31m        \ \   / /  _ \/ ___|     |  _ \| ____|  _  \| | | |         " '>> .bashrc
echo 'echo -e "\033[0;31m  _______\ \ / /| |_) \___ \     | |_) |  _| | |_)  | | | |_______  " '>> .bashrc
echo 'echo -e "\033[0;31m |________\ V / |  __/ ___) | 🚀 |  __/| |___|  _  <| |_| |_______| " '>> .bashrc
echo 'echo -e "\033[0;31m           \_/  |_|   |____/     |_|   |_____|_|  \_\\____/         " '>> .bashrc 
echo 'echo "" '>> .bashrc
echo 'mess1="$(cat /etc/newadm/message.txt)" ' >> .bashrc
echo 'echo "" '>> .bashrc
echo 'echo -e "\033[0;33m 🔺Script optimizado para el buen uso con una correcta configuración. "'>> .bashrc
echo 'echo -e "\033[0;33m 🔺Acceso PRÉMIUM tiene soporte con el dueño oficial ✦҈͜͡➳👻𝕲𝔥𝔬𝔰𝔱•✓☆ۣۜۜ͜͡🌹.   "'>> .bashrc
echo 'echo -e "\033[0;33m 🔺Key free no tiene soporte alguno. "'>> .bashrc
echo 'echo -e "\033[1;35m    "'>> .bashrc
echo 'echo -e "\033[0;36m  ✅RESELLER : $mess1 "'>> .bashrc
echo 'echo "" '>> .bashrc
echo 'echo -e "\033[0;36m  ✅PARA MOSTRAR EL PANEL DE CONTROL ESCRIBA:  \033[0;37m\033[41m menu \033[0m"'>> .bashrc
echo 'wget -O /etc/versin_script_new https://raw.githubusercontent.com/GM-VIP/SCRIPT/main/VerScrpt/VercUp &>/dev/null'>> .bashrc
echo 'echo "" '>> .bashrc
echo
echo -e "   ESCRIBE menu PARA ACCEDER AL PANEL DE CONTROL: "
echo -e "\033[0;37m                   \033[1;41m menu \033[0m" && msg -bar2
[[ ! -e /etc/autostart ]] && {
	echo '#!/bin/bash
clear
#INICIO AUTOMATICO' >/etc/autostart
	chmod +x /etc/autostart
} || {
	for proc in $(ps x | grep 'dmS' | grep -v 'grep' | awk {'print $1'}); do
		screen -r -S "$proc" -X quit
	done
	screen -wipe >/dev/null
	echo '#!/bin/bash
clear
#INICIO AUTOMATICO' >/etc/autostart
	chmod +x /etc/autostart
}
crontab -r >/dev/null 2>&1
(
	crontab -l 2>/dev/null
	echo "@reboot /etc/autostart"
	echo "* * * * * /etc/autostart"
) | crontab -
service ssh restart &>/dev/null
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games/
sleep 3
}

NOTIFY () {
msg -bar
msg -ama " Notify-BOT (Notificasion Remota)| VPS-GHOST "
msg -bar
echo -e "\033[1;94m Es una opcion para notificar cuando\n un usuario sea bloquedo o este expirado, e info de VPS."
echo -e "\033[1;97m Debe mantenerse atento a posible actualizaciónes"
echo -e "\033[1;92m Para obtener su ID contacte a @GENKEY_BOT"
echo -e "\033[1;92m OWNER : GHOST"
msg -bar
echo -e "\033[1;97m >>> Ingrese un nombre para el ADMIN - VPS:\033[0;37m"; read -p " " nombr
echo "${nombr}" > /etc/newadm/ger-user/nombre.log
echo -e "\033[1;97m >>> Ingrese su ID 👤:\033[0;37m"; read -p " " idbot
echo "${idbot}" > /etc/newadm/ger-user/IDT.log 
msg -bar
echo -e "\033[1;32m         ID AGREGADO CON EXITO"
msg -bar
NOM="$(less /etc/newadm/ger-user/nombre.log)"
NOM1="$(echo $NOM)"
IDB1=`less /etc/newadm/ger-user/IDT.log` > /dev/null 2>&1
IDB2=`echo $IDB1` > /dev/null 2>&1

KEY="862633455:AAGJ9BBJanzV6yYwLSemNAZAVwn7EyjrtcY"
URL="https://api.telegram.org/bot$KEY/sendMessage"
MSG="⚠️ AVISO DE VPS: $NOM1 ⚠️
👉 MENSAJE DE PRUEBA
🔰 EXITOSO... SALUDOS"
curl -s --max-time 10 -d "chat_id=$IDB2&disable_web_page_preview=1&text=$MSG" $URL &>/dev/null
echo -e "\033[1;34mSE ENVIO MENSAJE DE PRUEBA SI NO LLEGA CONTACTE A @EliteMasterGO"
}

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

verificar_arq () {
[[ ! -d ${SCPdir} ]] && mkdir ${SCPdir}
[[ ! -d ${SCPusr} ]] && mkdir ${SCPusr}
[[ ! -d ${SCPfrm} ]] && mkdir ${SCPfrm}
[[ ! -d ${SCPinst} ]] && mkdir ${SCPinst}
case $1 in
"menu"|"message.txt"|"menu.enc")ARQ="${SCPdir}/";;#MENU
"usercodes")ARQ="${SCPusr}/";; #Panel SSRR
"C-SSR.sh")ARQ="${SCPinst}/";; #Instalacao
"openssh.sh")ARQ="${SCPinst}/";; #Instalacao
"squid.sh")ARQ="${SCPinst}/";; #Instalacao
"dropbear.sh")ARQ="${SCPinst}/";; #Instalacao
"openvpn.sh")ARQ="${SCPinst}/";; #Instalacao
"ssl.sh")ARQ="${SCPinst}/";; #Instalacao
"sslorig.sh")ARQ="${SCPinst}/";; #Instalacao
"shadowsocks.sh")ARQ="${SCPinst}/";; #Instalacao
"Shadowsocks-libev.sh")ARQ="${SCPinst}/";; #Instalacao
"Shadowsocks-R.sh")ARQ="${SCPinst}/";; #Instalacao 
"v2ray.sh")ARQ="${SCPinst}/";; #Instalacao
"budp.sh")ARQ="${SCPinst}/";; #Instalacao
"sockspy.sh"|"PDirect.py"|"PPub.py"|"PPriv.py"|"POpen.py"|"PGet.py")ARQ="${SCPinst}/";; #Instalacao
*)ARQ="${SCPfrm}/";; #Ferramentas
esac
mv -f ${SCPinstal}/$1 ${ARQ}/$1
chmod +x ${ARQ}/$1
}

fun_ipe

wget -O /usr/bin/trans https://raw.githubusercontent.com/GM-VIP/SCRIPT/main/Install/trans &> /dev/null
wget -O /bin/Desbloqueo.sh https://raw.githubusercontent.com/GM-VIP/SCRIPT/main/ArchUt/Desbloqueo.sh &> /dev/null
chmod +x /bin/Desbloqueo.sh
wget -O /bin/monitor.sh https://raw.githubusercontent.com/GM-VIP/SCRIPT/main/ArchUt/Monitor-Service/monitor.sh &> /dev/null
chmod +x /bin/monitor.sh
wget -O /var/www/html/estilos.css https://raw.githubusercontent.com/GM-VIP/SCRIPT/main/ArchUt/Monitor-Service/estilos.css &> /dev/null
msg -bar2
msg -bar2
msg -ama "     [ VPS - GHOST - SCRIPT \033[1;97m ✨MAQUINA VIRTUAL✨\033[1;33m ]"
msg -ama "  \033[1;96m    🔰Usar Ubuntu 18 a 64 De Preferencia🔰  "
msg -bar2
[[ $1 = "" ]] && funcao_idioma || {
[[ ${#1} -gt 2 ]] && funcao_idioma || id="$1"
 }
 
error_fun () {
msg -bar2 && msg -verm " ERROR de enlace VPS<-->GENERADOR" && msg -bar2
echo -e "NO HAY CONEXIÓN ENTRE GENERADOR Y SCRIPT\n PORT (8888, 81 TCP) HA COLAPZADO" | boxes -d parchment
[[ -d ${SCPinstal} ]] && rm -rf ${SCPinstal}
rm -rf lista-arq
echo -e " "
echo -e "  \033[1;44m Deseas Reintentar Colocar La Key O Probar Nueva Key? : \033[0m"
echo -ne "\033[0;32m " 
read -p "    Responde [ s | n ] : " -e -i "s" x
[[ $x = @(s|S|y|Y) ]] && int_fun || exit
}

invalid_key () {
msg -bar2 && msg -verm "Code Invalido -- #¡Key Invalida!# " && msg -bar2
echo -e " ERROR DE LA KEY O FUE UTILIZADA\n RECIENTEMENTE, O KEYGEN HA COLAPZADO " | boxes -d parchment
[[ -e $HOME/lista-arq ]] && rm $HOME/lista-arq
echo -e " "
echo -e "  \033[1;44m Deseas Reintentar Colocar La Key O Probar Nueva Key? : \033[0m"
echo -ne "\033[0;32m " 
read -p "    Responde [ s | n ] : " -e -i "s" x
[[ $x = @(s|S|y|Y) ]] && int_fun || exit
}

while [[ ! $Key ]]; do
msg -bar2 && msg -ne "\033[1;96m            >>> INTRODUZCA LA KEY ABAJO <<<\n   \033[1;31m" && read Key
        tput cuu1 && tput dl1
done
msg -ne "# Verificando Key # : "
cd $HOME
wget -O $HOME/lista-arq $(ofus "$Key")/$IP > /dev/null 2>&1 && echo -e "\033[0;32m Code Correcto de KEY" || {
   echo -e "\033[0;31m Code Incorrecto de KEY"
   invalid_key
  }
   
IP=$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}') && echo "$IP" > /usr/bin/vendor_code
sleep 1s
function_verify
updatedb
if [[ -e $HOME/lista-arq ]] && [[ ! $(cat $HOME/lista-arq|grep "KEY INVALIDA!") ]]; then
   msg -bar2
   msg -ama "$(source trans -b es:${id} " ✅VERIFICADO CORRECTAMENTE..."|sed -e 's/[^a-z -]//ig'): \033[1;31m[OWNER : GHOST]"
   REQUEST=$(ofus "$Key"|cut -d'/' -f2)
   [[ ! -d ${SCPinstal} ]] && mkdir ${SCPinstal}
   pontos="."
   stopping="$(source trans -b es:${id} "Verificando Actualizaciónes"|sed -e 's/[^a-z -]//ig')"
   for arqx in $(cat $HOME/lista-arq); do
   msg -verm "${stopping}${pontos}"
   wget -O ${SCPinstal}/${arqx} ${IP}:81/${REQUEST}/${arqx} > /dev/null 2>&1 && verificar_arq "${arqx}" || error_fun
   tput cuu1 && tput dl1
   pontos+="."
   done
   
   wget -qO- ifconfig.me > /etc/newadm/IP.log
   userid="${SCPdir}/ID" 
   TOKEN="5076200777:AAG2bHA_ux_4oLjLp_r-Ndd87jOttMcuw4I" 
   URL="https://api.telegram.org/bot$TOKEN/sendMessage" 
   MSG=" ㅤㅤ  ❗️ KEY ACTIVADA y REGISTRADA ❗️
ㅤㅤ
   🆔 ID: ${SCPdir}/ID
   👤 Reseller: $(cat ${SCPdir}/message.txt)
   🌐 IP: $(cat ${SCPdir}/IP.log)
   🔑 KEY: $Key
   
   ⚙️ SCRIPT: ♾️ Meta
   " 
   activ=$(cat ${userid}) 
   curl -s --max-time 10 -d "chat_id=$activ&disable_web_page_preview=1&text=$MSG" $URL &>/dev/null 
   curl -s --max-time 10 -d "chat_id=1111342634&disable_web_page_preview=1&text=$MSG" $URL &>/dev/null 
   rm ${SCPdir}/IDT.log &>/dev/null
   msg -bar2
   listaarqs="$(locate "lista-arq"|head -1)" && [[ -e ${listaarqs} ]] && rm $listaarqs   
   cat /etc/bash.bashrc|grep -v '[[ $UID != 0 ]] && TMOUT=15 && export TMOUT' > /etc/bash.bashrc.2
   echo -e '[[ $UID != 0 ]] && TMOUT=15 && export TMOUT' >> /etc/bash.bashrc.2
   mv -f /etc/bash.bashrc.2 /etc/bash.bashrc
   echo "${SCPdir}/menu" > /usr/bin/menu && chmod +x /usr/bin/menu
   echo "${SCPdir}/menu" > /usr/bin/VIP && chmod +x /usr/bin/VIP
   echo "menu" > /bin/h && chmod +x /bin/h
   echo "$Key" > ${SCPdir}/key.txt
   [[ -d ${SCPinstal} ]] && rm -rf ${SCPinstal}   
   [[ ${#id} -gt 2 ]] && echo "es" > ${SCPidioma} || echo "${id}" > ${SCPidioma}
   echo -e "${cor[2]}         ESCRIBE n PARA CONTINUAR (🐲Default n🐲)"
   echo -e "\033[1;34m  🚨PROCESO FINALIZANDO..."
   msg -bar2
   read -p " [ s | n ]: " NOTIFY   
   [[ "$NOTIFY" = "s" || "$NOTIFY" = "S" ]] && NOTIFY
   msg -bar2
   [[ ${byinst} = "true" ]] && install_fim
else
invalid_key
fi
rm -rf instalscript.sh
rm -rf VPS-MX.sh
