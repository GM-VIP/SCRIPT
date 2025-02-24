## Actualizado 10/02/2025
# MODD BY: DESARROLLADOR
#!/bin/bash

clear && clear
[[ -e /etc/newadm-instalacao ]] && BASICINST="$(cat /etc/newadm-instalacao)" || 
BASICINST="ADMbot.sh apacheon.sh openssh.sh blockBT.sh budp.sh Crear-Demo.sh C-SSR.sh dns-netflix.sh dropbear.sh fai2ban.sh gestor.sh menu message.txt openvpn.sh paysnd.sh PDirect.py PGet.py POpen.py ports.sh PPriv.py PPub.py shadowsocks.sh Shadowsocks-libev.sh Shadowsocks-R.sh sockspy.sh speed.sh speedtest.py squid.sh squidpass.sh ssl.sh sslorig.sh tcp.sh ultrahost Unlock-Pass-VULTR.sh usercodes utils.sh v2ray.sh"
IVAR="/etc/http-instas"

# CONFIGURACIÓN GENERAL
VERSION="2.0"
AUTOR="GOSHT_DEV"
GITHUB="ADM-PERU/VIP"

# CONFIGURACIÓN DE COLORES
CO_TITULO="\033[1;36m"
CO_MENU="\033[1;37m"
CO_SELECCION="\033[1;32m"
CO_ADVERTENCIA="\033[1;31m"
CO_INFO="\033[1;33m"
CO_RESET="\033[0m"

mine_port4 () {
PT=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
for porta in `echo -e "$PT" | cut -d: -f2 | cut -d' ' -f1 | uniq`; do
    svcs=$(echo -e "$PT" | grep -w "$porta" | awk '{print $1}' | uniq)
    echo -e "\033[1;31m$svcs: \033[1;37m$porta"
done
}

# FUNCIONES DE INTERFAZ
draw_header() {
    clear
    echo -e "${CO_TITULO}"
    echo -e "╔══════════════════════════════════════════════════════════╗"
    echo -e "║             🐲 GENERADOR DE KEYS - V${VERSION} 🐲             ║"
    echo -e "║                Desarrollado por: ${AUTOR}               ║"
    echo -e "╚══════════════════════════════════════════════════════════╝${CO_RESET}"
    echo -e ""
}

draw_line() {
    echo -e "${CO_TITULO}══════════════════════════════════════════════════════════${CO_RESET}"
}

