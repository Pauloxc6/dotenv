#!/usr/bin/env bash

export RESET="\e[0m"
export RED="\e[31;1m"
export GREEN="\e[32;1m"
export YELLOW="\e[33;1m"
export BLUE="\e[34;1m"
export PURPLE="\e[35;1m"
export CYAN="\e[36;1m"
export WHITE="\e[37;1m"

readonly dotenv_default="${HOME}/.local/share/dotenv"
readonly bin="${HOME}/.local/bin"
readonly dotenv="${bin}/dotenv"

echo -e "${GREEN}[+]${RESET} Uninstall dotenv"

# * Verifica se existe uma instalação do dotenv

echo -e "${YELLOW}[*]${RESET} Verificando instalação atual"

if [[ ! -d "${dotenv_default}" && ! -L "${dotenv}" ]]; then
    echo -e "${RED}[!]${RESET} Nenhuma instalação do dotenv foi encontrada"
    exit 1
fi

# * Confirma a remoção da instalação
read -rp "[?] Deseja remover o dotenv? [s/N] " sn
case "${sn,,}" in
    s|sim) echo -e "${YELLOW}[*]${RESET} Iniciando desinstalação" ;;
    n|nao|não|"") echo -e "${CYAN}[*]${RESET} Desinstalação cancelada" ; exit 0 ;;
    *) echo -e "${RED}[!]${RESET} Opção inválida" ; exit 1 ;;
esac

# * Remove o link simbólico do comando dotenv
if [[ -e "${dotenv}" || -L "${dotenv}" ]]; then
    echo -e "${YELLOW}[*]${RESET} Removendo link simbólico: ${dotenv}"
    if ! rm -f "${dotenv}"; then
        echo -e "${RED}[!]${RESET} Falha ao remover o link simbólico"
        exit 1
    fi
fi

# * Remove os arquivos do dotenv
if [[ -d "${dotenv_default}" ]]; then
    echo -e "${YELLOW}[*]${RESET} Removendo arquivos: ${dotenv_default}"
    if ! rm -rf "${dotenv_default}"; then
        echo -e "${RED}[!]${RESET} Falha ao remover os arquivos do dotenv"
        exit 1
    fi
fi

# * Finaliza a desinstalação
echo -e "${GREEN}[+]${RESET} dotenv desinstalado com sucesso!"
