#!/bin/bash
#Mods System By: Rszhiel
#MODD BY: DESARROLLADOR

tput clear

[[ -e /etc/newadm-instalacao ]] && BASICINST="$(cat /etc/newadm-instalacao)" || 
BASICINST="ADMbot.sh apacheon.sh blockBT.sh budp.sh Crear-Demo.sh C-SSR.sh dns-netflix.sh dropbear.sh fai2ban.sh gestor.sh menu message.txt openvpn.sh paysnd.sh PDirect.py PGet.py POpen.py ports.sh PPriv.py PPub.py shadowsocks.sh Shadowsocks-libev.sh Shadowsocks-R.sh sockspy.sh speed.sh speedtest.py squid.sh squidpass.sh ssl.sh sslorig.sh tcp.sh ultrahost Unlock-Pass-VULTR.sh usercodes utils.sh v2ray.sh"

#Funciones integrales
system=$(cat /etc/issue.net)
ar=$(wget -qO- ipv4.icanhazip.com)
credito=$(cat /etc/SCRIPT/message.txt)
mostrariv=$(cat /etc/http-instas)
IVAR=$(cat /etc/http-instas)
IP=$(wget -qO- ipv4.icanhazip.com)

#Visualiza tiempo
_hora=$(printf '%(%H:%M:%S)T') 
_fecha=$(printf '%(%D)T') 

#PROCESADOR
_core=$(printf '%-1s' "$(grep -c cpu[0-9] /proc/stat)")
_usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")

#SISTEMA-USO DA CPU-MEMORIA RAM
ram1=$(free -h | grep -i mem | awk {'print $2'})
ram2=$(free -h | grep -i mem | awk {'print $4'})
ram3=$(free -h | grep -i mem | awk {'print $3'})

_ram=$(printf ' %-9s' "$(free -h | grep -i mem | awk {'print $2'})")
_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")

memorias () {
if [[ "$(grep -c "Ubuntu" /etc/issue.net)" = "1" ]]; then
system=$(cut -d' ' -f1 /etc/issue.net)
system+=$(echo ' ')
system+=$(cut -d' ' -f2 /etc/issue.net |awk -F "." '{print $1}')
elif [[ "$(grep -c "Debian" /etc/issue.net)" = "1" ]]; then
system=$(cut -d' ' -f1 /etc/issue.net)
system+=$(echo ' ')
system+=$(cut -d' ' -f3 /etc/issue.net)
else
system=$(cut -d' ' -f1 /etc/issue.net)
fi
_ram=$(printf ' %-9s' "$(free -h | grep -i mem | awk {'print $2'})")
_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
_usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
_core=$(printf '%-1s' "$(grep -c cpu[0-9] /proc/stat)")
_system=$(printf '%-14s' "$system")
_hora=$(printf '%(%H:%M:%S)T')
echo -e "\033[1;37m SISTEMA            MEMORIA RAM      PROCESSADOR \033[0m"
echo -e "\033[1;37m OS: \033[1;33m$_system \033[1;37mTotal:\033[1;33m$_ram \033[1;37mNucleos: \033[1;33m$_core\033[0m"
echo -e "\033[1;37m Hora:\033[1;33m $_hora     \033[1;37mEn uso: \033[1;33m$_usor \033[1;37mEn uso: \033[1;33m$_usop\033[0m"
}

#Visualiza Barras
BARRA="\033[1;33m ⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊\033[0m"
BARRA1="\033[1;37m \033[0m"

