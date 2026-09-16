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
readonly rootdir="$(cd -- "$(dirname -- "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
readonly path="${HOME}/.local/share"
readonly bin="${HOME}/.local/bin"

echo -e "${GREEN}[+]${RESET} Install dotenv"

dirs=(
    "${bin}"
    "${path}"
)

# * Verifica se os diretórios necessários existem
echo -e "${YELLOW}[*]${RESET} Verificando se os diretórios existem"
for dir in "${dirs[@]}"; do
    if [[ ! -d "${dir}" ]]; then
        echo -e "${YELLOW}[${dir}]${RESET} Diretório não existe"
        if ! mkdir -p "${dir}"; then
            echo -e "${RED}[!]${RESET} Falha ao criar: ${dir}"
            exit 1
        fi
    else
        echo -e "${GREEN}[+]${RESET} Diretório ${dir} OK"
    fi
done

# * Verifica se já existe uma instalação
if [[ -d "${dotenv_default}" ]]; then
    echo -e "${YELLOW}[!]${RESET} Uma versão do dotenv já está instalada"
    read -rp "[?] Deseja remover a versão atual? [s/N] " sn
    case "${sn,,}" in
        s|sim)
            echo -e "${YELLOW}[*]${RESET} Removendo versão já instalada"

            if ! rm -rf "${dotenv_default}"; then
                echo -e "${RED}[!]${RESET} Falha ao remover: ${dotenv_default}"
                exit 1
            fi

            if [[ -e "${bin}/dotenv" || -L "${bin}/dotenv" ]]; then
                if ! rm -f "${bin}/dotenv"; then
                    echo -e "${RED}[!]${RESET} Falha ao remover: ${bin}/dotenv"
                    exit 1
                fi
            fi
        ;;

        n|nao|não|"") echo -e "${CYAN}[*]${RESET} Instalação atual será mantida" ;;
        \*) echo -e "${RED}[!]${RESET} Opção inválida" ; exit 1 ;;
    esac
fi

# * Cria o diretório de instalação

echo -e "${BLUE}[+]${RESET} Criando diretório raiz"

if [[ ! -d "${path}" ]]; then
    if ! mkdir -p "${path}"; then
        echo -e "${RED}[!]${RESET} Falha ao criar diretório raiz"
        exit 1
    fi
fi

# * Inicia a cópia dos arquivos
echo -e "${BLUE}[+]${RESET} Iniciando cópia dos arquivos"
if ! cp -r "${rootdir}" "${path}"; then
    echo -e "${RED}[!]${RESET} Falha ao copiar os arquivos"
    exit 1
fi

# * Define o dotenv como executável
if ! chmod +x "${dotenv_default}/dotenv.sh"; then
    echo -e "${RED}[!]${RESET} Falha ao definir permissão de execução"
    exit 1
fi

# * Cria o link simbólico para o comando dotenv
if [[ -e "${bin}/dotenv" || -L "${bin}/dotenv" ]]; then
    rm -f "${bin}/dotenv"
fi

if ! ln -s "${dotenv_default}/dotenv.sh" "${bin}/dotenv"; then
    echo -e "${RED}[!]${RESET} Falha ao criar o link simbólico"
    exit 1
fi

echo -e "${GREEN}[+]${RESET} dotenv instalado com sucesso!"
echo -e "${CYAN}[+]${RESET} Execute '${WHITE}dotenv --version${RESET}' para verificar a instalação"
