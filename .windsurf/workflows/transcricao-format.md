---
description: Formata transcrições de áudio e vídeo com resumo e índice
---

# Workflow de Formatação de Transcrições

Este workflow formata transcrições de áudio e vídeo seguindo as regras definidas em `transcricao.md`.

## Visão Geral

O workflow de formatação de transcrições realiza:

- Adição de resumo no início da transcrição
- Criação de índice para tópicos chaves
- Formatação conforme regras de documentação
- Uso de script de transcrição automática quando necessário

## Uso

Digite `/transcricao-format` para executar o workflow de formatação de transcrições.

## O Workflow

### 1. Coleta de Informações

#### Solicitar informações da transcrição

- Tipo de mídia (áudio ou vídeo)
- Título da transcrição
- Conteúdo da transcrição (texto bruto)
- Tópicos principais abordados

### 2. Criação do Resumo

#### Adicionar resumo no início da transcrição

O resumo deve incluir:

- Descrição breve do conteúdo
- Contexto da transcrição
- Propósito do áudio/vídeo
- Duração aproximada (se disponível)

```markdown
## Resumo

[Descrição breve do que se trata a transcrição em 2-3 frases]

**Contexto:** [Contexto da transcrição]
**Propósito:** [Propósito do áudio/vídeo]
**Duração:** [Duração aproximada, se disponível]
```

### 3. Criação do Índice

#### Criar índice para tópicos chaves

O índice deve listar os principais tópicos com links para as seções correspondentes:

```markdown
## Índice

- [Tópico 1](#tópico-1)
- [Tópico 2](#tópico-2)
- [Tópico 3](#tópico-3)
- [Tópico 4](#tópico-4)
```

### 4. Estruturação do Conteúdo

#### Organizar o conteúdo da transcrição

- Dividir em seções baseadas nos tópicos
- Usar headings apropriados (##, ###)
- Adicionar timestamps se disponíveis
- Identificar falas de diferentes participantes

### 5. Verificação de Legenda/Subtítulo

#### Verificar se há legenda ou subtítulo

- Se houver legenda, usar como base para a transcrição
- Se não houver, usar script de transcrição automática

### 6. Transcrição Automática (se necessário)

#### Usar script de transcrição `transcribe.[sh|ps1|cmd]`

Caso o vídeo ou áudio não tenha legenda ou outro tipo de informação:

```bash
# Linux/Mac
./scripts/transcribe.sh arquivo.mp4

# Windows
scripts\transcribe.cmd arquivo.mp4

# PowerShell
.\scripts\transcribe.ps1 arquivo.mp4
```

### 7. Formatação Final

#### Aplicar formatação conforme documentação.md

- Adicionar badges no topo (se aplicável)
- Adicionar header animado (se aplicável)
- Estruturar conteúdo com headings
- Adicionar footer animado (se aplicável)
- Adicionar resumo final e histórico

## Exemplo Completo

```markdown
![visitors](https://visitor-badge.laobi.icu/badge?page_id=org.repository)
[![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC_BY--SA_4.0-blue.svg)](https://creativecommons.org/licenses/by-sa/4.0/)
![Language: Portuguese](https://img.shields.io/badge/Language-Portuguese-brightgreen.svg)

<!-- Animated Header -->
<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:0f172a,50:1a56db,100:10b981&height=220&section=header&text=Transcrição%20da%20Aula&fontSize=42&fontColor=ffffff&animation=fadeIn&fontAlignY=35&desc=Visão%20Computacional%20-%20Aula%201&descSize=18&descAlignY=55&descColor=94a3b8" width="100%" alt="Transcrição Header"/>
</p>

## Resumo

Transcrição da aula introdutória sobre Visão Computacional, cobrindo fundamentos de processamento de imagens digitais e aplicações práticas.

**Contexto:** Aula 1 do curso de Visão Computacional
**Propósito:** Introduzir conceitos básicos de processamento de imagens
**Duração:** 45 minutos

## Índice

- [Introdução à Visão Computacional](#introdução-à-visão-computacional)
- [Fundamentos de Imagens Digitais](#fundamentos-de-imagens-digitais)
- [Representação de Cores](#representação-de-cores)
- [Operações Básicas](#operações-básicas)

## Introdução à Visão Computacional

[00:00] Bem-vindos à aula de Visão Computacional. Hoje vamos abordar os fundamentos...

[05:30] A Visão Computacional é um campo da inteligência artificial...

## Fundamentos de Imagens Digitais

[10:15] Imagens digitais são representadas como matrizes de pixels...

## Representação de Cores

[20:00] Existem diferentes modelos de representação de cores...

## Operações Básicas

[30:45] As operações básicas incluem filtragem, suavização...

## Perguntas e Respostas

[40:00] Agora vamos às perguntas...

<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:10b981,50:1a56db,100:0f172a&height=120&section=footer" width="100%" alt="Footer"/>
</p>

---
**Resumo:** Transcrição da aula introdutória sobre Visão Computacional
**Data de Criação:** 2026-06-14
**Autor:** Rapport GenerAtiva
**Versão:** 1.0
**Última Atualização:** 2026-06-14
**Atualizado por:** Rapport GenerAtiva
**Histórico de Alterações:**
- 2026-06-14 - Criado por Rapport GenerAtiva - Versão 1.0
```

## Validação

Após executar este workflow, verifique:

- [ ] Resumo presente no início da transcrição
- [ ] Índice criado com tópicos chaves
- [ ] Conteúdo estruturado com headings
- [ ] Timestamps incluídos (se disponível)
- [ ] Formatação conforme documentacao.md
- [ ] Script de transcrição usado quando necessário
- [ ] Links do índice funcionando corretamente

## Integração com Memórias do Projeto

Este workflow integra-se com:

- `transcricao.md`: Regras de transcrições de áudio e vídeo
- `documentacao.md`: Regras de formatação para arquivos markdown
- `PDF.md`: Regras de processamento de PDFs (se transcrição for de PDF)

## Notas Importantes

- As transcrições devem ser formatadas conforme descrito para documentação
- O resumo deve ser conciso e informativo
- O índice deve facilitar navegação pelo conteúdo
- Use timestamps quando disponíveis
- Identifique claramente diferentes participantes
- Use o script de transcrição automática quando não houver legenda

## Script de Transcrição

O script de transcrição deve estar localizado em `scripts/transcribe.[sh|ps1|cmd]`.

### Estrutura esperada do script

- Receber arquivo de áudio/vídeo como argumento
- Usar ferramenta de transcrição (ex: Whisper, Google Speech-to-Text)
- Gerar arquivo de texto com a transcrição
- Retornar caminho do arquivo gerado

### Formatos de Mídia Suportados

- Áudio: MP3, WAV, FLAC, OGG
- Vídeo: MP4, AVI, MKV, MOV

### Troubleshooting

#### Script de Transcrição não encontrado

- Verificar se o script existe em `scripts/`
- Verificar permissões de execução (Linux/Mac)

#### Transcrição automática falhou

- Verificar se a ferramenta de transcrição está instalada
- Verificar formato do arquivo de mídia
- Tentar converter para formato suportado

#### Índice com links quebrados

- Verificar se os anchors correspondem aos headings
- Usar IDs de heading em minúsculas com hífens
- Evitar caracteres especiais nos IDs

### Próximos Passos

Após executar este workflow:

1. Verifique a formatação da transcrição
2. Teste os links do índice
3. Aplique as regras de documentação completas
4. Armazene a transcrição em local apropriado
5. Atualize o histórico se houver modificações
