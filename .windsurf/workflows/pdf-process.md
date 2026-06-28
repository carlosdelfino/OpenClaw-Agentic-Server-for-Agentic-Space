---
description: Processa arquivos PDF usando Tesseract para extração de texto e conversão para markdown
---

# Workflow de Processamento de PDFs

Este workflow processa arquivos PDF usando Tesseract para extração de texto e conversão para markdown seguindo as regras definidas em `PDF.md`.

## Visão Geral

O workflow de processamento de PDFs realiza:

- Criação de pasta temporária `docs/tmp`
- Extração de texto usando Tesseract OCR
- Conversão para formato markdown
- Processamento pelo windsurf

## Uso

Digite `/pdf-process` para executar o workflow de processamento de PDFs.

## O Workflow

### 1. Identificação do PDF

#### Solicitar o arquivo PDF

- Nome do arquivo PDF a processar
- Caminho completo do arquivo no projeto

### 2. Criação de Pasta Temporária

#### Criar pasta `docs/tmp`

- Se não existir, criar pasta `docs/tmp`
- Esta pasta será usada para processamento temporário

### 3. Extração de Texto com Tesseract

#### Instalar Tesseract (se necessário)

```bash
# Ubuntu/Debian
sudo apt-get install tesseract-ocr tesseract-ocr-por

# macOS
brew install tesseract tesseract-lang

# Windows
# Baixar instalador de https://github.com/UB-Mannheim/tesseract/wiki
```

#### Instalar biblioteca Python pytesseract

```bash
pip install pytesseract Pillow pdf2image
```

#### Extrair texto do PDF

```python
import pytesseract
from pdf2image import convert_from_path
from PIL import Image
import os

def extrair_texto_pdf(pdf_path, output_dir):
    """
    Extrai texto de PDF usando Tesseract OCR
    
    Args:
        pdf_path: Caminho do arquivo PDF
        output_dir: Diretório de saída para arquivos temporários
    """
    # Converter PDF para imagens
    imagens = convert_from_path(pdf_path)
    
    texto_completo = []
    
    for i, imagem in enumerate(imagens):
        # Extrair texto de cada página
        texto = pytesseract.image_to_string(imagem, lang='por')
        texto_completo.append(f"## Página {i + 1}\n\n{texto}\n")
    
    return '\n'.join(texto_completo)
```

### 4. Conversão para Markdown

#### Criar arquivo markdown com o texto extraído

```python
def converter_para_markdown(texto_extraido, output_path):
    """
    Converte texto extraído para formato markdown
    
    Args:
        texto_extraido: Texto extraído do PDF
        output_path: Caminho do arquivo markdown de saída
    """
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(texto_extraido)
```

### 5. Processamento pelo Windsurf

#### O arquivo markdown gerado pode ser processado pelo windsurf

- O arquivo está em formato legível
- Pode ser usado para busca e análise
- Segue as regras de documentação do projeto

## Exemplo Completo

```python
import pytesseract
from pdf2image import convert_from_path
import os

def processar_pdf(pdf_path, output_dir='docs/tmp'):
    """
    Processa PDF completo: extração e conversão para markdown
    
    Args:
        pdf_path: Caminho do arquivo PDF
        output_dir: Diretório de saída
    """
    # Criar diretório de saída se não existir
    os.makedirs(output_dir, exist_ok=True)
    
    # Converter PDF para imagens
    imagens = convert_from_path(pdf_path)
    
    texto_completo = []
    
    for i, imagem in enumerate(imagens):
        # Extrair texto de cada página
        texto = pytesseract.image_to_string(imagem, lang='por')
        texto_completo.append(f"## Página {i + 1}\n\n{texto}\n")
    
    # Gerar nome do arquivo de saída
    pdf_nome = os.path.basename(pdf_path).replace('.pdf', '')
    output_path = os.path.join(output_dir, f'{pdf_nome}.md')
    
    # Salvar como markdown
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write('\n'.join(texto_completo))
    
    return output_path

# Uso
pdf_path = 'documento.pdf'
markdown_path = processar_pdf(pdf_path)
print(f'Arquivo markdown gerado: {markdown_path}')
```

## Validação

Após executar este workflow, verifique:

- [ ] Pasta `docs/tmp` criada
- [ ] Tesseract instalado e funcionando
- [ ] Bibliotecas Python instaladas (pytesseract, Pillow, pdf2image)
- [ ] Texto extraído corretamente do PDF
- [ ] Arquivo markdown gerado
- [ ] Arquivo markdown legível pelo windsurf

## Integração com Memórias do Projeto

Este workflow integra-se com:

- `PDF.md`: Regras de processamento de PDFs
- `documentacao.md`: Regras de formatação para arquivos markdown
- `python.md`: Regras de desenvolvimento Python

## Notas Importantes

- A pasta `docs/tmp` é usada para processamento temporário
- Use Tesseract com idioma português (`lang='por'`)
- PDFs com imagens podem demorar mais para processar
- PDFs com texto digitalizado são mais rápidos que PDFs escaneados
- Limpe a pasta `docs/tmp` após o processamento se não for mais necessária

## Dependências

- Tesseract OCR
- pytesseract (wrapper Python para Tesseract)
- Pillow (manipulação de imagens)
- pdf2image (conversão de PDF para imagens)

## Troubleshooting

### Tesseract não encontrado

```bash
# Verificar instalação
tesseract --version

# Se não encontrado, instalar conforme sistema operacional
```

### Erro de idioma português

```bash
# Instalar pacote de idioma português
sudo apt-get install tesseract-ocr-por  # Ubuntu/Debian
```

### PDF muito grande

- Processar página por página
- Usar resolução menor nas imagens
- Considerar dividir o PDF em partes menores

## Próximos Passos

Após executar este workflow:

1. Verifique o arquivo markdown gerado
2. Ajuste o formato se necessário
3. Aplique as regras de documentação (`documentacao.md`)
4. Processe o arquivo com windsurf se necessário
5. Limpe a pasta `docs/tmp` após o uso
