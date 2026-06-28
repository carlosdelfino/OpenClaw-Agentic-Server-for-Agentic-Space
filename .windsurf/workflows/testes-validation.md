---
description: Executa testes sistemáticos e validação após modificações de código
---

# Workflow de Testes e Validação

Este workflow executa testes sistemáticos e validação após modificações de código seguindo as regras definidas em `validacao_das_correcoes_e_testes.md`.

## Visão Geral

O workflow de testes e validação realiza:

- Testes unitários para funções individuais
- Testes de integração para componentes
- Testes de aceitação para requisitos de negócio
- Verificação de logs gerados
- Documentação de resultados e correções

## Uso

Digite `/testes-validation` para executar o workflow de testes e validação.

## O Workflow

### 1. Identificação das Modificações

#### Solicitar informações sobre as modificações

- Arquivos modificados
- Tipo de modificação (bug fix, nova feature, refatoração)
- Requisitos afetados

### 2. Testes Unitários

#### Criar/executar testes unitários para funções individuais

```python
import unittest
from meu_modulo import minha_funcao

class TestMinhaFuncao(unittest.TestCase):
    def test_caso_normal(self):
        resultado = minha_funcao(input_valido)
        self.assertEqual(resultado, esperado)
    
    def test_caso_extremo(self):
        resultado = minha_funcao(input_extremo)
        self.assertIsNotNone(resultado)
    
    def test_erro(self):
        with self.assertRaises(ValueError):
            minha_funcao(input_invalido)

if __name__ == '__main__':
    unittest.main()
```

#### Executar testes unitários

```bash
python -m unittest test_meu_modulo.py -v
```

### 3. Testes de Integração

#### Criar/executar testes de integração para componentes

```python
import unittest
from meu_componente import ComponenteA, ComponenteB

class TestIntegracao(unittest.TestCase):
    def setUp(self):
        self.comp_a = ComponenteA()
        self.comp_b = ComponenteB()
    
    def test_fluxo_completo(self):
        saida_a = self.comp_a.processar(entrada)
        saida_final = self.comp_b.processar(saida_a)
        self.assertEqual(saida_final, resultado_esperado)

if __name__ == '__main__':
    unittest.main()
```

#### Executar testes de integração

```bash
python -m unittest test_integracao.py -v
```

### 4. Testes de Aceitação

#### Criar/executar testes de aceitação para requisitos de negócio

```python
import unittest

class TestAceitacao(unittest.TestCase):
    def test_requisito_1(self):
        # Testa requisito de negócio específico
        resultado = executar_cenario_usuario()
        self.assertTrue(resultado['sucesso'])
    
    def test_requisito_2(self):
        # Testa outro requisito de negócio
        resultado = executar_cenario_usuario()
        self.assertEqual(resultado['valor'], esperado)

if __name__ == '__main__':
    unittest.main()
```

#### Executar testes de aceitação

```bash
python -m unittest test_aceitacao.py -v
```

### 5. Verificação de Logs

#### Coletar logs gerados

```bash
# Verificar logs na pasta logs/
ls -la logs/

# Visualizar logs mais recentes
tail -f logs/app.log
```

#### Analisar logs

- Verificar formato correto: `[YYYY-MM-DD HH:MM:SS] [arquivo:função:linha] emoji mensagem - parâmetros`
- Confirmar registros corretos
- Verificar se todos os requisitos estão sendo atendidos
- Identificar gaps ou erros

### 6. Testes de Cenários Reais

#### Testar cenários reais de uso

- Simular uso típico do sistema
- Testar com dados reais ou representativos
- Verificar comportamento em condições normais

### 7. Testes de Condições de Erro

#### Testar condições de erro

```python
def test_erro_conexao():
    with pytest.raises(ConnectionError):
        conectar_com_servidor(url_invalido)

def test_erro_validacao():
    with pytest.raises(ValidationError):
        processar_dados(dados_invalidos)
```

### 8. Testes de Casos Extremos

#### Testar casos extremos

```python
def test_dados_vazios():
    resultado = processar_dados([])
    self.assertEqual(resultado, valor_padrao)

def test_dados_grandes():
    dados = gerar_dados_grandes(1000000)
    resultado = processar_dados(dados)
    self.assertIsNotNone(resultado)
```

