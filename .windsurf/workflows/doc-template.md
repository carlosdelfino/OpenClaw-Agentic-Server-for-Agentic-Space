---
description: Gera template de documentação markdown com badges, header e footer animados
---

# Workflow de Template de Documentação

Este workflow gera um template de documentação markdown seguindo as regras definidas em `documentacao.md`.

## Visão Geral

O workflow de template de documentação cria:

- Badges obrigatórios no topo do arquivo
- Header animado com capsule-render
- Estrutura de conteúdo principal
- Footer animado
- Resumo final e histórico de alterações

## Uso

Digite `/doc-template` para executar o workflow de template de documentação.

## O Workflow

### 1. Coleta de Informações

#### Solicitar informações do documento

- Nome do documento/projeto
- Organização (para badges)
- Repositório (para badges)
- Descrição breve (para header)
- Resumo do conteúdo (para footer)
- Autor do documento
- Data de criação

### 2. Geração dos Badges

#### Criar bloco de badges no topo

Copie o bloco abaixo, substituindo `<org>` e `<repository>`:

```markdown
![visitors](https://visitor-badge.laobi.icu/badge?page_id=<org>.<repository>)
[![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC_BY--SA_4.0-blue.svg)](https://creativecommons.org/licenses/by-sa/4.0/)
![Language: Portuguese](https://img.shields.io/badge/Language-Portuguese-brightgreen.svg)
![Python](https://img.shields.io/badge/Python-3.8%2B-blue)
![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-orange)
![Machine Learning](https://img.shields.io/badge/Machine%20Learning-Prática-green)
![Status](https://img.shields.io/badge/Status-Educa%C3%A7%C3%A3o-brightgreen)
![Repository Size](https://img.shields.io/github/repo-size/<org>/<repository>)
![Last Commit](https://img.shields.io/github/last-commit/<org>/<repository>)
```

### 3. Geração do Header Animado

#### Criar header animado após os badges

Substitua `Nome%20do%20Projeto` e `Descrição%20do%20Projeto`:

```markdown
<!-- Animated Header -->
<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:0f172a,50:1a56db,100:10b981&height=220&section=header&text=Nome%20do%20Projeto&fontSize=42&fontColor=ffffff&animation=fadeIn&fontAlignY=35&desc=Descrição%20do%20Projeto&descSize=18&descAlignY=55&descColor=94a3b8" width="100%" alt="Project Header"/>
</p>
```

### 4. Estrutura do Conteúdo Principal

#### Adicionar conteúdo do documento

- Use títulos hierárquicos (##, ###, ####)
- Adicione seções bem definidas
- Formate código com ```linguagem
- Use links e referências

### 5. Geração do Footer Animado

#### Criar footer animado antes do resumo final

```markdown
<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:10b981,50:1a56db,100:0f172a&height=120&section=footer" width="100%" alt="Footer"/>
</p>
```

### 6. Resumo Final e Histórico

#### Adicionar resumo final e histórico

```markdown
---
**Resumo:** [Descrição concisa do conteúdo do arquivo em uma frase]
**Data de Criação:** [AAAA-MM-DD]
**Autor:** [Nome do autor, se aplicável]
**Versão:** [Versão do documento, se aplicável]
**Última Atualização:** [AAAA-MM-DD]
**Atualizado por:** [Nome de quem atualizou]
**Histórico de Alterações:**
- [AAAA-MM-DD] - Criado por [Autor] - Versão [Versão]
- [AAAA-MM-DD] - Atualizado por [Autor] - [Descrição da alteração] - Versão [Versão]
```

## Exemplo Completo

```markdown
![visitors](https://visitor-badge.laobi.icu/badge?page_id=org.repository)
[![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC_BY--SA_4.0-blue.svg)](https://creativecommons.org/licenses/by-sa/4.0/)
![Language: Portuguese](https://img.shields.io/badge/Language-Portuguese-brightgreen.svg)
![Python](https://img.shields.io/badge/Python-3.8%2B-blue)
![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-orange)
![Machine Learning](https://img.shields.io/badge/Machine%20Learning-Prática-green)
![Status](https://img.shields.io/badge/Status-Educa%C3%A7%C3%A3o-brightgreen)
![Repository Size](https://img.shields.io/github/repo-size/org/repository)
![Last Commit](https://img.shields.io/github/last-commit/org/repository)

<!-- Animated Header -->
<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:0f172a,50:1a56db,100:10b981&height=220&section=header&text=Nome%20do%20Projeto&fontSize=42&fontColor=ffffff&animation=fadeIn&fontAlignY=35&desc=Descrição%20do%20Projeto&descSize=18&descAlignY=55&descColor=94a3b8" width="100%" alt="Project Header"/>
</p>

## Título do Documento

Conteúdo específico do arquivo aqui...

<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:10b981,50:1a56db,100:0f172a&height=120&section=footer" width="100%" alt="Footer"/>
</p>

---
**Resumo:** [Descrição concisa do conteúdo do arquivo em uma frase]
**Data de Criação:** [AAAA-MM-DD]
**Autor:** [Nome do autor, se aplicável]
**Versão:** [Versão do documento, se aplicável]
**Última Atualização:** [AAAA-MM-DD]
**Atualizado por:** [Nome de quem atualizou]
**Histórico de Alterações:**
- [AAAA-MM-DD] - Criado por [Autor] - Versão [Versão]
- [AAAA-MM-DD] - Atualizado por [Autor] - [Descrição da alteração] - Versão [Versão]
```

## Validação

Após executar este workflow, verifique:

- [ ] Badges presentes e corretos no topo
- [ ] Header animado incluído após badges
- [ ] Conteúdo principal estruturado
- [ ] Footer animado incluído antes do resumo
- [ ] Resumo final preenchido
- [ ] Histórico de alterações incluído
- [ ] Data de criação preenchida
- [ ] Autor preenchido

## Integração com Memórias do Projeto

Este workflow integra-se com:

- `documentacao.md`: Regras de formatação para arquivos markdown
- `projeto.md`: Metodologia PDCL para desenvolvimento
- `logs.md`: Sistema de logging estruturado

## Notas Importantes

- O autor inicial deve ser "Rapport GenerAtiva" se não especificado
- Use URL encoding para espaços no header (ex: %20)
- A data deve estar no formato AAAA-MM-DD
- O histórico deve ser atualizado a cada modificação
- O projeto usa ferramenta automática para gerenciar histórico: `markdown_history_manager.py`

## Próximos Passos

Após executar este workflow:

1. Preencha o conteúdo principal do documento
2. Adicione seções específicas conforme necessário
3. Inclua código formatado com a linguagem correta
4. Adicione links e referências relevantes
5. Atualize o histórico a cada modificação
