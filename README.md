# Projeto Best Minds - Case Churras
---
## Objetivo do Desafio
*Avaliar o desempenho técnico e o conhecimento da plataforma Salesforce.*

## Solução
*O objetivo da solução é criar um aplicativo no Salesforce para registrar orçamentos de churrasco.*

## Modelo de Dados

<img src="./assets/ModeloDeDados.png" />

---

## Solução Técnica / Explicações dos campos nos objetos

- [ ] 1 - **Contact**
    - [ ] **Name:** Campo padrão do Salesforce
    - [ ] **CPF:** Campo texto que representa o CPF do Cliente
    - [ ] **Telefone:** Campo padrão do Salesforce
    - [ ] **Data de Nascimento:** Campo padrão do Salesforce
    - [ ] **E-mail:** Campo padrão do Salesforce

- [ ] 2 - **Orçamento de churras**
    - [ ] **Name:** Campo de texto padrão do Salesforce que representa o nome do evento de churras
    - [ ] **Tipo:** Lista de opções que representa o tipo do evento
    - [ ] **Cliente:** Campo de relacionamento com o *[contato](#L17)*
    - [ ] **Status:** Campo de seleção de lista que representa o status do churras
    - [ ] **Início:** Campo de data hora que representa a data do Orçamento de churras
    - [ ] **Fim:** Campo de data hora que representa a data do Orçamento de churras
    - [ ] **Valor Total:** Campo de resumo de totalização dos valores dos itens

- [ ] 3 - **Item do orçamento de churras**
    - [ ] **Name:** Numeração automática gerado pelo próprio Salesforce
    - [ ] **Orçamento de churras:** Campo de relacionamento com o objeto *[Orçamento de churras](#L24)*
    - [ ] **Produto:** Campo de relacionamento com o objeto *[Product2](#L40)*
    - [ ] **Quantidade:** Campo numérico que representa a quantidade de itens
    - [ ] **Valor:** Campo moeda que representa o valor do item

- [ ] 4 - **Product2**
    - [ ] **Name:** Campo padrão do Salesforce
    - [ ] **Tipo de registro:** Campo padrão do Salesforce que representa se é um produto ou serviço
    - [ ] **Serviço:** Campo de lista de opções que representa o tipo do serviço
    - [ ] **Valor:** Campo moeda que representa o custo do produto
    - [ ] **Ativo:** Campo padrão do Salesforce

- [ ] 5 - **Avaliação**
    - [ ] **Name:** Numeração automática gerado pelo próprio Salesforce
    - [ ] **Orçamento de churras:** Campo de relacionamento com o objeto *[Orçamento de churras](./README.md#L24)*
    - [ ] **Nota:** Campo numérico que representa a nota de 0 a 10 pela organização do evento
    - [ ] **Observações:** Campo área de texto que representa as observações da nota dada

---

## Regras de Negócio