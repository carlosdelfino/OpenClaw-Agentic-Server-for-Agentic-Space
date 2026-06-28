---
trigger: model_decision
description: desenvolvimento de agentes com tool calling, auto-evolução e integração com Ollama/OpenAI
---
## Arquitetura do Agente

Ao desenvolver agentes com tool calling e auto-evolução:

1. **Tool Calling vs Function Calling**: São a mesma coisa, apenas nomes diferentes por provedores

   - OpenAI usa "Function Calling"
   - Ollama/Anthropic usam "Tool Calling"
   - Funcionalidade idêntica
2. **Descoberta Dinâmica de Tools**:

   - Use introspecção para descobrir ferramentas automaticamente
   - Carregue serviços dinâmicos de `dynamic_services/`
   - Atualize tool definitions em tempo de execução
3. **Auto-evolução**:

   - Use OpenAI API para gerar novos tools quando necessário
   - Verifique créditos OpenAI antes de usar a API
   - Exiba alerta modal se não houver créditos
   - Salve novos tools em `dynamic_services/`

## Integração com Ollama

1. **Modelos**:

   - Use Modelfile personalizado para modelos especializados
   - Configure modelo padrão no agent_orchestrator
   - Baixe modelo base automaticamente no setup.sh
2. **Tool Calling**:

   - Defina tools no formato JSON com `type: "function"`
   - Use `ollama.chat()` com parâmetro `tools`
   - Execute tools e retorne resultados ao modelo

## Integração com OpenAI

1. **Configuração**:

   - Use variáveis de ambiente do `.env`
   - `OPENAI_API_KEY` para autenticação
   - `OPENAI_CODEX` para geração de código
   - `OPENAI_MODEL` para chat geral
2. **Verificação de Créditos**:

   - Verifique créditos antes de usar a API
   - Detecte erros de billing/credit/insufficient
   - Exiba alerta com instruções para recarregar
   - Faça cache da verificação para não repetir

## Interface Interativa

Ao criar interfaces interativas:

1. **Shell Interativo**:

   - Comando `auto` para executar pipeline completo
   - Comando `tools` para listar ferramentas disponíveis
   - Comando `sair`/`exit`/`quit` para sair
   - Comando ajuda/help para instruções de como o agente é usado
   - Qualquer outra entrada é tratada como pergunta
2. **Argumentos de CLI**:

   - `--interactive` para modo interativo
   - `--no-gpu` para desabilitar GPU
   - `--setup-only` para configurar apenas o modelo
   - `--model` para especificar modelo

## Estrutura de Diretórios

```
agente_analise_dados/
├── dynamic_services/      # Serviços dinâmicos gerados
├── models/               # Modelfile do Ollama
├── tools/                # Ferramentas estáticas
│   ├── gpu_detector.py   # Detecção de GPU
│   └── data_analysis_tools.py
├── agent_orchestrator.py # Orquestrador principal
├── requirements.txt       # Dependências
└── setup.sh              # Script de instalação
```

## Logs Estruturados

Use sistema de logging estruturado com emoticons:

- ℹ️ para informações gerais
- ⚠️ para alertas
- ❌ para erros críticos
- ✅ para operações concluídas
- 🔍 para depuração
- 🚀 para início de processos
- 🏁 para fim

Formato: `[YYYY-MM-DD HH:MM:SS] [arquivo:função:linha] emoji mensagem - parâmetros`

Armazene logs em `logs/` com rotação automática diária ou ao atingir 10MB.

## Documentação

Siga as regras de documentação em `documentacao.md`:

- Badges no topo
- Header animado
- Conteúdo estruturado
- Footer animado
- Resumo final e histórico
