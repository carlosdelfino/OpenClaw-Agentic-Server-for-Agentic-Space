---
description: Configura ambiente virtual Python, requirements.txt e lançadores de scripts
---

# Workflow de Configuração Python

Este workflow configura o ambiente de desenvolvimento Python seguindo as regras definidas em `python.md`.

## Visão Geral

O workflow de configuração Python estabelece:

- Pasta `venv/` no raiz do projeto para ambiente virtual
- Arquivo `requirements.txt` na pasta `scripts/`
- Lançadores para cada script Python (bash, bat, ps1)
- Garante que pacotes não sejam instalados no sistema operacional

## Uso

Digite `/python-setup` para executar o workflow de configuração Python.

## O Workflow

### 1. Criação do Ambiente Virtual

#### Verificar se pasta `venv/` existe no raiz do projeto

- Se não existir, criar pasta `venv/`
- NÃO instalar pacotes no sistema operacional

#### Criar ambiente virtual Python

```bash
python3 -m venv venv
```

### 2. Criação do requirements.txt

#### Verificar se pasta `scripts/` existe

- Se não existir, criar pasta `scripts/`

#### Criar arquivo `scripts/requirements.txt`

- Listar todas as dependências do projeto
- Incluir versões específicas para reproducibilidade
- Seguir formato padrão do pip

##### Exemplo

```text
numpy==1.24.3
opencv-python==4.8.1.78
matplotlib==3.7.2
```

### 3. Instalação de Dependências

#### Ativar ambiente virtual

```bash
source venv/bin/activate  # Linux/Mac
# ou
venv\Scripts\activate  # Windows
```

#### Instalar dependências do requirements.txt

```bash
pip install -r scripts/requirements.txt
```

### 4. Criação de Lançadores para Scripts

#### Para cada script Python em `scripts/`

- Criar lançador `.sh` para Linux/Mac
- Criar lançador `.bat` para Windows
- Criar lançador `.ps1` para PowerShell
- Todos com o mesmo nome do script Python

##### Exemplo para script `scripts/meu_script.py`

#### scripts/meu_script.sh

```bash
#!/bin/bash
cd "$(dirname "$0")/../"
source venv/bin/activate
python scripts/meu_script.py "$@"
```

#### scripts/meu_script.bat

```batch
@echo off
cd /d "%~dp0.."
call venv\Scripts\activate.bat
python scripts\meu_script.py %*
```

#### scripts/meu_script.ps1

```powershell
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
cd "$scriptPath\.."
& "venv\Scripts\Activate.ps1"
python scripts\meu_script.py $args
```

#### Dar permissão de execução aos scripts .sh

```bash
chmod +x scripts/*.sh
```

## Estrutura Esperada Após Execução

```text
projeto/
├── .windsurf/
│   └── workflows/
│       └── python-setup.md
├── scripts/              (existente ou criado)
│   ├── requirements.txt  (criado)
│   ├── script1.py
│   ├── script1.sh        (criado)
│   ├── script1.bat       (criado)
│   ├── script1.ps1       (criado)
│   ├── script2.py
│   ├── script2.sh        (criado)
│   ├── script2.bat       (criado)
│   └── script2.ps1       (criado)
├── venv/                 (criado)
│   └── (ambiente virtual)
└── (outros arquivos)
```

## Validação

Após executar este workflow, verifique:

- [ ] Pasta `venv/` existe no raiz do projeto
- [ ] Arquivo `requirements.txt` existe em `scripts/`
- [ ] Dependências instaladas apenas no ambiente virtual
- [ ] Lançadores criados para cada script Python
- [ ] Scripts .sh têm permissão de execução
- [ ] Nenhum pacote instalado no sistema operacional

## Integração com Memórias do Projeto

Este workflow integra-se com:

- `python.md`: Regras de desenvolvimento Python com venv
- `logs.md`: Sistema de logging estruturado
- `projeto.md`: Metodologia PDCL para desenvolvimento

## Notas Importantes

- A pasta `venv/` deve estar sempre no raiz do projeto
- Nunca instale pacotes no sistema operacional
- O arquivo `requirements.txt` deve ficar na pasta `scripts/`
- Cada script Python deve ter seus 3 lançadores (sh, bat, ps1)
- Ative sempre o ambiente virtual antes de executar scripts
