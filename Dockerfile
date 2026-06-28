# syntax=docker/dockerfile:1.7

# Imagem base oficial do Node.js
FROM node:24-alpine

# Maintainer
LABEL maintainer="carlosdelfino"
LABEL description="Agente de IA Agenticspace - Agente Capacita PSC - Tutor com Openclaw"

# Define o diretório de trabalho
WORKDIR /app

# Configuracoes nao sensiveis do agente usadas durante o build
ARG AGENT_NAME=agente-capacita-psc-tutor
ARG AGENT_DISPLAY_NAME="Agente Capacita PSC - Tutor"
ARG AGENT_SKILL_FILE=https://agenticspace.vercel.app/agents/SKILL.md
ARG MODEL_PROVIDER=nvidia
ARG MODEL_ID=nemotron-3-super-120b-a12b
ARG MODEL_PROFILE_ID=nvidia:default

ENV OPENCLAW_HOME=/root/.openclaw \
    AGENT_NAME=${AGENT_NAME} \
    AGENT_DISPLAY_NAME=${AGENT_DISPLAY_NAME} \
    AGENT_SKILL_FILE=${AGENT_SKILL_FILE} \
    MODEL_PROVIDER=${MODEL_PROVIDER} \
    MODEL_ID=${MODEL_ID} \
    MODEL_PROFILE_ID=${MODEL_PROFILE_ID}

# Instala dependências necessárias
RUN apk add --no-cache curl git bash

# Instala Openclaw globalmente
RUN npm install -g openclaw@latest

# Cria o diretório do workspace do Openclaw
RUN mkdir -p /root/.openclaw

# Copia o script de setup do agente
COPY setup-agent.sh /app/setup-agent.sh
RUN chmod +x /app/setup-agent.sh

# Executa o setup durante o build.
# Segredos devem ser passados por BuildKit, sem COPY para dentro da imagem:
#   docker build \
#     --secret id=app_env,src=.env \
#     --secret id=agent_config,src=agent-config.json \
#     -t agente-capacita-psc-tutor:1.0 .
RUN --mount=type=secret,id=app_env,required=false \
    --mount=type=secret,id=agent_config,required=false \
    /app/setup-agent.sh

# Expõe a porta padrão do Openclaw Gateway (8789)
EXPOSE 8789

# Comando para iniciar o Openclaw Gateway em foreground
# A senha pode ser configurada via variável de ambiente GATEWAY_PASSWORD
CMD ["sh", "-c", "export OPENCLAW_GATEWAY_PASSWORD=\"${OPENCLAW_GATEWAY_PASSWORD:-${GATEWAY_PASSWORD:-1234senha}}\"; exec openclaw gateway --port 8789 --bind lan --auth password --allow-unconfigured"]
