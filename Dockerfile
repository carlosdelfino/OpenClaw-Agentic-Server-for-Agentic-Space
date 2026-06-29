# syntax=docker/dockerfile:1.7

# Imagem base oficial do Node.js
FROM node:24-alpine

# Maintainer
LABEL maintainer="carlosdelfino"
LABEL description="Agente de IA Agenticspace - Agente Capacita PSC - Tutor com Openclaw"

# Define o diretório de trabalho
WORKDIR /app

ENV OPENCLAW_HOME=/root/.openclaw

# Instala dependências necessárias
RUN apk add --no-cache curl git bash

# Instala Openclaw globalmente
RUN npm install -g openclaw@latest

# Cria o diretório do workspace do Openclaw
RUN mkdir -p /root/.openclaw

# Copia o script de setup do agente
COPY setup-agent.sh /app/setup-agent.sh
RUN chmod +x /app/setup-agent.sh

# O setup roda no startup para usar as variáveis configuradas no Railway
# sem depender de BuildKit secrets nem gravar segredos durante o build.

# Expõe a porta padrão do Openclaw Gateway (8789)
EXPOSE 8789

# Comando para configurar o agente e iniciar o Openclaw Gateway em foreground
# A senha pode ser configurada via variável de ambiente GATEWAY_PASSWORD
CMD ["sh", "-c", "/app/setup-agent.sh && export OPENCLAW_GATEWAY_PASSWORD=\"${OPENCLAW_GATEWAY_PASSWORD:-${GATEWAY_PASSWORD:-1234senha}}\" && exec openclaw gateway --port ${PORT:-8789} --bind lan --auth password --allow-unconfigured"]
