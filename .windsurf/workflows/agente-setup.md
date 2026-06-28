---
description: Cria estrutura de diretórios para desenvolvimento de agentes com tool calling
---

# Workflow de Configuração de Agente

Este workflow cria a estrutura de diretórios para desenvolvimento de agentes com tool calling seguindo as regras definidas em `agente.md`.

## Visão Geral

O workflow de configuração de agente estabelece:

- Estrutura de diretórios para o agente
- Modelfile personalizado para Ollama
- Arquivos de configuração
- Script de instalação (setup.sh)
- Integração com Ollama e OpenAI

## Uso

Digite `/agente-setup` para executar o workflow de configuração de agente.

## O Workflow

### 1. Criação da Estrutura de Diretórios

#### Criar diretórios principais

```bash
mkdir -p dynamic_services
mkdir -p models
mkdir -p tools
```

### 2. Criação do Modelfile

#### Criar arquivo `models/Modelfile`

```dockerfile
FROM llama3

PARAMETER temperature 0.7
PARAMETER top_p 0.9
PARAMETER top_k 40

SYSTEM Você é um agente especializado em análise de dados com acesso a ferramentas externas.
```

### 3. Criação de Ferramentas Estáticas

#### Criar arquivo `tools/gpu_detector.py`

```python
import torch

def detect_gpu():
    """
    Detecta se GPU está disponível
    """
    return torch.cuda.is_available()

def get_gpu_info():
    """
    Retorna informações da GPU
    """
    if torch.cuda.is_available():
        return {
            'available': True,
            'device_name': torch.cuda.get_device_name(0),
            'device_count': torch.cuda.device_count()
        }
    return {'available': False}
```

#### Criar arquivo `tools/data_analysis_tools.py`

```python
import pandas as pd
import numpy as np

def load_data(filepath):
    """
    Carrega dados de um arquivo
    """
    return pd.read_csv(filepath)

def analyze_data(data):
    """
    Realiza análise básica dos dados
    """
    return {
        'shape': data.shape,
        'columns': list(data.columns),
        'dtypes': data.dtypes.to_dict(),
        'describe': data.describe().to_dict()
    }
```

### 4. Criação do Agent Orchestrator

#### Criar arquivo `agent_orchestrator.py`

```python
import ollama
from tools.gpu_detector import detect_gpu
from tools.data_analysis_tools import load_data, analyze_data

class AgentOrchestrator:
    def __init__(self, model='llama3'):
        self.model = model
        self.tools = self._load_tools()
    
    def _load_tools(self):
        """
        Carrega ferramentas disponíveis
        """
        return {
            'detect_gpu': detect_gpu,
            'load_data': load_data,
            'analyze_data': analyze_data
        }
    
    def chat(self, message):
        """
        Processa mensagem do usuário
        """
        response = ollama.chat(
            model=self.model,
            messages=[{'role': 'user', 'content': message}],
            tools=self._format_tools()
        )
        return response
    
    def _format_tools(self):
        """
        Formata ferramentas para o formato Ollama
        """
        formatted = []
        for name, func in self.tools.items():
            formatted.append({
                'type': 'function',
                'function': {
                    'name': name,
                    'description': func.__doc__,
                    'parameters': {'type': 'object', 'properties': {}}
                }
            })
        return formatted
```

### 5. Criação do requirements.txt

#### Criar arquivo `requirements.txt`

```text
ollama>=0.1.0
torch>=2.0.0
pandas>=2.0.0
numpy>=1.24.0
openai>=1.0.0
python-dotenv>=1.0.0
```

### 6. Criação do Script de Instalação

#### Criar arquivo `setup.sh`

```bash
#!/bin/bash

echo "Configurando ambiente do agente..."

# Criar estrutura de diretórios
mkdir -p dynamic_services
mkdir -p models
mkdir -p tools

# Baixar modelo base
echo "Baixando modelo base..."
ollama pull llama3

# Criar Modelfile
echo "Criando Modelfile..."
cat > models/Modelfile << EOF
FROM llama3

PARAMETER temperature 0.7
PARAMETER top_p 0.9
PARAMETER top_k 40

SYSTEM Você é um agente especializado em análise de dados com acesso a ferramentas externas.
EOF

# Criar modelo personalizado
echo "Criando modelo personalizado..."
ollama create my-agent -f models/Modelfile

echo "Configuração concluída!"
```

#### Dar permissão de execução

```bash
chmod +x setup.sh
```

### 7. Criação do Arquivo .env

#### Criar arquivo `.env`

