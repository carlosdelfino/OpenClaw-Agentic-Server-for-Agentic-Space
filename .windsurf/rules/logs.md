---
trigger: always_on
---

# Sistema de Logging Estruturado

## Aplicação

Implemente sistema de logging estruturado em todo código produzido.

## Emojis por Tipo de Log

- ℹ️ - Informações gerais
- ⚠️ - Alertas
- ❌ - Erros críticos
- ✅ - Operações concluídas
- 🔍 - Depuração
- 🚀 - Início de processos
- 🏁 - Fim de processos

## Formato das Linhas de Log

```text
[YYYY-MM-DD HH:MM:SS] [arquivo:função:linha] emoji mensagem - parâmetros_relevantes
```

## Segurança

- Nunca inclua dados sensíveis como senhas ou tokens

## Configurações por Plataforma

### Desktop

- Adicione flag `--logs` para controle de exibição

### Firmware

- Use porta serial em modo debug
- Utilize script Python para captura e armazenamento

## Armazenamento

- Pasta: `logs/`
- Rotação automática: diária ou ao atingir 10MB

## Configuração de Níveis

- Variáveis de ambiente
- Arquivo `config.json`
