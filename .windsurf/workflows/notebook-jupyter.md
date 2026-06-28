---
description: Cria estrutura de notebooks Jupyter com cabeçalho, células e conclusões
---

# Workflow de Criação de Notebooks Jupyter

Este workflow cria a estrutura de notebooks Jupyter seguindo as regras definidas em `notebook_jupiter.md`.

## Visão Geral

O workflow de criação de notebooks Jupyter estabelece:

- Cabeçalho com título, autor e professor
- Células de código com descrições didáticas
- Seção de conclusões baseada nos resultados
- Estrutura baseada na descrição dos dados do projeto

## Uso

Digite `/notebook-jupyter` para executar o workflow de criação de notebooks Jupyter.

## O Workflow

### 1. Coleta de Informações

#### Solicitar informações do notebook

- Nome do projeto ou atividade
- Nome do autor
- Nome do professor (se aplicável)
- Descrição dos dados do projeto
- Tipo de notebook (Jupyter, Colab, NotebookLM)

### 2. Criação do Cabeçalho

#### Criar primeira célula markdown com o cabeçalho

```markdown
# [Nome do Projeto ou Atividade]

**Autor:** [Nome do Autor]
**Professor:** [Nome do Professor - se aplicável]
**Data:** [AAAA-MM-DD]
```

### 3. Criação da Célula de Descrição

#### Criar célula markdown com descrição dos dados

```markdown
## Descrição dos Dados

[Descrição dos dados do projeto definido na pasta]

### Estrutura dos Dados

- [Característica 1]: [Descrição]
- [Característica 2]: [Descrição]
- [Característica 3]: [Descrição]
```

### 4. Criação de Células de Código

#### Para cada célula de código, adicionar célula markdown de descrição didática

```markdown
### [Descrição Didática da Célula]

[Explicação do que será feito nesta célula]
```

#### Adicionar célula de código após a descrição

```python
# [Comentário resumido do código]
import numpy as np
import pandas as pd

# Seu código aqui
dados = carregar_dados()
analise = processar(dados)
```

### 5. Criação de Células de Visualização

#### Para visualizações, adicionar descrição didática

```markdown
### Visualização dos Dados

[Descrição do que será visualizado e por que é importante]
```

#### Adicionar código de visualização

```python
import matplotlib.pyplot as plt

plt.figure(figsize=(10, 6))
plt.plot(dados['x'], dados['y'])
plt.xlabel('Eixo X')
plt.ylabel('Eixo Y')
plt.title('Título do Gráfico')
plt.show()
```

### 6. Criação da Seção de Conclusões

#### Criar célula markdown final com conclusões

```markdown
## Conclusões

### Resultados Obtidos

- [Resultado 1]: [Descrição e análise]
- [Resultado 2]: [Descrição e análise]
- [Resultado 3]: [Descrição e análise]

### Análise dos Dados

[Análise detalhada dos resultados obtidos com o código de análise]

### Insights

- [Insight 1]
- [Insight 2]
- [Insight 3]

### Próximos Passos

- [Próximo passo 1]
- [Próximo passo 2]
- [Próximo passo 3]
```

## Exemplo Completo

```markdown
# Fundamentos de Processamento de Imagens

**Autor:** João Silva
**Professor:** Prof. Maria Santos
**Data:** 2026-05-10

## Descrição dos Dados

Este notebook processa imagens digitais para análise de textura e filtros.

### Estrutura dos Dados

- Imagens em escala de cinza: 256x256 pixels
- Filtros aplicados: gaussiano, mediana, sobel
- Métricas: contraste, entropia, energia

### Carregamento das Imagens

Carregar imagens do dataset e converter para escala de cinza.

```python
import cv2
import numpy as np
import matplotlib.pyplot as plt

imagem = cv2.imread('imagem.jpg', cv2.IMREAD_GRAYSCALE)
plt.imshow(imagem, cmap='gray')
plt.show()
```

### Aplicação de Filtro Gaussiano

Aplicar filtro gaussiano para suavização da imagem.

```python
imagem_suavizada = cv2.GaussianBlur(imagem, (5, 5), 0)
plt.imshow(imagem_suavizada, cmap='gray')
plt.show()
```

### Detecção de Bordas com Sobel

Detectar bordas usando operador Sobel.

```python
sobelx = cv2.Sobel(imagem, cv2.CV_64F, 1, 0, ksize=3)
sobely = cv2.Sobel(imagem, cv2.CV_64F, 0, 1, ksize=3)
sobel = np.sqrt(sobelx**2 + sobely**2)
plt.imshow(sobel, cmap='gray')
plt.show()
```

## Conclusões

### Resultados Obtidos

- Suavização: O filtro gaussiano reduziu o ruído significativamente
- Detecção de bordas: Sobel identificou bordas principais com precisão
- Performance: Processamento realizado em menos de 1 segundo

### Análise dos Dados

A aplicação de filtros melhorou a qualidade da imagem para análise posterior. O filtro gaussiano foi eficaz na redução de ruído, enquanto o Sobel identificou corretamente as bordas principais.

### Insights

- Filtros de suavização são essenciais antes da detecção de bordas
- O tamanho do kernel afeta diretamente o nível de suavização
- A combinação de filtros pode melhorar resultados específicos

### Próximos Passos

- Testar diferentes tamanhos de kernel
- Implementar outros operadores de borda (Canny, Prewitt)
- Adicionar métricas quantitativas para comparação

```markdown

## Validação

Após executar este workflow, verifique:

- [ ] Cabeçalho com título, autor e professor criado
- [ ] Descrição dos dados incluída
- [ ] Células de código antecedidas por descrições didáticas
- [ ] Seção de conclusões criada
- [ ] Conclusões baseadas nos resultados obtidos
- [ ] Código funcionando corretamente
- [ ] Visualizações claras e informativas

## Integração com Memórias do Projeto

Este workflow integra-se com:

- `notebook_jupiter.md`: Regras de criação de notebooks Jupyter
- `documentacao.md`: Regras de formatação para arquivos markdown
- `python.md`: Regras de desenvolvimento Python
- `logs.md`: Sistema de logging estruturado

## Notas Importantes

- Notebooks devem ser criados com base na descrição dos dados do projeto
- Cada célula de código deve ser antecedida com sua descrição didática
- A seção de conclusões deve ser baseada nos resultados obtidos
- Use nomes descritivos para variáveis e funções
- Adicione comentários explicativos no código
- Mantenha células pequenas e focadas em uma tarefa

## Estrutura Esperada do Notebook

```text
Notebook.ipynb
├── Célula Markdown: Cabeçalho (Título, Autor, Professor)
├── Célula Markdown: Descrição dos Dados
├── Célula Markdown: Descrição Didática 1
├── Célula Código: Código 1
├── Célula Markdown: Descrição Didática 2
├── Célula Código: Código 2
├── ...
├── Célula Markdown: Descrição Didática N
├── Célula Código: Código N
└── Célula Markdown: Conclusões
```

## Plataformas Suportadas

- Jupyter Notebook (local)
- Google Colab (nuvem)
- NotebookLM (Google)
- Kaggle Kernels

## Próximos Passos de Execução

Após executar este workflow:

1. Execute o notebook célula por célula
2. Verifique se todas as células funcionam corretamente
3. Revise as conclusões baseadas nos resultados
4. Adicione mais células se necessário
5. Documente insights adicionais
6. Salve o notebook no formato .ipynb
7. Exporte para PDF ou HTML se necessário