SCPT_DIR="/etc/SCRIPT"
[[ ! -e ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
INSTA_ARQUIVOS="ADMVPS.zip"
DIR="/etc/http-shell"
LIST="MDAKTSOHG"

#Puertos
mine_port4 () {
PT=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
for porta in `echo -e "$PT" | cut -d: -f2 | cut -d' ' -f1 | uniq`; do
    svcs=$(echo -e "$PT" | grep -w "$porta" | awk '{print $1}' | uniq)
    echo -e "\033[1;31m$svcs: \033[1;37m$porta"
done
}

#visualiza IP
meu_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}

mudar_instacao () {
tput clear
echo 
echo -e " >>> MENU DE GENERADOR VIP_PERU !!! <<<"
echo 
while [[ ${var[$value]} != 0 ]]; do
[[ -e /etc/newadm-instalacao ]] && BASICINST="$(cat /etc/newadm-instalacao)" || BASICINST="menu PGet.py ports.sh ADMbot.sh message.txt usercodes sockspy.sh POpen.py PPriv.py PPub.py PDirect.py speedtest.py speed.sh utils.sh dropbear.sh apacheon.sh openvpn.sh shadowsocks.sh ssl.sh squid.sh"
clear
echo -e $BARRA
echo -e " MENÚ SELECCIÓN DE INSTALACIÓN"
echo -e $BARRA
echo " [0] - FINALIZAR PROCEDIMIENTO"
i=1
for arqx in `ls ${SCPT_DIR}`; do
[[ $arqx = @(gerar.sh|http-server.py) ]] && continue
[[ $(echo $BASICINST|grep -w "$arqx") ]] && echo "[$i] - [X] - $arqx" || echo "[$i] - [ ] - $arqx"
var[$i]="$arqx"
let i++
done
echo -ne " Seleccione el archivo [Agregar / Eliminar]: "
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
tput clear
echo 
echo -e " >>> MENU DE GENERADOR VIP_PERU !!! <<<"
echo 
unset KEY
KEY="$1"
#CRIA DIR
[[ ! -e ${DIR} ]] && mkdir ${DIR}
#ENVIA ARQS
i=0
VALUE+="gerar.sh instgerador.sh http-server.py $BASICINST"
for arqx in `ls ${SCPT_DIR}`; do
[[ $(echo $VALUE|grep -w "${arqx}") ]] && continue 
echo -e " [$i] -> ${arqx}"
arq_list[$i]="${arqx}"
let i++
done
echo -e "$BARRA"
echo -e " [x] -> \033[0;37mGENERAR LLAVE PARA ACTUALIZACIÓN \033[0m"
echo -e "$BARRA"
echo -e " [b] -> \033[0;32mGENERAR LLAVE SCRIPT (VIP_PERU)\033[0m"
echo -e "$BARRA"
read -p " Seleccione una opción: " readvalue
#CRIA KEY
[[ ! -e ${DIR}/${KEY} ]] && mkdir ${DIR}/${KEY}
#PASSA ARQS
[[ -z $readvalue ]] && readvalue="b"
read -p " Nombre de usuario ( KEYS OWNER ): " nombrevalue
[[ -z $nombrevalue ]] && nombrevalue="USUARIO"
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
read -p " LLAVE DE ACTUALIZACIÓN?: [Y/N]: " -e -i n attGEN
[[ $(echo $nombrevalue|grep -w "FIXA") ]] && nombrevalue+=[GERADOR]
 for arqx in `ls $SCPT_DIR`; do
  [[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
  cp ${SCPT_DIR}/$arqx ${DIR}/${KEY}/
 echo "$arqx" >> ${DIR}/${KEY}/${LIST}
 echo " Gerador" >> ${DIR}/${KEY}/GERADOR
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
echo " TRUE" >> ${DIR}/${KEY}/FERRAMENTA
fi
rm ${SCPT_DIR}/*.x.c &> /dev/null
echo "$nombrevalue" > ${DIR}/${KEY}.name
[[ ! -z $IPFIX ]] && echo "$IPFIX" > ${DIR}/${KEY}/keyfixa
echo -e "$BARRA"
echo -e " Key Activa, y Esperando Instalacion!"
echo -e "$BARRA"
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
tput clear
echo
echo -e "$BARRA"
echo -e " >>> GENERADOR VIP_PERU !!! <<<"
echo -e "$BARRA"
echo
valuekey="$(date | md5sum | head -c10)"
valuekey+="$(echo $(($RANDOM*10))|head -c 5)"
fun_list "$valuekey"
keyfinal=$(ofus "$IP:8888/$valuekey/$LIST")
echo -e "\033[1;37m Copie su Llave de instalación !!!\033[0m"
echo -e " LLAVE ➾ \033[47;91m$keyfinal\033[0m"
echo -e "$BARRA"
echo -e " SCRIPT"
echo -e " rm -rf instalscript.sh; apt-get update -y && apt-get upgrade -y; wget https://raw.githubusercontent.com/GM-VIP/SCRIPT/main/instalscript.sh; chmod 777 instalscript.sh && ./instalscript.sh"
echo -e "$BARRA"
read -p " Enter para Finalizar"
}

att_gen_key () {
tput clear
echo 
echo -e " >>> MENU DE GENERADOR VIP_PERU !!! <<<"
echo 
i=0
rm ${SCPT_DIR}/*.x.c &> /dev/null
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
echo " [$i] Retornar"
keys="$keys retorno"
let i++
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
arqsx=$(ofus "$IP:8888/$arqs/$LIST")
if [[ $(cat ${DIR}/${arqs}.name|grep GERADOR) ]]; then
echo -e "\033[1;31m [$i] $arqsx ($(cat ${DIR}/${arqs}.name))\033[1;32m ($(cat ${DIR}/${arqs}/keyfixa))\033[0m"
keys="$keys $arqs"
let i++
fi
done
keys=($keys)
echo -e "$BARRA"
while [[ -z ${keys[$value]} || -z $value ]]; do
read -p " Seleccione qué Actualizar[t=todos]: " -e -i 0 value
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
 echo -e "\033[1;33m [KEY]: $arqsx \033[1;32m(ACTUALIZADA!)\033[0m"
 fi
let i++
done
rm ${SCPT_DIR}/*.x.c &> /dev/null
echo -e "$BARRA"
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
 echo -e "\033[1;33m [KEY]: $arqsx \033[1;32m(ACTUALIZADA!)\033[0m"
 read -p " Enter"
 rm ${SCPT_DIR}/*.x.c &> /dev/null
 }
}

remover_key () {
tput clear
echo 
echo -e " >>> MENU DE GENERADOR VIP_PERU !!! <<<"
echo 
i=0
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
echo " [$i] Retornar"
keys="$keys retorno"
let i++
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
arqsx=$(ofus "$IP:8888/$arqs/$LIST")
if [[ ! -e ${DIR}/${arqs}/used.date ]]; then
echo -e "\033[1;32m [$i] $arqsx ($(cat ${DIR}/${arqs}.name))\033[1;33m (AGUARDANDO USO)\033[0m"
else
echo -e "\033[1;31m [$i] $arqsx ($(cat ${DIR}/${arqs}.name))\033[1;33m ($(cat ${DIR}/${arqs}/used.date) IP: $(cat ${DIR}/${arqs}/used))\033[0m"
fi
keys="$keys $arqs"
let i++
done
keys=($keys)
echo -e "$BARRA"
while [[ -z ${keys[$value]} || -z $value ]]; do
read -p " Elije que Llave eliminar: " -e -i 0 value
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
  echo -e "\033[1;31m [KEY]: $arqsx \033[1;32m(ELIMINADA!)\033[0m" 
  else
  echo -e "\033[1;32m [KEY]: $arqsx \033[1;32m(AÚN VÁLIDA!)\033[0m"
  fi
 else
 echo -e "\033[1;32m [KEY]: $arqsx \033[1;32m(AÚN VÁLIDA!)\033[0m"
 fi
let i++
done
echo -e "$BARRA"
echo -ne "\033[0m" && read -p " Enter"
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
tput clear
echo 
echo -e " >>> MENU DE GENERADOR VIP_PERU !!! <<<"
echo 
read -p " NUEVO MENSAJE: " MSGNEW
echo "$MSGNEW" > ${SCPT_DIR}/message.txt
echo -e "$BARRA"
}

rmv_iplib () {
tput clear
echo
echo -e " >>> SERVIDOR DE LLAVES ACTIVAS !!! <<<"
echo
rm /var/www/html/newlib && touch /var/www/html/newlib
rm ${SCPT_DIR}/*.x.c &> /dev/null
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
if [[ $(cat ${DIR}/${arqs}.name|grep GERADOR) ]]; then
var=$(cat ${DIR}/${arqs}.name)
ip=$(cat ${DIR}/${arqs}/keyfixa)
echo -ne "\033[1;31m [USUARIO]:(\033[1;32m${var%%[*}\033[1;31m) \033[1;33m[GERADOR]:\033[1;32m ($ip)\033[0m"
echo "$ip" >> /var/www/html/newlib && echo -e " \033[1;36m[ACTUALIZADO]"
fi
done
echo "104.238.135.147" >> /var/www/html/newlib
echo -e "$BARRA"
read -p " Enter"
}

desint_geb () {
tput clear
echo 
echo -e " >>> MENU DE GENERADOR VIP_PERU !!! <<<"
echo 
echo -e "$BARRA"
echo " !SEGURO DE PROCEDER A DESINTALAR GENERADOR??: "
echo -e "$BARRA"
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

#MENU PRINCIPAL GENERADOR
meu_ip
unset PID_GEN
PID_GEN=$(ps x|grep -v grep|grep "http-server.sh")
[[ ! $PID_GEN ]] && PID_GEN="\033[1;31m [ OFF ]" || PID_GEN="\033[1;32m [ ON ]"

#Cabecera de Panel principal
echo
echo -e "$BARRA"
echo -e "\033[1;37m            🔱  PANEL GENERADOR DE KEYS  🔱      \033[0m"
echo -e "\033[1;37m               VIP_PERU SYSTEM By: GHOST        \033[0m"
echo -e "$BARRA"
memorias
echo -e "$BARRA"
echo -e "\033[1;37m Reseller : \033[1;44m$credito\033[0m"
echo -e "\033[1;37m Keys Instaladas : \033[1;37m[\033[1;32m $mostrariv \033[1;37m]"
echo -e "$BARRA"
echo -e " [1] ➳ GENERAR 1 KEY ALEATORIA"
echo -e " [2] ➳ ELIMINAR-VERIFICAR KEYS"
echo -e " [3] ➳ LIMPIAR REGISTRO DE KEYS USADAS"
echo -e " [4] ➳ ALTERAR ARCHIVOS DE KEY BASICA"
echo -e " [5] ➳ ENCENDER - APAGAR GENERADOR $PID_GEN\033[0m"
echo -e " [6] ➳ VER REGISTRO "
echo -e " [7] ➳ CAMBIAR CREDITOS"
echo -e " [8] ➳ ACTUALIZAR GENERADOR   "
echo -e " [9] ➳ DESINTALAR GENERADOR   "
echo -e " [10]➳ MENU : BOT TELEGRAM   "
echo -e " [11]➳ ENCRIPTADOR SHC-LITE  "
echo -e " [0] ➳ CERRAR PANEL DE GENERADOR "
echo -e "$BARRA"
echo -n " Opción: "
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
0)exit;;
esac
/usr/bin/gerar.sh

#fin
