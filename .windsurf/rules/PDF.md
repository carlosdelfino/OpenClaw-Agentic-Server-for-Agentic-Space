---
trigger: model_decision
---

# Processamento de Arquivos PDF

## Extração de Texto

Arquivos PDF quando forem manipulados, devem usar o Tesseract para extrair seu texto.

## Processamento

- Criar uma pasta temporária chamada `docs/tmp`
- Realizar processamento de extração
- Converter para arquivos MD
- Processar pelo windsurf