### 9. Documentação de Resultados

#### Documentar todos os testes realizados

Criar arquivo `tests/relatorio_testes.md`:

```markdown
# Relatório de Testes

## Data: [AAAA-MM-DD]

## Modificações Testadas

- Arquivo: meu_modulo.py
- Tipo: Bug fix
- Descrição: Correção de erro de validação

## Testes Unitários

- [x] test_caso_normal - PASSOU
- [x] test_caso_extremo - PASSOU
- [x] test_erro - PASSOU

## Testes de Integração

- [x] test_fluxo_completo - PASSOU

## Testes de Aceitação

- [x] test_requisito_1 - PASSOU
- [x] test_requisito_2 - PASSOU

## Cenários Reais

- [x] Cenário típico - PASSOU
- [x] Cenário com dados reais - PASSOU

## Condições de Erro

- [x] Erro de conexão - PASSOU
- [x] Erro de validação - PASSOU

## Casos Extremos

- [x] Dados vazios - PASSOU
- [x] Dados grandes - PASSOU

## Logs Verificados

- [x] Formato correto
- [x] Registros completos
- [x] Sem dados sensíveis

## Resultados

Todos os testes passaram com sucesso. As correções aplicadas atendem aos requisitos.
```

### 10. Análise de Falhas

#### Em falhas, analisar causa raiz

- Identificar a causa raiz do problema
- Documentar a análise
- Propor correções apropriadas
- Repetir o ciclo até aprovação

```markdown
## Análise de Falha

### Teste Falhou: test_caso_extremo

### Causa Raiz

O erro ocorre devido a overflow de memória ao processar grandes volumes de dados.

### Correção Aplicada

Implementar paginação de dados para evitar carregar tudo em memória.

### Validação

- [x] Correção implementada
- [x] Teste reexecutado - PASSOU
```

## Validação

Após executar este workflow, verifique:

- [ ] Testes unitários executados e passando
- [ ] Testes de integração executados e passando
- [ ] Testes de aceitação executados e passando
- [ ] Logs gerados verificados
- [ ] Cenários reais testados
- [ ] Condições de erro testadas
- [ ] Casos extremos testados
- [ ] Resultados documentados
- [ ] Correções aplicadas se necessário
- [ ] Ciclo repetido até validação

## Integração com Memórias do Projeto

Este workflow integra-se com:

- `validacao_das_correcoes_e_testes.md`: Regras de validação de correções e testes
- `logs.md`: Sistema de logging estruturado
- `pdcl.md`: Metodologia PDCL para desenvolvimento
- `projeto.md`: Metodologia PDCL para desenvolvimento

## Notas Importantes

- Execute testes após qualquer modificação de código
- Teste cenários reais, condições de erro e casos extremos
- Documente todos os testes realizados
- Documente resultados e correções aplicadas
- Em falhas, analise causa raiz, corrija e repita até aprovação
- Verifique logs gerados para confirmar registros corretos

## Estrutura de Testes Esperada

```text
projeto/
├── tests/
│   ├── test_meu_modulo.py      # Testes unitários
│   ├── test_integracao.py       # Testes de integração
│   ├── test_aceitacao.py       # Testes de aceitação
│   └── relatorio_testes.md     # Relatório de testes
├── logs/                       # Logs gerados
│   └── app.log
└── (outros arquivos)
```

## Ferramentas de Teste Sugeridas

- `unittest` - Framework de testes padrão do Python
- `pytest` - Framework de testes alternativo com mais recursos
- `coverage` - Ferramenta para medir cobertura de testes
- `pytest-cov` - Plugin de pytest para cobertura

## Comandos Úteis

```bash
# Executar todos os testes
python -m unittest discover tests/

# Executar com cobertura
coverage run -m unittest discover tests/
coverage report

# Executar com pytest
pytest tests/ -v

# Executar com pytest e cobertura
pytest tests/ --cov=. --cov-report=html
```

## Próximos Passos

Após executar este workflow:

1. Revise o relatório de testes
2. Verifique se todos os testes passaram
3. Analise falhas se houver
4. Aplique correções necessárias
5. Reexecute os testes
6. Atualize a documentação
7. Faça commit das alterações validadas
