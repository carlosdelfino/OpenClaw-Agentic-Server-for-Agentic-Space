---
trigger: model_decision
description: Quando criando notebooks em arquivos ipynb com Jupyter no Python
---

# Notebooks Jupyter

## Aplicação

Arquivos ipynb para NotebookLM, Colab e Jupyter devem seguir padrão estruturado.

## Criação de Notebooks

### Base nos Dados do Projeto

Notebooks devem ser criados com base na descrição dos dados do projeto definido em cada pasta.

### Cabeçalho Animado (Primeira Célula)

Adicione na primeira célula do notebook o seguinte header:

```html
<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:0f172a,50:1a56db,100:10b981&height=220&section=header&text=Visão+Computacional&fontSize=32&fontColor=ffffff&animation=fadeIn&fontAlignY=35&desc=Unidade%201%20%7C%20Cap%C3%ADtulo%201%20%7C%20Tarefa%202&descSize=20&descAlignY=55&descColor=94a3b8&pause=1500&duration=6000" width="100%" alt="Visão Computacional"/>
  <img src="https://readme-typing-svg.demolab.com/?lines=<coloque aqui o nome da atividade>&pause=1500&duration=6000" />
</p>
```

**Substitua:**
- `<coloque aqui o nome da atividade>` pelo nome da pasta que contém a atividade
- Ajuste a Unidade, Capítulo e código da tarefa pelo que está descrito no README e PDF que apresenta a atividade

### Informações do Notebook

O notebook deve incluir:

- Título sendo o nome do projeto ou atividade
- Nome do autor
- Nome do professor (se aplicável)

### Células de Código

Cada célula de código deve ser antecedida com sua descrição didática.

### Seção de Conclusões

Ao final deve ter uma seção de conclusões com base nos resultados obtidos com o código de análise.

### Footer Animado (Última Célula)

Adicione na última célula o footer:

```html
<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:10b981,50:1a56db,100:0f172a&height=120&section=footer" width="100%" alt="Footer"/>
</p>
```