```env
OPENAI_API_KEY=your_api_key_here
OPENAI_CODEX=gpt-4
OPENAI_MODEL=gpt-3.5-turbo
```

### 8. Criação do Script de Interface Interativa

#### Criar arquivo `interactive_shell.py`

```python
from agent_orchestrator import AgentOrchestrator
import sys

def main():
    agent = AgentOrchestrator(model='my-agent')
    
    print("=== Agente Interativo ===")
    print("Comandos disponíveis:")
    print("  auto    - Executa pipeline completo")
    print("  tools   - Lista ferramentas disponíveis")
    print("  sair    - Sai do agente")
    print("  ajuda   - Mostra instruções")
    print()
    
    while True:
        try:
            user_input = input("Você: ").strip()
            
            if user_input.lower() in ['sair', 'exit', 'quit']:
                print("Até logo!")
                break
            elif user_input.lower() == 'tools':
                print("Ferramentas disponíveis:")
                for tool in agent.tools.keys():
                    print(f"  - {tool}")
            elif user_input.lower() == 'ajuda':
                print("Instruções de uso:")
                print("  Digite sua pergunta ou comando")
                print("  Use 'auto' para executar pipeline completo")
                print("  Use 'tools' para ver ferramentas")
                print("  Use 'sair' para sair")
            elif user_input.lower() == 'auto':
                print("Executando pipeline completo...")
                response = agent.chat("Execute análise completa dos dados disponíveis")
                print(f"Agente: {response['message']['content']}")
            else:
                response = agent.chat(user_input)
                print(f"Agente: {response['message']['content']}")
                
        except KeyboardInterrupt:
            print("\nAté logo!")
            break
        except Exception as e:
            print(f"Erro: {e}")

if __name__ == '__main__':
    main()
```

## Estrutura Esperada Após Execução

```text
agente_analise_dados/
├── dynamic_services/      # Serviços dinâmicos gerados
├── models/               # Modelfile do Ollama
│   └── Modelfile
├── tools/                # Ferramentas estáticas
│   ├── gpu_detector.py
│   └── data_analysis_tools.py
├── agent_orchestrator.py # Orquestrador principal
├── interactive_shell.py   # Shell interativo
├── requirements.txt       # Dependências
├── setup.sh              # Script de instalação
└── .env                  # Variáveis de ambiente
```

## Validação

Após executar este workflow, verifique:

- [ ] Estrutura de diretórios criada
- [ ] Modelfile criado em `models/`
- [ ] Ferramentas estáticas criadas em `tools/`
- [ ] Agent orchestrator implementado
- [ ] Script de instalação funcional
- [ ] requirements.txt criado
- [ ] Arquivo .env criado
- [ ] Modelo Ollama baixado e configurado

## Integração com Memórias do Projeto

Este workflow integra-se com:

- `agente.md`: Regras de desenvolvimento de agentes com tool calling
- `python.md`: Regras de desenvolvimento Python
- `logs.md`: Sistema de logging estruturado

## Notas Importantes

- Use introspecção para descobrir ferramentas automaticamente
- Carregue serviços dinâmicos de `dynamic_services/`
- Atualize tool definitions em tempo de execução
- Verifique créditos OpenAI antes de usar a API
- Exiba alerta modal se não houver créditos
- Salve novos tools em `dynamic_services/`

## Integração com Ollama

### Modelos

- Use Modelfile personalizado para modelos especializados
- Configure modelo padrão no agent_orchestrator
- Baixe modelo base automaticamente no setup.sh

### Tool Calling

- Defina tools no formato JSON com `type: "function"`
- Use `ollama.chat()` com parâmetro `tools`
- Execute tools e retorne resultados ao modelo

## Integração com OpenAI

### Configuração

- Use variáveis de ambiente do `.env`
- `OPENAI_API_KEY` para autenticação
- `OPENAI_CODEX` para geração de código
- `OPENAI_MODEL` para chat geral

### Verificação de Créditos

- Verifique créditos antes de usar a API
- Detecte erros de billing/credit/insufficient
- Exiba alerta com instruções para recarregar
- Faça cache da verificação para não repetir

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

## Próximos Passos

Após executar este workflow:

1. Execute `./setup.sh` para configurar o modelo
2. Instale dependências: `pip install -r requirements.txt`
3. Configure variáveis de ambiente no `.env`
4. Execute o agente: `python interactive_shell.py`
5. Adicione ferramentas personalizadas em `tools/`
6. Implemente serviços dinâmicos em `dynamic_services/`
