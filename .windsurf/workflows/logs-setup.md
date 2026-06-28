---
description: Adiciona função log_event() para logging estruturado em código Python
---

# Workflow de Configuração de Logs

Este workflow adiciona a função `log_event()` para logging estruturado em código Python seguindo as regras definidas em `logs.md` e `pdcl.md`.

## Visão Geral

O workflow de configuração de logs adiciona:

- Função `log_event()` com captura automática de arquivo, função e linha
- Mapa de emojis para diferentes níveis de log
- Formato padrão de logging estruturado
- Integração com o sistema de logs do projeto

## Uso

Digite `/logs-setup` para executar o workflow de configuração de logs.

## O Workflow

### 1. Identificação do Arquivo Python

#### Solicitar o arquivo Python

- Nome do arquivo Python onde adicionar a função
- Caminho completo do arquivo no projeto

### 2. Adição de Imports

#### Adicionar imports necessários no topo do arquivo

```python
import datetime
import inspect
```

### 3. Adição da Função log_event()

#### Adicionar função log_event() após os imports

```python
def log_event(level: str, message: str, **params):
    """
    Registra evento em formato estruturado PDCL (captura linha automaticamente)
    
    Args:
        level: Nível do log (INFO, ALERT, ERROR, SUCCESS, DEBUG, START, END, DATA, TOOL, CACHE, SAVE)
        message: Mensagem do evento
        **params: Parâmetros adicionais
    """
    timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    emoji_map = {
        'INFO': 'ℹ️',
        'ALERT': '⚠️',
        'ERROR': '❌',
        'SUCCESS': '✅',
        'DEBUG': '🔍',
        'START': '🚀',
        'END': '🏁',
        'DATA': '📊',
        'TOOL': '🔧',
        'CACHE': '📂',
        'SAVE': '💾'
    }
    emoji = emoji_map.get(level, 'ℹ️')
    
    # Captura automaticamente arquivo, função e linha
    frame = inspect.currentframe().f_back
    file = inspect.getfile(frame)
    func = inspect.getframeinfo(frame).function
    line = inspect.getframeinfo(frame).lineno
    
    param_str = ''
    if params:
        param_str = ' - ' + ', '.join(f'{k}={v}' for k, v in params.items())
    
    print(f"[{timestamp}] [{file}:{func}:{line}] {emoji} {message}{param_str}")
```

### 4. Adição de Logs em Pontos Obrigatórios

#### Adicionar logs nos pontos obrigatórios do código

##### Início de processos

```python
log_event('START', 'Iniciando processamento', param1=value1)
```

##### Carregamento de bibliotecas

```python
log_event('START', 'Carregando biblioteca numpy')
import numpy as np
log_event('SUCCESS', 'Biblioteca numpy carregada')
```

##### Execução de ferramentas

```python
log_event('TOOL', 'Executando ferramenta X', input=input_data)
resultado = ferramenta(input_data)
log_event('SUCCESS', 'Ferramenta X executada', output=resultado)
```

##### Operações com dados

```python
log_event('DATA', 'Carregando dados', shape=(rows, cols))
dados = carregar_dados()
log_event('DATA', 'Dados carregados', shape=dados.shape)
```

##### Erros

```python
try:
    operacao()
except Exception as e:
    log_event('ERROR', 'Erro na operação', error=str(e))
```

##### Sucesso

```python
log_event('SUCCESS', 'Operação concluída', metricas={'accuracy': 0.95})
```

##### Cache

```python
if dados in cache:
    log_event('CACHE', 'Cache hit', key=key)
else:
    log_event('CACHE', 'Cache miss', key=key)
```

##### Salvamento

```python
log_event('SAVE', 'Salvando arquivo', filename='dados.csv')
salvar_arquivo('dados.csv', dados)
log_event('SUCCESS', 'Arquivo salvo', filename='dados.csv')
```

### 5. Configuração de Armazenamento de Logs

#### Verificar se pasta logs/ existe

- Se não existir, criar pasta `logs/`
- Configurar rotação automática (diária ou ao atingir 10MB)

## Exemplo de Uso

