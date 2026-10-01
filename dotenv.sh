#!/usr/bin/env bash

#================================
# * Imports
#================================

# shellcheck disable=SC2155
rootdir="$(cd -- "$(dirname -- "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"

#================================
# * Variáveis
#================================

export LANG=C
export LC_ALL=C

export RESET="\e[0m"
export RED="\e[31;1m"
export GREEN="\e[32;1m"
export YELLOW="\e[33;1m"
export BLUE="\e[34;1m"
export PURPLE="\e[35;1m"
export CYAN="\e[36;1m"
export WHITE="\e[37;1m"

#================================
# * Funções
#================================

function __version_banner(){
    cat <<EOF
 _________
|^|     | |
| |_____| |
|  _____  |
| |     | |
| |_____| |
|_|_____|_|

Bash Dotenv | V: v1.0
By: @Pauloxc6
EOF

}

function debug(){
    # shellcheck disable=SC2329
    function cleanup(){
        set +x
        echo -e "${WHITE}[${BLUE}DEBUG${WHITE}](${CYAN}$(date +'%T / %F')${WHITE}) ${BLUE}Finalizando depuração!${RESET}"
    }

    echo -e "${WHITE}[${BLUE}DEBUG${WHITE}](${CYAN}$(date +'%T / %F')${WHITE}) ${BLUE}Inicinado depuração!${RESET}"

    echo -ne "${YELLOW}"

    set -x

    trap cleanup EXIT
}

function __help() {

    __version_banner

    cat <<HELP

Help:
    --help      | Exibe menu de Ajuda
    --version   | Exite a versão atual
    --debug     | Ativa o modo de depuração

HELP

    exit 0

}

#=================================
# * Verificações
#=================================

function check_file(){
    declare -a list=(
        "$PWD/.env"
    )

    for f in "${list[@]}"; do
        if [ ! -f "${f}" ]; then
            echo "[!] Arquivo ${f} não exite!"
            return 1
        fi
    done
}

function dotenv:get(){

    check_file
    
    local key="${1}"

    chave=$(grep -iE "^${key}=.*" "${f}" | cut -d "=" -f2 | tr -d '"')

    echo "${chave}"
}

#=================================
# * Parser
#=================================

while [[ $# -gt 0 ]]; do

    case "$1" in
        --help) __help ;;
        --version) __version_banner ;;
        --debug) debug ;;
        *) echo -e "[!] Comando $1 não encontrado na lista!${RESET}"; exit 1 ;;
    esac
    shift
    
done

#==================================
# * Main
#==================================

