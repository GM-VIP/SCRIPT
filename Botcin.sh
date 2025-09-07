#!/usr/bin/env bash
# Instalador robusto para GM-VIP — descarga y ejecuta binario protegido
# Requiere: bash, tar, curl o wget

set -Eeuo pipefail
IFS=$'\n\t'

# ================== CONFIG ==================
# URL de tu paquete protegido (.tar.gz) en descarga directa
BIN_URL="${BIN_URL:-https://dl.dropboxusercontent.com/scl/fi/trh5xxq5y5adzsu3jcq22/instalscript.tar.gz?rlkey=mjukmdpvbh0qofj0nxo3a3zc2&st=0ibhyysj}"

# (OPCIONAL) URL al archivo de hash SHA256 del .tar.gz (si lo publicas)
URL_SHA="${URL_SHA:-}"   # ej: https://dl.dropboxusercontent.com/s/.../instalscript.tar.gz.sha256

# (OPCIONAL) Ejecutar APT antes de instalar (1 = sí, 0 = no)
DO_APT="${DO_APT:-0}"

# Nombre del ejecutable dentro del tar
BIN_NAME="${BIN_NAME:-instalscript}"
# ============================================

# ---- utilidades ----
say()   { printf '\033[1;36m[*]\033[0m %s\n' "$*"; }
ok()    { printf '\033[1;32m[✔]\033[0m %s\n' "$*"; }
warn()  { printf '\033[1;33m[!]\033[0m %s\n' "$*"; }
die()   { printf '\033[1;31m[✘]\033[0m %s\n' "$*" >&2; exit 1; }

need()  { command -v "$1" >/dev/null 2>&1 || die "Falta '$1'. Instálalo e inténtalo de nuevo."; }

fetch() {
  # $1=url  $2=dest
  if command -v curl >/dev/null 2>&1; then
    curl -LfsS "$1" -o "$2"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "$2" "$1"
  else
    die "Necesito curl o wget para descargar."
  fi
}

# ---- prereqs ----
need tar
need mktemp
need uname

# Privilegios APT (opcional)
if [ "$DO_APT" = "1" ]; then
  if [ "$(id -u)" -ne 0 ]; then
    warn "No eres root: intentaré usar sudo para APT."
    command -v sudo >/dev/null 2>&1 || die "Se requiere sudo para ejecutar APT."
    SUDO=sudo
  else
    SUDO=
  fi
fi

# ---- trabajo en /tmp con limpieza ----
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
cd "$TMP"

# ---- (opcional) apt update/upgrade ----
if [ "$DO_APT" = "1" ]; then
  say "Actualizando sistema (puede tardar)…"
  $SUDO apt-get update -y -o=Dpkg::Use-Pty=0
  $SUDO DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -o=Dpkg::Use-Pty=0 || warn "upgrade parcial"
  ok "APT listo."
fi

# ---- descarga del paquete ----
say "Descargando paquete…"
fetch "$BIN_URL" x.tgz
[ -s x.tgz ] || die "Descarga vacía o fallida."

# ---- verificación SHA256 (si hay URL_SHA) ----
if [ -n "$URL_SHA" ]; then
  need sha256sum
  say "Verificando integridad…"
  fetch "$URL_SHA" x.sha256
  [ -s x.sha256 ] || die "No se pudo obtener el archivo SHA256."
  # Permitir formatos "HASH  FICHERO" o solo "HASH"
  if grep -q ' ' x.sha256; then
    sha256sum -c x.sha256
  else
    echo "$(cat x.sha256)  x.tgz" | sha256sum -c -
  fi
  ok "Integridad OK."
fi

# ---- extracción ----
say "Extrayendo…"
tar -xzf x.tgz || die "No se pudo extraer el tar.gz."

[ -f "$BIN_NAME" ] || die "No se encontró '$BIN_NAME' dentro del paquete."
chmod +x "$BIN_NAME"

# ---- diagnóstico opcional ----
say "Sistema: $(uname -s) / Arquitectura: $(uname -m)"
ok  "Ejecutando $BIN_NAME…"

# Pasa todos los argumentos recibidos al binario interno
"./$BIN_NAME" "$@"