SCPT_DIR="/etc/SCRIPT"
[[ ! -e ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
INSTA_ARQUIVOS="ADMVPS.zip"
DIR="/etc/http-shell"
LIST="MDAKTSOHG"

meu_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}

meu_ip

mudar_instacao () {
while [[ ${var[$value]} != 0 ]]; do
[[ -e /etc/newadm-instalacao ]] && BASICINST="$(cat /etc/newadm-instalacao)" || BASICINST="menu PGet.py ports.sh ADMbot.sh message.txt usercodes sockspy.sh POpen.py PPriv.py PPub.py PDirect.py speedtest.py speed.sh utils.sh dropbear.sh apacheon.sh openvpn.sh shadowsocks.sh ssl.sh squid.sh"
clear
draw_line
#echo -e $BARRA
echo -e "MENÚ SELECCIÓN DE INSTALACIÓN"
draw_line
#echo -e $BARRA
echo "[0] - FINALIZAR PROCEDIMIENTO"
i=1
for arqx in `ls ${SCPT_DIR}`; do
[[ $arqx = @(gerar.sh|http-server.py) ]] && continue
[[ $(echo $BASICINST|grep -w "$arqx") ]] && echo "[$i] - [X] - $arqx" || echo "[$i] - [ ] - $arqx"
var[$i]="$arqx"
let i++
done
echo -ne "Seleccione el archivo [Agregar / Eliminar]: "
read value
[[ -z ${var[$value]} ]] && return
if [[ $(echo $BASICINST|grep -w "${var[$value]}") ]]; then
rm /etc/newadm-instalacao
local BASIC=""
  for INSTS in $(echo $BASICINST); do
  [[ $INSTS = "${var[$value]}" ]] && continue
  BASIC+="$INSTS "
  done
echo $BASIC > /etc/newadm-instalacao
else
echo "$BASICINST ${var[$value]}" > /etc/newadm-instalacao
fi
done
}

bot_menu () {
source <(curl -sSL https://raw.githubusercontent.com/GM-VIP/BOT/main/confbot.sh)
}

encript () {
source <(curl -sSL https://raw.githubusercontent.com/GM-VIP/ENCRYPTOR/main/Obsf-Lite.sh)
}

fun_list () {
rm ${SCPT_DIR}/*.x.c &> /dev/null
unset KEY
KEY="$1"
#CRIA DIR
[[ ! -e ${DIR} ]] && mkdir ${DIR}
#ENVIA ARQS
i=0
VALUE+="gerar.sh instgerador.sh http-server.py $BASICINST"
for arqx in `ls ${SCPT_DIR}`; do
[[ $(echo $VALUE|grep -w "${arqx}") ]] && continue 
echo -e "[$i] -> ${arqx}"
arq_list[$i]="${arqx}"
let i++
done
echo -e "[x] -> \033[0;33mGENERADOR DE KEYS PARA ACTUALIZACIÓN\033[0m"
echo -e "[b] -> \033[0;33mINSTALADOR SCRIPT VIP (VPS-GHOST) VIP\033[0m"
read -p "Seleccione los archivos a ser repasados: " readvalue
#CRIA KEY
[[ ! -e ${DIR}/${KEY} ]] && mkdir ${DIR}/${KEY}
#PASSA ARQS
[[ -z $readvalue ]] && readvalue="b"
read -p "Nombre de usuario ( KEYS OWNER ): " nombrevalue
[[ -z $nombrevalue ]] && nombrevalue="SIN NOMBRE"
if [[ $readvalue = @(b|B) ]]; then
#ADM BASIC
 arqslist="$BASICINST"
 for arqx in `echo "${arqslist}"`; do
 [[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
 cp ${SCPT_DIR}/$arqx ${DIR}/${KEY}/
 echo "$arqx" >> ${DIR}/${KEY}/${LIST}
 done
elif [[ $readvalue = @(x|X) ]]; then
# GERADOR KEYS
read -p "KEY DE ACTUALIZACIÓN?: [Y/N]: " -e -i n attGEN
[[ $(echo $nombrevalue|grep -w "FIXA") ]] && nombrevalue+=[GERADOR]
 for arqx in `ls $SCPT_DIR`; do
  [[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
  cp ${SCPT_DIR}/$arqx ${DIR}/${KEY}/
 echo "$arqx" >> ${DIR}/${KEY}/${LIST}
 echo "Gerador" >> ${DIR}/${KEY}/GERADOR
 done
if [[ $attGEN = @(Y|y|S|s) ]]; then
[[ -e ${DIR}/${KEY}/gerar.sh ]] && rm ${DIR}/${KEY}/gerar.sh
[[ -e ${DIR}/${KEY}/http-server.py ]] && rm ${DIR}/${KEY}/http-server.py
fi
else
 for arqx in `echo "${readvalue}"`; do
 #UNE ARQ
 [[ -e ${DIR}/${KEY}/${arq_list[$arqx]} ]] && continue #ANULA ARQUIVO CASO EXISTA
 rm ${SCPT_DIR}/*.x.c &> /dev/null
 cp ${SCPT_DIR}/${arq_list[$arqx]} ${DIR}/${KEY}/
 echo "${arq_list[$arqx]}" >> ${DIR}/${KEY}/${LIST}
 done
echo "TRUE" >> ${DIR}/${KEY}/FERRAMENTA
fi
rm ${SCPT_DIR}/*.x.c &> /dev/null
echo "$nombrevalue" > ${DIR}/${KEY}.name
[[ ! -z $IPFIX ]] && echo "$IPFIX" > ${DIR}/${KEY}/keyfixa
draw_line
#echo -e "$BARRA"
echo -e "Key Activa, y Esperando Instalacion!"
draw_line
#echo -e "$BARRA"
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

gerar_key () {
valuekey="$(date | md5sum | head -c10)"
valuekey+="$(echo $(($RANDOM*10))|head -c 5)"
fun_list "$valuekey"
keyfinal=$(ofus "$IP:8888/$valuekey/$LIST")
echo -e "KEY: $keyfinal\nGenerada Con Exito!"
draw_line
#echo -e "$BARRA"
read -p " Presiona [Enter] para Finalizar!!!"
}

att_gen_key () {
i=0
rm ${SCPT_DIR}/*.x.c &> /dev/null
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
echo "[$i] Retornar"
keys="$keys retorno"
let i++
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
arqsx=$(ofus "$IP:8888/$arqs/$LIST")
if [[ $(cat ${DIR}/${arqs}.name|grep GERADOR) ]]; then
echo -e "\033[1;31m[$i] $arqsx ($(cat ${DIR}/${arqs}.name))\033[1;32m ($(cat ${DIR}/${arqs}/keyfixa))\033[0m"
keys="$keys $arqs"
let i++
fi
done
keys=($keys)
draw_line
#echo -e "$BARRA"
while [[ -z ${keys[$value]} || -z $value ]]; do
read -p "Seleccione qué Actualizar[t=todos]: " -e -i 0 value
done
[[ $value = 0 ]] && return
if [[ $value = @(t|T) ]]; then
i=0
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
KEYDIR="$DIR/$arqs"
rm $KEYDIR/*.x.c &> /dev/null
 if [[ $(cat ${DIR}/${arqs}.name|grep GERADOR) ]]; then #Keyen Atualiza
 rm ${KEYDIR}/${LIST}
   for arqx in `ls $SCPT_DIR`; do
    cp ${SCPT_DIR}/$arqx ${KEYDIR}/$arqx
    echo "${arqx}" >> ${KEYDIR}/${LIST}
    rm ${SCPT_DIR}/*.x.c &> /dev/null
    rm $KEYDIR/*.x.c &> /dev/null
   done
 arqsx=$(ofus "$IP:8888/$arqs/$LIST")
 echo -e "\033[1;33m[KEY]: $arqsx \033[1;32m(ACTUALIZADA!)\033[0m"
 fi
let i++
done
rm ${SCPT_DIR}/*.x.c &> /dev/null
draw_line
#echo -e "$BARRA"
echo -ne "\033[0m" && read -p "Enter"
return 0
fi
KEYDIR="$DIR/${keys[$value]}"
[[ -d "$KEYDIR" ]] && {
rm $KEYDIR/*.x.c &> /dev/null
rm ${KEYDIR}/${LIST}
  for arqx in `ls $SCPT_DIR`; do
  cp ${SCPT_DIR}/$arqx ${KEYDIR}/$arqx
  echo "${arqx}" >> ${KEYDIR}/${LIST}
  rm ${SCPT_DIR}/*.x.c &> /dev/null
  rm $KEYDIR/*.x.c &> /dev/null
  done
 arqsx=$(ofus "$IP:8888/${keys[$value]}/$LIST")
 echo -e "\033[1;33m[KEY]: $arqsx \033[1;32m(ACTUALIZADA!)\033[0m"
 read -p "Enter"
 rm ${SCPT_DIR}/*.x.c &> /dev/null
 }
}

remover_key () {
i=0
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
echo "[$i] Retornar"
keys="$keys retorno"
let i++
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
arqsx=$(ofus "$IP:8888/$arqs/$LIST")
if [[ ! -e ${DIR}/${arqs}/used.date ]]; then
echo -e "\033[1;32m[$i] $arqsx ($(cat ${DIR}/${arqs}.name))\033[1;33m (AGUARDANDO USO)\033[0m"
else
echo -e "\033[1;31m[$i] $arqsx ($(cat ${DIR}/${arqs}.name))\033[1;33m ($(cat ${DIR}/${arqs}/used.date) IP: $(cat ${DIR}/${arqs}/used))\033[0m"
fi
keys="$keys $arqs"
let i++
done
keys=($keys)
echo -e "$BARRA"
while [[ -z ${keys[$value]} || -z $value ]]; do
read -p "Elija cual eliminar: " -e -i 0 value
done
[[ -d "$DIR/${keys[$value]}" ]] && rm -rf $DIR/${keys[$value]}* || return
}

remover_key_usada () {
i=0
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
arqsx=$(ofus "$IP:8888/$arqs/$LIST")
 if [[ -e ${DIR}/${arqs}/used.date ]]; then #KEY USADA
  if [[ $(ls -l -c ${DIR}/${arqs}/used.date|cut -d' ' -f7) != $(date|cut -d' ' -f3) ]]; then
  rm -rf ${DIR}/${arqs}*
  echo -e "\033[1;31m[KEY]: $arqsx \033[1;32m(ELIMINADA!)\033[0m" 
  else
  echo -e "\033[1;32m[KEY]: $arqsx \033[1;32m(AÚN VÁLIDA!)\033[0m"
  fi
 else
 echo -e "\033[1;32m[KEY]: $arqsx \033[1;32m(AÚN VÁLIDA!)\033[0m"
 fi
let i++
done
draw_line
#echo -e "$BARRA"
echo -ne "\033[0m" && read -p "Enter"
}

start_gen () {
unset PIDGEN
PIDGEN=$(ps aux|grep -v grep|grep "http-server.sh")
if [[ ! $PIDGEN ]]; then
screen -dmS generador /bin/http-server.sh -start
else
killall http-server.sh
fi
}

message_gen () {
read -p "NUEVO MENSAJE: " MSGNEW
echo "$MSGNEW" > ${SCPT_DIR}/message.txt
draw_line
#echo -e "$BARRA"
}

rmv_iplib () {
echo -e "SERVIDORES DE KEY ACTIVOS!"
rm /var/www/html/newlib && touch /var/www/html/newlib
rm ${SCPT_DIR}/*.x.c &> /dev/null
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
if [[ $(cat ${DIR}/${arqs}.name|grep GERADOR) ]]; then
var=$(cat ${DIR}/${arqs}.name)
ip=$(cat ${DIR}/${arqs}/keyfixa)
echo -ne "\033[1;31m[USUARIO]:(\033[1;32m${var%%[*}\033[1;31m) \033[1;33m[GERADOR]:\033[1;32m ($ip)\033[0m"
echo "$ip" >> /var/www/html/newlib && echo -e " \033[1;36m[ACTUALIZADO]"
fi
done
echo "104.238.135.147" >> /var/www/html/newlib
draw_line
#echo -e "$BARRA"
read -p "Enter"
}

desint_geb () {
clear
draw_line
#echo -e "$BARRA"
echo " !SEGURO DE PROCEDER A DESINTALAR GENERADOR??: "
draw_line
#echo -e "$BARRA"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p " [S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
rm -rf /etc/newadm-instalacao /etc/http-shell /etc/http-instas /etc/SCRIPT /usr/bin/gerar /bin/gerar /usr/bin/gerar.sh /bin/gerar.sh /us/bin/genplus /bin/genplus /bin/http-server.py /etc/key-gerador
tput clear
cd $HOME
fi
}

atualizar_geb () {
wget -O $HOME/instger.sh https://raw.githubusercontent.com/GM-VIP/SCRIPT/main/instgerador.sh &>/dev/null
chmod +x $HOME/instger.sh
cd $HOME
./instger.sh
rm $HOME/instger.sh &>/dev/null
}

main_menu() {
while true; do
clear && clear
draw_header
unset PID_GEN
PID_GEN=$(ps x|grep -v grep|grep "http-server.sh")
[[ ! $PID_GEN ]] && PID_GEN="\033[1;31m Offline\033[0m" || PID_GEN="\033[1;32m Online\033[0m"
echo -e "Directorio de los archivos repasados \033[1;31m${SCPT_DIR}\033[0m"
echo -e "                INSTALACIONES: $(cat $IVAR)               "
mine_port4
echo
draw_line
#echo -e "$BARRA"
echo -e "[1] ➳ GENERAR 1 KEY ALEATORIA "
echo -e "[2] ➳ ELIMINAR-VERIFICAR KEYS "
echo -e "[3] ➳ LIMPIAR REGISTRO DE KEYS USADAS "
echo -e "[4] ➳ ALTERAR ARCHIVOS DE KEY BASICA "
draw_line
echo -e "[5] ➳ ENCENDER/APAGAR - GENERADOR: $PID_GEN "
echo -e "[6] ➳ VER REGISTRO "
echo -e "[7] ➳ CAMBIAR CREDITOS "
draw_line
echo -e "[8] ➳ ACTUALIZAR GENERADOR "
echo -e "[9] ➳ DESINTALAR GENERADOR "
draw_line
echo -e "[10]➳ MENU BOT GENERADOR "
echo -e "[11]➳ ENCRIPTADOR SHC-Lite "
echo -e "[0] ➳ SALIR "
draw_line
#echo -e "$BARRA"
echo -n ">>> Opción: "
read opcion
case $opcion in
1)gerar_key;;
2)remover_key;;
3)remover_key_usada;;
4)mudar_instacao;;
5)start_gen;;
6)echo -ne "\033[1;36m" && cat /etc/gerar-sh-log 2>/dev/null || echo "NINGUN REGISTRO EN ESTE MOMENTO" && echo -ne "\033[0m" && read -p "Enter";;
6)links_inst;;
7)message_gen;;
8)atualizar_geb;;
9)desint_geb;;
10)bot_menu;;
11)encript;;
0)cd $HOME && clear
  clear
  exit 0
  ;;
esac
done
}

# INICIAR MENÚ PRINCIPAL
main_menu
/usr/bin/gerar.sh
#fin