```python
import datetime
import inspect

def log_event(level: str, message: str, **params):
    """
    Registra evento em formato estruturado PDCL (captura linha automaticamente)
    
    Args:
        level: Nível do log (INFO, ALERT, ERROR, SUCCESS, DEBUG, START, END, DATA, TOOL, CACHE, SAVE)
        message: Mensagem do evento
        **params: Parâmetros adicionais
    """
    timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    emoji_map = {
        'INFO': 'ℹ️',
        'ALERT': '⚠️',
        'ERROR': '❌',
        'SUCCESS': '✅',
        'DEBUG': '🔍',
        'START': '🚀',
        'END': '🏁',
        'DATA': '📊',
        'TOOL': '🔧',
        'CACHE': '📂',
        'SAVE': '💾'
    }
    emoji = emoji_map.get(level, 'ℹ️')
    
    # Captura automaticamente arquivo, função e linha
    frame = inspect.currentframe().f_back
    file = inspect.getfile(frame)
    func = inspect.getframeinfo(frame).function
    line = inspect.getframeinfo(frame).lineno
    
    param_str = ''
    if params:
        param_str = ' - ' + ', '.join(f'{k}={v}' for k, v in params.items())
    
    print(f"[{timestamp}] [{file}:{func}:{line}] {emoji} {message}{param_str}")

def processar_imagem(imagem_path):
    log_event('START', 'Iniciando processamento de imagem', path=imagem_path)
    
    try:
        log_event('DATA', 'Carregando imagem', path=imagem_path)
        imagem = carregar_imagem(imagem_path)
        log_event('SUCCESS', 'Imagem carregada', shape=imagem.shape)
        
        log_event('TOOL', 'Aplicando filtro gaussiano')
        imagem_filtrada = aplicar_filtro(imagem)
        log_event('SUCCESS', 'Filtro aplicado')
        
        log_event('SAVE', 'Salvando resultado', path='resultado.jpg')
        salvar_imagem('resultado.jpg', imagem_filtrada)
        log_event('SUCCESS', 'Resultado salvo')
        
    except Exception as e:
        log_event('ERROR', 'Erro no processamento', error=str(e))
        raise
    
    log_event('END', 'Processamento concluído')

if __name__ == '__main__':
    processar_imagem('imagem.jpg')
```

## Validação

Após executar este workflow, verifique:

- [ ] Imports datetime e inspect adicionados
- [ ] Função log_event() implementada
- [ ] Emojis corretos aplicados para cada nível
- [ ] Logs adicionados em pontos obrigatórios
- [ ] Pasta logs/ criada
- [ ] Formato de log correto: `[YYYY-MM-DD HH:MM:SS] [arquivo:função:linha] emoji mensagem - parâmetros`
- [ ] Nenhum dado sensível (senhas, tokens) nos logs

## Integração com Memórias do Projeto

Este workflow integra-se com:

- `logs.md`: Sistema de logging estruturado
- `pdcl.md`: Metodologia PDCL para desenvolvimento
- `projeto.md`: Metodologia PDCL para desenvolvimento
- `python.md`: Regras de desenvolvimento Python

## Notas Importantes

- Nunca inclua dados sensíveis como senhas ou tokens nos logs
- Use níveis apropriados para cada tipo de evento
- A função captura automaticamente arquivo, função e linha
- Para desktop, adicione flag `--logs` para controle de exibição
- Para firmware, use porta serial em modo debug
- Armazene logs em `logs/` com rotação automática

## Níveis de Log Disponíveis

- `INFO`: ℹ️ - Informações gerais
- `ALERT`: ⚠️ - Alertas
- `ERROR`: ❌ - Erros críticos
- `SUCCESS`: ✅ - Operações concluídas
- `DEBUG`: 🔍 - Depuração
- `START`: 🚀 - Início de processos
- `END`: 🏁 - Fim de processos
- `DATA`: 📊 - Operações com dados
- `TOOL`: 🔧 - Execução de ferramentas
- `CACHE`: 📂 - Operações de cache
- `SAVE`: 💾 - Operações de salvamento
