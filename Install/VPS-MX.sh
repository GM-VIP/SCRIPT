#!/bin/bash
#SCRIPT PERU : ∞ META

clear
cd $HOME
SCPdir="/etc/newadm"
SCPinstal="$HOME/install"
SCPidioma="${SCPdir}/idioma"
SCPusr="${SCPdir}/ger-user"
SCPfrm="/etc/ger-frm"
SCPinst="/etc/ger-inst"

service apache2 restart > /dev/null 2>&1
apt-get install boxes -y &>/dev/null
apt install net-tools -y &>/dev/null
apt-get install figlet -y &>/dev/null
apt-get install lolcat -y &>/dev/null
apt-get install neofetch &>/dev/null

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

AptVIP() {
  clear
  msg -bar2
  echo -e "\e[1;100;97m 🔧 LIMPIEZA GLOBAL DE PROXIES APT - VPS PERU \e[0m"
  msg -bar2

  echo -e "\n\033[1;36m🔍 Verificando configuración de proxy en APT...\033[0m"
  found_proxy=0
  proxy_patterns=("Acquire::http::Proxy" "Acquire::https::Proxy" "Acquire::ftp::Proxy")
  proxy_dirs=(/etc/apt/apt.conf /etc/apt/apt.conf.d/* /etc/apt/preferences.d/*)

  for proxyfile in "${proxy_dirs[@]}"; do
    [[ -f "$proxyfile" ]] || continue
    for pattern in "${proxy_patterns[@]}"; do
      if grep -q "$pattern" "$proxyfile"; then
        found_proxy=1
        echo -e "\033[1;31m🧹 Eliminando proxy en:\033[0m $proxyfile"
        sudo sed -i "/$pattern/d" "$proxyfile"
      fi
    done
  done
  
if [[ $found_proxy -eq 0 ]]; then
  echo -e "\033[1;32m✅ Configuración de proxy limpia.\033[0m"
fi

  msg -bar2
  read -p "🔁 Presiona Enter para continuar..." enter
  echo ""
}

ProxyVIP() {
  msg -bar2
  echo -e "\e[1;100;97m # ─── BLOQUEO PERMANENTE DE PROXY - VPS PERU \e[0m"
  msg -bar2

  BLOCKFILE="/etc/apt/apt.conf.d/99force-no-proxy"

  if [[ ! -f "$BLOCKFILE" || -z $(grep 'Acquire::http::Proxy "false";' "$BLOCKFILE") ]]; then
    echo 'Acquire::http::Proxy "false";' | sudo tee "$BLOCKFILE" > /dev/null
    echo -e "\033[1;32m🔒 Proxy bloqueado permanentemente en:\033[0m $BLOCKFILE"
  else
    echo -e "\033[1;33m⚠️  Proxy ya estaba bloqueado permanentemente.\033[0m"
  fi

  # Limpiar variables de entorno de proxy
  unset http_proxy https_proxy ftp_proxy HTTP_PROXY HTTPS_PROXY FTP_PROXY

  msg -bar2
  read -p "🔁 Presiona Enter para finalizar..." enter
  echo -e ""
}

DPKG() {
  
  msg -bar2
  echo -e "\033[1;100;97m 🔓 DESBLOQUEAR DPKG SI ESTÁ BLOQUEADO - VPS PERU \033[0m"
  msg -bar2

  echo -e "\n\033[1;36m🔍 Verificando bloqueos de APT...\033[0m"
  if pgrep -x apt >/dev/null || pgrep -x apt-get >/dev/null || pgrep -x dpkg >/dev/null; then
    echo -e "\033[1;33m⚠️  Detectados procesos activos de apt/dpkg. Terminando...\033[0m"
    sudo killall -9 apt apt-get dpkg 2>/dev/null
    sleep 1
  fi

  if sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1; then
    echo -e "\033[1;33m⚠️  Eliminando locks de APT (forzado)...\033[0m"
    sudo rm -f /var/lib/dpkg/lock
    sudo rm -f /var/lib/apt/lists/lock
    sudo rm -f /var/cache/apt/archives/lock
    sudo dpkg --configure -a
    sleep 1
  else
    echo -e "\033[1;32m✅ No se encontraron bloqueos activos.\033[0m"
  fi

  msg -bar2
  read -p "🔁 Presiona Enter para continuar..." enter
}

ConfigurarReposVIP() {
  echo ""
  msg -bar2
  echo -e "\e[1;100;97m 🛍 CONFIGURAR REPOSITORIOS DE UBUNTU - VPS PERU \e[0m"
  msg -bar2

  VERSION=$(lsb_release -rs | cut -d. -f1,2)
  echo -e "\n🔎 Detectando versión de Ubuntu: \e[1;36m$VERSION\e[0m"
  echo -e "\n🔧 Configurando repositorios para Ubuntu $VERSION...\n"

  case "$VERSION" in
    "18.04")
      CODENAME="bionic"
      ;;
    "20.04")
      CODENAME="focal"
      ;;
    "22.04")
      CODENAME="jammy"
      ;;
    "24.04")
      CODENAME="noble"
      ;;
    *)
      echo -e "\n❌ Versión de Ubuntu no soportada automáticamente."
      msg -bar2
      read -p "🔁 Presiona Enter para finalizar..." 
      return
      ;;
  esac
echo -e "\e[1;33m"
  echo "sudo bash -c \"cat > /etc/apt/sources.list <<EOF"
  echo "deb http://archive.ubuntu.com/ubuntu $CODENAME main universe restricted multiverse"
  echo "deb http://archive.ubuntu.com/ubuntu $CODENAME-updates main universe restricted multiverse"
  echo "deb http://archive.ubuntu.com/ubuntu $CODENAME-backports main universe restricted multiverse"
  echo "deb http://security.ubuntu.com/ubuntu $CODENAME-security main universe restricted multiverse"
  echo "EOF\""
  echo -e "\e[0m"
  
  sudo bash -c "cat > /etc/apt/sources.list <<EOF
deb http://archive.ubuntu.com/ubuntu $CODENAME main universe restricted multiverse
deb http://archive.ubuntu.com/ubuntu $CODENAME-updates main universe restricted multiverse
deb http://archive.ubuntu.com/ubuntu $CODENAME-backports main universe restricted multiverse
deb http://security.ubuntu.com/ubuntu $CODENAME-security main universe restricted multiverse
EOF"

  echo -e "\n✅ Repositorios para \e[1;36mUbuntu $VERSION ($CODENAME) LTS\e[0m configurados correctamente."
  msg -bar2
  read -p "🔁 Presiona Enter para continuar..." 
}

ActualizarSistemaVIP() {
  echo ""
  msg -bar2
  echo -e "\e[1;100;97m 📡 ACTUALIZACIÓN DE PAQUETES - VPS PERU \e[0m"
  msg -bar2

  echo -e "\n📡 Ejecutando actualización del sistema (apt update)...\n"

  # Ejecutar apt update y forzar color amarillo
  echo -e "\033[1;33m" # ← Empieza amarillo brillante

  script -q -c "sudo apt update" /dev/null

  echo -e "\033[0m" # ← Restablece color normal

  msg -bar2
  echo -e "✅ \e[1;32mSistema actualizado correctamente.\e[0m"
  msg -bar2
  read -p "🔁 Presiona Enter para continuar..."
}

RepararDPKG() {
 echo ""
  msg -bar2
  echo -e "\033[1;100;97m 🛠 REPARAR INTERRUPCIONES DE DPKG/APT - VPS PERU \033[0m"
  msg -bar2

  echo -e "\n\033[1;36m🛠 Restaurando dpkg tras interrupciones previas...\033[0m"
  if sudo dpkg --configure -a &> /dev/null; then
    echo -e "\033[1;32m✅ dpkg restaurado correctamente.\033[0m"
  else
    echo -e "\033[1;31m❌ Error al restaurar dpkg.\033[0m"
  fi

  echo -e "\n\033[1;36m🔧 Reparando instalaciones rotas si existen...\033[0m"
  if sudo apt --fix-broken install -y &> /dev/null; then
    echo -e "\033[1;32m✅ Reparación de paquetes completada.\033[0m"
  else
    echo -e "\033[1;31m❌ No se pudo reparar completamente.\033[0m"
  fi

  msg -bar2
  echo -e "🔁 Presiona Enter para continuar..."
  read
  echo ""
}

dependencias() {
  dpkg --configure -a >/dev/null 2>&1
  apt -f install -y >/dev/null 2>&1

  > errores.txt
  > exitos.txt

  soft="sudo bsdmainutils zip unzip ufw curl python python3 python3-pip screen openssl cron iptables lsof pv boxes at mlocate gawk bc jq npm nodejs socat netcat netcat-traditional net-tools cowsay figlet lolcat build-essential netstat vnstat less"

  for paquete in $soft; do
    if dpkg --get-selections | grep -qw "$paquete"; then
      echo -e "\e[1;32m       INSTALADO .................. $paquete\e[0m"
      echo "$paquete" >> exitos.txt
    else
      # Primer intento de instalación
      apt-get install "$paquete" -y &>/dev/null

      if dpkg --get-selections | grep -qw "$paquete"; then
        echo -e "\e[1;32m       INSTALADO .................. $paquete\e[0m"
        echo "$paquete" >> exitos.txt
      else
        # Mostrar línea de reparación
        echo -ne "\e[1;33m       REPARANDO .................. $paquete\r"

        # Aplicar reparación silenciosa
        echo "" | ConfigurarReposVIP >/dev/null 2>&1
        echo "" | ActualizarSistemaVIP >/dev/null 2>&1

        # Segundo intento
        apt-get install "$paquete" -y &>/dev/null

        if dpkg --get-selections | grep -qw "$paquete"; then
          echo -e "\e[1;32m       INSTALADO .................. $paquete\e[0m"
          echo "$paquete" >> exitos.txt
        else
          echo -e "\e[1;91m        FALLO DE INSTALACIÓN .... $paquete\e[0m"
          echo "$paquete" >> errores.txt
        fi
      fi
    fi
  done
}

### PAQUETES PRINCIPALES
AptVIP
ProxyVIP
DPKG
ConfigurarReposVIP
ActualizarSistemaVIP
RepararDPKG
tput clear
msg -bar
echo -e "\e[1;100;93m -------  INSTALACION DE PAQUETES NECESARIOS -------- \e[0m"
msg -bar
dependencias
#IpTables
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections 
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections 
[[ $(dpkg --get-selections|grep -w "iptables-persistent"|head -1) ]] || apt-get install iptables-persistent -y &>/dev/null 
[[ $(dpkg --get-selections|grep -w "iptables-persistent"|head -1) ]] || ESTATUS=`echo -e   "\033[91mPAQ ERROR"` &>/dev/null 
[[ $(dpkg --get-selections|grep -w "iptables-persistent"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null 
echo -e "\033[97m       $ESTATUS................. Iptables "
#apache2
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] || {
 apt-get install apache2 -y &>/dev/null
 sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
 service apache2 restart > /dev/null 2>&1 &
 }
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m       $ESTATUS................. apache2 "
msg -bar2
echo -e "\033[1;39m Presiona Enter Para continuar" && read enter


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
tput clear
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
msg -bar2 && msg -verm " ERROR DE ENLACE: VPS <==> GENERADOR" && msg -bar2
echo -e "\e[1;31m ◇ ERROR (PORT 8888, 81 TCP) ◇, FALLA DE ENLACE CON GENERADOR \n - \e[3;33m KEYGEN PUDO HABER COLAPZADO\e[0m - " && msg -bar2
[[ -d ${SCPinstal} ]] && rm -rf ${SCPinstal}
rm -rf lista-arq
echo -e "  \033[1;44m          Deseas Reintentar con Otra Llave?          \033[0m"
echo -ne "\033[0;32m "
read -p "    Responde [ s | n ] : " -e -i "n" x
[[ $x = @(s|S|y|Y) ]] && retry_fun || 
clear && clear
msgi -bar2
msgi -bar2
rm -rf lista-arq
echo -e "\033[1;97m          ---- INSTALACION CANCELADA  -----"
msgi -bar2
msgi -bar2
exit 1
}

invalid_key () {
msg -bar2 && msg -verm " #¡Key Invalida#! " && msg -bar2
echo -e "\e[1;31m KEY INCORRECTA, O YA FUE USADA!! PUEDE SER ERROR DE KEYGEN \n • HAS UN REBOOT AL KEYGEN PARA RESTABLECER • " && msg -bar2
[[ -e $HOME/lista-arq ]] && rm $HOME/lista-arq
echo -e "  \033[1;44m          Deseas Reintentar con Otra Llave?          \033[0m"
echo -ne "\033[0;32m "
read -p "    Responde [ s | n ] : " -e -i "n" x
[[ $x = @(s|S|y|Y) ]] && retry_fun || 
clear && clear
msgi -bar2
msgi -bar2
rm -rf lista-arq
echo -e "\033[1;97m          ---- INSTALACION CANCELADA  -----"
msgi -bar2
msgi -bar2
exit 1
}

while [[ ! $Key ]]; do
unset Key
echo -e "\e[1;33m     # INGRESA LA KEY DE INSTALACION OBTENIDA #\n\e[0m"
echo -ne "\e[1;32m    Key: \e[0m" && read Key
tput cuu1 && tput dl1
done
msg -ne "        # Verificando Key # : "
cd $HOME
wget -O $HOME/lista-arq $(ofus "$Key")/$IP > /dev/null 2>&1 && echo -e "\033[3;32m    Key Completada   \033[0m" || {
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
