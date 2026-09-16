# Bash Dotenv

Uma biblioteca leve e simples escrita puramente em Shell Script para carregar e ler variáveis de ambiente a partir de arquivos `.env`.

---

## 📥 Instalação

Clone o repositório e execute o script de instalação local:

```bash
git clone https://github.com/Pauloxc6/dotenv.git
cd dotenv
bash install.sh
```

Verifique se a instalação foi concluída com sucesso:

```bash
dotenv --version
```

---

## 🚀 Como Usar

### 1. Crie o seu arquivo `.env`

Na raiz do seu projeto, crie o arquivo `.env` contendo as variáveis necessárias:

```env
APIKEY=sua_chave_aqui
PORT=8080
DEBUG=true
```

### 2. Importe e utilize no seu script

Carregue a biblioteca utilizando o `source` e obtenha o valor das chaves com a função `dotenv:get`:

```bash
#!/usr/bin/env bash

# Carrega a biblioteca dotenv
source "${HOME}/.local/share/dotenv/dotenv.sh"

# Obtém a variável do arquivo .env
export GEMINI_API_KEY=$(dotenv:get APIKEY)

# Requisição para a API do Gemini
curl "[https://generativelanguage.googleapis.com/v1beta/models/gemini-3.6-flash:generateContent](https://generativelanguage.googleapis.com/v1beta/models/gemini-3.6-flash:generateContent)" \
  -H 'Content-Type: application/json' \
  -H "X-goog-api-key: ${GEMINI_API_KEY}" \
  -X POST \
  -d '{
    "contents": [
      {
        "parts": [
          {
            "text": "Explique o que é um dotenv em poucas palavras"
          }
        ]
      }
    ]
  }'

```

---

## 🛠️ Funções Disponíveis

| Comando | Descrição | Exemplo |
| --- | --- | --- |
| `dotenv:get <CHAVE>` | Busca o valor de uma chave específica definida no `.env` | `dotenv:get APIKEY` |

---

## 📜 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
