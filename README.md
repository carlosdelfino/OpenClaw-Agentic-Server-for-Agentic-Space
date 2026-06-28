![visitors](https://visitor-badge.laobi.icu/badge?page_id=carlosdelfino.docker-containerizacao)
[![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC_BY--SA_4.0-blue.svg)](https://creativecommons.org/licenses/by-sa/4.0/)
![Language: Portuguese](https://img.shields.io/badge/Language-Portuguese-brightgreen.svg)
![Docker](https://img.shields.io/badge/Docker-Container-blue)
![Nginx](https://img.shields.io/badge/Nginx-Web%20Server-green)
![Cloud Computing](https://img.shields.io/badge/Cloud%20Computing-PaaS-orange)
![Status](https://img.shields.io/badge/Status-Entrega%20Obrigat%C3%B3ria-brightgreen)

<!-- Animated Header -->
<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:0f172a,50:1a56db,100:10b981&height=220&section=header&text=Aplica%C3%A7%C3%A3o%20Containerizada%20com%20Docker&fontSize=42&fontColor=ffffff&animation=fadeIn&fontAlignY=35&desc=Projeto%20Pr%C3%A1tico%20-%20M%C3%B3dulo%20Inicial%20Capacita%C3%A7%C3%A3o%20PSC&descSize=18&descAlignY=55&descColor=94a3b8" width="100%" alt="Docker Containerization Header"/>
</p>

## Descrição do Projeto

Este projeto consiste em uma atividade prática obrigatória do Módulo Inicial do curso de Capacitação PSC, focada em containerização de aplicações utilizando Docker e conceitos de computação em nuvem.

A solução implementa uma aplicação web simples containerizada com Docker, utilizando o servidor web Nginx em uma imagem base Alpine Linux, demonstrando na prática os conceitos de PaaS (Platform as a Service), escalabilidade, elasticidade e responsabilidade compartilhada.

## Estrutura do Projeto

```text
.
├── Dockerfile              # Definição do container Docker
├── index.html              # Página web da aplicação
├── RELATORIO.md            # Relatório técnico detalhado
├── README.md               # Este arquivo
└── upload-2922787072265833984.pdf  # Enunciado da atividade
```

## Componentes

- **Dockerfile**: Arquivo de configuração para construção da imagem do container
- **Nginx**: Servidor web de alta performance para servir conteúdo estático
- **Alpine Linux**: Sistema operacional minimalista para reduzir o tamanho da imagem
- **HTML5/CSS3**: Aplicação web com design moderno e responsivo

## Como Utilizar

### Pré-requisitos

- Docker instalado na máquina local

### Construir a Imagem

```bash
docker build -t app-containerizada .
```

### Executar o Container

```bash
docker run -d -p 8080:80 --name meu-app app-containerizada
```

### Acessar a Aplicação

Abra o navegador e acesse: `http://localhost:8080`

### Parar o Container

```bash
docker stop meu-app
docker rm meu-app
```

## Entregáveis

- **Dockerfile**: Arquivo de definição do container
- **RELATORIO.md**: Relatório técnico contendo:
  - Modelo de serviço em nuvem escolhido (PaaS)
  - Justificativa da escolha
  - Componentes utilizados
  - Benefícios da solução proposta
  - Aplicação dos conceitos de escalabilidade, elasticidade e responsabilidade compartilhada

## Modelo de Serviço em Nuvem

A solução utiliza o modelo **PaaS (Platform as a Service)**, que oferece uma plataforma completa para desenvolvimento e execução de aplicações sem a necessidade de gerenciar a infraestrutura subjacente.

## Conceitos Aplicados

### Escalabilidade

- Escalabilidade horizontal através de múltiplas instâncias de containers
- Escalabilidade vertical através de aumento de recursos alocados
- Auto-scaling baseado em métricas de performance

### Elasticidade

- Provisionamento dinâmico de recursos sob demanda
- Resposta automática a eventos de aumento de carga
- Otimização de custos através de liberação de recursos quando não necessários

### Responsabilidade Compartilhada

- **Provedor PaaS**: Infraestrutura física, runtime de containers, segurança da plataforma
- **Cliente**: Desenvolvimento da aplicação, configuração do container, segurança da aplicação, dados

## Referências

- [Documentação Oficial do Docker](https://docs.docker.com/)
- [Documentação do Nginx](https://nginx.org/en/docs/)
- [Alpine Linux](https://alpinelinux.org/)

<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:10b981,50:1a56db,100:0f172a&height=120&section=footer" width="100%" alt="Footer"/>
</p>

---
**Resumo:** Projeto prático de containerização com Docker utilizando Nginx e Alpine Linux, demonstrando conceitos de PaaS, escalabilidade, elasticidade e responsabilidade compartilhada em computação em nuvem.
**Data de Criação:** 2025-05-31
**Autor:** Rapport Generativa
**Versão:** 1.0
**Última Atualização:** 2025-05-31
**Atualizado por:** Rapport Generativa
**Histórico de Alterações:**
- 2025-05-31 - Criado por Rapport Generativa - Versão 1.0
# OpenClaw-Agentic-Server-for-Agentic-Space
# OpenClaw-Agentic-Server-for-Agentic-Space
