#!/usr/bin/env bash
set -Eeuo pipefail

echo "🚀 Iniciando setup do agente com OpenClaw..."

# -----------------------------------------------------------------------------
# ATENÇÃO:
# Se este script for executado durante o build da imagem Docker, evite gravar
# tokens reais na imagem. O mais seguro é executar como ENTRYPOINT em runtime.
# -----------------------------------------------------------------------------

OPENCLAW_HOME="${OPENCLAW_HOME:-/root/.openclaw}"
mkdir -p "$OPENCLAW_HOME"

strip_outer_quotes() {
  local value="$1"
  if [[ "$value" == \"*\" && "$value" == *\" ]]; then
    value="${value:1:${#value}-2}"
  elif [[ "$value" == \'*\' && "$value" == *\' ]]; then
    value="${value:1:${#value}-2}"
  fi
  printf '%s' "$value"
}

# Carregar variáveis de ambiente sem copiar .env para dentro da imagem.
ENV_LOADED=false
for ENV_FILE in /run/secrets/app_env /app/.env; do
  if [ -f "$ENV_FILE" ]; then
    echo "📄 Carregando variáveis de ambiente de ${ENV_FILE}..."
    set -a
    # shellcheck disable=SC1090
    . "$ENV_FILE"
    set +a
    ENV_LOADED=true
    break
  fi
done

if [ "$ENV_LOADED" = false ]; then
  echo "⚠️  Nenhum arquivo de ambiente encontrado; usando variáveis já definidas."
fi

# -----------------------------------------------------------------------------
# Configurações do agente
# -----------------------------------------------------------------------------

AGENT_NAME="$(strip_outer_quotes "${AGENT_NAME:-agente-capacita-psc-tutor}")"
AGENT_DISPLAY_NAME="$(strip_outer_quotes "${AGENT_DISPLAY_NAME:-Agente Capacita PSC - Tutor}")"
AGENT_SKILL_FILE="$(strip_outer_quotes "${AGENT_SKILL_FILE:-https://agenticspace.vercel.app/agents/SKILL.md}")"

MODEL_PROVIDER="$(strip_outer_quotes "${MODEL_PROVIDER:-nvidia}")"
MODEL_ID="$(strip_outer_quotes "${MODEL_ID:-nemotron-3-super-120b-a12b}")"

# OpenClaw recomenda referência de modelo no formato provider/model
MODEL_REF="$(strip_outer_quotes "${MODEL_REF:-${MODEL_PROVIDER}/${MODEL_ID}}")"

MODEL_PROFILE_ID="$(strip_outer_quotes "${MODEL_PROFILE_ID:-${MODEL_PROVIDER}:manual}")"

WORKSPACE="$(strip_outer_quotes "${WORKSPACE:-${OPENCLAW_HOME}/workspace-${AGENT_NAME}}")"

echo "🔧 Agente: ${AGENT_NAME}"
echo "📂 Workspace: ${WORKSPACE}"
echo "🤖 Modelo: ${MODEL_REF}"
echo "🌐 Skill remoto: ${AGENT_SKILL_FILE}"

mkdir -p "$WORKSPACE"
mkdir -p "$WORKSPACE/.agenticspace"

# -----------------------------------------------------------------------------
# Configuração base do OpenClaw
# -----------------------------------------------------------------------------

echo "🔧 Configurando OpenClaw em modo local..."

if openclaw onboard \
    --non-interactive \
    --accept-risk \
    --mode local \
    --flow quickstart \
    --auth-choice skip \
    --skip-channels \
    --skip-health \
    --skip-ui 2>/tmp/openclaw-onboard.err; then
  echo "✅ Onboarding não interativo concluído."
else
  echo "⚠️  Onboarding falhou ou não está disponível; seguindo com configuração manual."
  cat /tmp/openclaw-onboard.err || true
fi

# Sintaxe: openclaw config set <path> <value>
openclaw config set gateway.mode local || true

# Configurar modelo padrão dos agentes
openclaw config set agents.defaults.model.primary "$MODEL_REF" || true

# Registrar modelo no catálogo local de modelos
openclaw config set agents.defaults.models \
  "{\"${MODEL_REF}\": {\"alias\": \"${MODEL_PROVIDER}-${MODEL_ID}\"}}" \
  --strict-json \
  --merge || true

# -----------------------------------------------------------------------------
# Criar o agente
# -----------------------------------------------------------------------------

echo "📦 Criando agente '${AGENT_NAME}'..."

if openclaw agents list --json 2>/dev/null | grep -q "\"id\"[[:space:]]*:[[:space:]]*\"${AGENT_NAME}\""; then
  echo "✅ Agente '${AGENT_NAME}' já existe."
else
  openclaw agents add "$AGENT_NAME" \
    --workspace "$WORKSPACE" \
    --model "$MODEL_REF" \
    --non-interactive \
    --json || {
      echo "❌ Erro ao criar agente '${AGENT_NAME}'."
      exit 1
    }
fi

# -----------------------------------------------------------------------------
# Configurar API key do modelo
# -----------------------------------------------------------------------------

if [ -n "${MODEL_API_TOKEN:-}" ]; then
  echo "🔑 Configurando API key para provider '${MODEL_PROVIDER}'..."

  printf "%s\n" "$MODEL_API_TOKEN" | openclaw models auth --agent "$AGENT_NAME" paste-api-key \
    --provider "$MODEL_PROVIDER" \
    --profile-id "$MODEL_PROFILE_ID" || {
      echo "❌ Erro ao configurar API key para ${MODEL_PROVIDER}."
      exit 1
    }
else
  echo "⚠️  MODEL_API_TOKEN não definida; pulando configuração de API key."
fi

# -----------------------------------------------------------------------------
# Criar arquivos de definição do agente
# -----------------------------------------------------------------------------

echo "🧠 Criando SOUL.md..."

cat > "$WORKSPACE/SOUL.md" << 'EOF'
# Agente Capacita PSC - Tutor

## Identidade

Você é um agente de IA especializado em ensinar sobre Provimento de Serviços Computacionais, computação em nuvem, AWS, Vercel, Azure, Docker, Kubernetes, serverless e arquitetura moderna de serviços.

## Propósito

Seu objetivo é educar e auxiliar usuários a entenderem conceitos fundamentais e práticos de computação em nuvem, com foco em:

- Provimento de Serviços Computacionais (PSC)
- Modelos IaaS, PaaS e SaaS
- Plataformas AWS, Vercel e Azure
- Containerização com Docker e Kubernetes
- Serverless computing
- Boas práticas de arquitetura
- Deploy, observabilidade, segurança e escalabilidade

## Personalidade

- Paciente e didático
- Prático e orientado a exemplos
- Técnico sem ser confuso
- Focado em aplicação real
- Cuidadoso com segurança, segredos e permissões

## Integrações

- Agentic Space: rede social/hub para agentes de IA
- Credenciais locais em `.agenticspace/credentials.json`
- Skill principal deverá ser obtida e interpretada via prompt do próprio agente
EOF

echo "🤖 Criando AGENTS.md..."

cat > "$WORKSPACE/AGENTS.md" << 'EOF'
# Agentes Conhecidos

## Agente Capacita PSC - Tutor

Agente principal especializado em computação em nuvem, provimento de serviços computacionais, infraestrutura moderna, deploy e arquitetura.
EOF

echo "🪪 Criando IDENTITY.md..."

cat > "$WORKSPACE/IDENTITY.md" << EOF
# Identidade do Agente

## Nome

${AGENT_DISPLAY_NAME}

## ID

${AGENT_NAME}

## Descrição

Agente especializado em ensinar Provimento de Serviços Computacionais, Nuvem, AWS, Vercel, Azure, Docker, Kubernetes e arquitetura de serviços.

## Tema

cloud tutor

## Emoji

☁️

## Integrações

- Agentic Space configurado em .agenticspace/credentials.json
- Skill principal será obtida pelo próprio agente via prompt
EOF

# -----------------------------------------------------------------------------
# Criar/copiar credenciais do Agentic Space
# -----------------------------------------------------------------------------

echo "🔧 Configurando credenciais Agentic Space..."

if [ -f "$WORKSPACE/.agenticspace/credentials.json" ]; then
  echo "✅ Credenciais Agentic Space já existem no workspace."
elif [ -f /run/secrets/agent_config ]; then
  echo "📄 Usando credenciais Agentic Space recebidas via BuildKit secret."
  cp /run/secrets/agent_config "$WORKSPACE/.agenticspace/credentials.json"
elif [ -n "${AGENTICSPACE_API_KEY:-}" ]; then
  echo "📄 Criando credenciais Agentic Space a partir de variáveis de ambiente."
  node -e '
const fs = require("fs");
const data = {
  api_key: process.env.AGENTICSPACE_API_KEY,
  agent_name: process.env.AGENTICSPACE_AGENT_NAME || process.env.AGENT_DISPLAY_NAME || process.env.AGENT_NAME,
  agent_id: process.env.AGENTICSPACE_AGENT_ID || process.env.AGENT_NAME
};
fs.writeFileSync(process.argv[1], JSON.stringify(data, null, 2) + "\n", { mode: 0o600 });
' "$WORKSPACE/.agenticspace/credentials.json"
else
  echo "⚠️  Credenciais Agentic Space não informadas; criando credentials.json vazio."
  cat > "$WORKSPACE/.agenticspace/credentials.json" << 'JSON'
{}
JSON
fi

chmod 600 "$WORKSPACE/.agenticspace/credentials.json"

# -----------------------------------------------------------------------------
# Aplicar identidade no OpenClaw
# -----------------------------------------------------------------------------

echo "🪪 Aplicando IDENTITY.md ao agente..."

openclaw agents set-identity \
  --agent "$AGENT_NAME" \
  --workspace "$WORKSPACE" \
  --from-identity \
  --json || echo "⚠️  Não foi possível aplicar identidade automaticamente."

# -----------------------------------------------------------------------------
# Somente agora solicitar ao agente que baixe/interprete/execute o SKILL.md
# -----------------------------------------------------------------------------

echo "💬 Solicitando ao agente que baixe, interprete e execute o SKILL.md..."

cat > /tmp/openclaw-agent-bootstrap-message.md << EOF
Você já possui um workspace preparado em:

${WORKSPACE}

Antes de qualquer ação, leia os arquivos locais de definição do agente:

- SOUL.md
- AGENTS.md
- IDENTITY.md
- .agenticspace/credentials.json

Depois disso, acesse o seguinte arquivo remoto:

${AGENT_SKILL_FILE}

Esse arquivo remoto é o SKILL.md oficial deste agente.

Tarefas obrigatórias:

1. Use o terminal/shell. Não use web_search.
2. Execute curl para baixar o skill principal:
   curl -fsSL "${AGENT_SKILL_FILE}" -o "${WORKSPACE}/SKILL.md"
3. Leia somente as seções "Auto-Download Required Files", "Setup", "Quick Test" e "Heartbeat Integration" do SKILL.md.
4. Baixe os arquivos auxiliares citados no SKILL.md, sempre com curl -fsSL, para a raiz do workspace:
   - HEARTBEAT.md
   - RULES.md
   - API_GUIDE.md
   - skill.json
5. Para HEARTBEAT.md, use o endpoint com extensão totalmente minúscula:
   curl -fsSL "https://agenticspace.vercel.app/agents/HEARTBEAT.md" -o "${WORKSPACE}/HEARTBEAT.md"
6. Valide cada arquivo baixado. Se algum arquivo começar com <!DOCTYPE html> ou <html, ele não é um arquivo de skill válido; remova-o e informe a falha.
7. Use as credenciais existentes em .agenticspace/credentials.json para executar uma chamada autenticada a:
   https://agenticspace.vercel.app/api/v1/agents/me
8. Grave o resultado sanitizado da conexão em .agenticspace/connection-status.json, contendo apenas:
   - checked_at
   - ok
   - http_status
   - agent_id ou publicId, se existir
   - agent_name ou name, se existir
   - error, se houver
9. Não exponha tokens, chaves, segredos ou credenciais no output.
10. Ao final, responda de forma curta informando:
   - se o SKILL.md foi obtido com sucesso;
   - se os arquivos auxiliares foram obtidos com sucesso;
   - se a conexão com Agentic Space foi efetivada;
   - quais pendências ainda existem, se houver.

Importante:

- Não invente credenciais.
- Não sobrescreva .agenticspace/credentials.json sem necessidade.
- Não remova SOUL.md, AGENTS.md ou IDENTITY.md.
- Se alguma etapa exigir permissão externa, informe claramente.
EOF

BOOTSTRAP_MESSAGE="$(cat /tmp/openclaw-agent-bootstrap-message.md)"

BOOTSTRAP_EXIT=0

openclaw agent \
  --agent "$AGENT_NAME" \
  --session-key "agent:${AGENT_NAME}:build-bootstrap" \
  --message "$BOOTSTRAP_MESSAGE" \
  --local \
  --thinking off \
  --timeout 900 || BOOTSTRAP_EXIT=$?

if [ "$BOOTSTRAP_EXIT" -eq 0 ]; then
  echo "✅ Prompt de bootstrap executado pelo agente."
else
  echo "⚠️  O comando do agente retornou erro (${BOOTSTRAP_EXIT}); validando artefatos antes de falhar."
fi

echo "🔎 Validando resultado do bootstrap do agente..."

validate_downloaded_file() {
  local file="$1"
  local label="$2"

  if [ ! -s "$file" ]; then
    echo "❌ ${label} não foi criado ou está vazio: ${file}"
    return 1
  fi

  if head -n 1 "$file" | grep -Eiq '^[[:space:]]*<!doctype html|^[[:space:]]*<html'; then
    echo "❌ ${label} parece ser HTML, não conteúdo válido de skill: ${file}"
    return 1
  fi
}

validate_downloaded_file "$WORKSPACE/SKILL.md" "SKILL.md" || {
  echo "❌ O build será interrompido para evitar uma imagem sem SKILL.md válido."
  exit 1
}

if grep -q "agentspace-ak-" "$WORKSPACE/SKILL.md"; then
  echo "❌ O SKILL.md baixado parece conter credenciais; interrompendo por segurança."
  exit 1
fi

for REQUIRED_FILE in HEARTBEAT.md RULES.md API_GUIDE.md skill.json; do
  validate_downloaded_file "$WORKSPACE/$REQUIRED_FILE" "$REQUIRED_FILE" || {
    echo "❌ O build será interrompido porque o agente não concluiu o processamento do SKILL.md."
    exit 1
  }
done

if [ ! -s "$WORKSPACE/.agenticspace/connection-status.json" ]; then
  echo "❌ O agente não criou .agenticspace/connection-status.json."
  echo "❌ O build será interrompido porque a conexão com Agentic Space não foi validada."
  exit 1
fi

if ! node -e '
const fs = require("fs");
const file = process.argv[1];
const status = JSON.parse(fs.readFileSync(file, "utf8"));
if (!status || status.ok !== true) {
  console.error("connection-status.json indica falha de conexão.");
  process.exit(1);
}
' "$WORKSPACE/.agenticspace/connection-status.json"; then
  echo "❌ A conexão com Agentic Space não foi efetivada pelo agente."
  exit 1
fi

echo "✅ SKILL.md criado pelo agente."
echo "✅ Arquivos auxiliares do skill criados pelo agente."
echo "✅ Conexão com Agentic Space validada pelo agente."

# -----------------------------------------------------------------------------
# Permissões finais
# -----------------------------------------------------------------------------

echo "🔒 Ajustando permissões..."

chmod 700 "$WORKSPACE"
find "$WORKSPACE" -type d -exec chmod 755 {} \;
find "$WORKSPACE" -type f -exec chmod 644 {} \;

if [ -f "$WORKSPACE/.agenticspace/credentials.json" ]; then
  chmod 600 "$WORKSPACE/.agenticspace/credentials.json"
fi

echo "✅ Setup do agente concluído!"
echo "📂 Workspace: ${WORKSPACE}"
echo "🤖 Agente: ${AGENT_NAME}"
echo "🧠 Modelo: ${MODEL_REF}"
echo "🌐 Skill remoto solicitado ao agente: ${AGENT_SKILL_FILE}"
echo "📡 O agente foi instruído via prompt a baixar, interpretar e executar o SKILL.md"
