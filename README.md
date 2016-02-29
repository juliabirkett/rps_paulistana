# rps_paulistana

Esta gem tem como objetivo gerar arquivos RPS (Recibo Provisório de Serviços), que são utilizados para geração de Nota Fiscal Paulistana em lote. Tais arquivos são de registro fixo e devem seguir um layout disponibilizado pela Prefeitura de São Paulo.
O layout utilizado nesta primeira versão foi o V.002, e o manual utilizado está [disponível aqui.](http://nfpaulistana.prefeitura.sp.gov.br/arquivos/manual/NFe_Layout_RPS.pdf)
Futuramente daremos suportes a outras versões, mas, até o momento, a gem suporta a versão mais atual do manual da Prefeitura.

Abaixo, segue tabela comparativa dos nomes dos campos utilizados no desenvolvimento:

### Registro Tipo 1 - Cabeçalho

| Nome do campo na Gem             | Nome do campo no Manual |
| :------------------:             | :---------------------: |
| Versão do Arquivo                | layout_version          |
| Inscrição Municipal do Prestador | municipal_registration  |
| Data de início                   | start_date              |
| Data de fim                      | end_date                |

### Registro Tipo 6 - Detalhe

| Nome do campo na Gem             | Nome do campo no Manual |
| :------------------:             | :---------------------: |
| Tipo de RPS                | rps_type          |
| Série do RPS | rps_serial  |
| Número do RPS                  | rps_number              |
| Data de emissão                      | issuing_date                |
| Situação da RPS               | rps_status |
| Valor do serviços             | amount |
| Valor das deduções         | tax_amount |
| Código do serviço prestado    | service_code      |
| Alíquota                     | aliquot            |
| ISS retido                   | iss_by             |
| Indicador de CPF/CNPJ do tomador | taker_type     |
| CPF/CNPJ do tomador          | taker_document |
| Inscrição Municipal do tomador | municipal_registration |
| Inscrição Estadual do tomador | state_registration |
| Nome/Razão Social do tomador  | taker_name | 
| Tipo do endereço              | address_type |
| Endereço do tomador           | address      |
| Número do endereço            | address_number | 
| Complemento                   | complement     |
| Bairro do tomador             | district |
| Cidade do tomador             | city     |
| UF do tomador                 | uf        |
| Email do tomador              | taker_email |
| PIS/PASEP                     | pis_pasep   |
| COFINS                        | cofins     |
| INSS                          | inss       |
| IR                            | ir         |
| CSSL                          | cssl       |
| Carga tributária - valor      | total_tax_amount |
| Carga tributária - porcentagem |  tributary_percentage |
| Carga tributária - fonte      | tributary_source |
| CEI                           | cei |
| Matrícula da obra             | matriculation |
| Município prestação - cód. IBGE | city_ibge_code |
| Discriminação dos serviços | service_description | 

### Registro Tipo 9 - Rodapé

| Nome do campo na Gem             | Nome do campo no Manual |
| :------------------:             | :---------------------: |
| Nº de linhas de detalhe no arquivo | total_detail_lines |
| Valor total dos serviços no arquivo | total_amount |
| Valor total das deduções no arquivo | total_tax_amount |

## Output
Esta gem suporta dois tipos de output:

1. Exibir o resultado da RPS na tela - chamando a função to_s.
2. Salvar o resultado da RPS num arquivo - chamando a função save_to_file.

## Exemplo

```ruby
rps = NFE::RPS.new
rps.add_header(header = {municipal_registration: "46923700"})
rps.add_detail({
    rps_number: "1",
    rps_status: "T",
    amount: "100",
    tax_amount: "0",
    service_code: "06298",
    aliquot: "0500",
    iss_by: "2",
    taker_type: "1",
    taker_document: "00012345698",
    service_description: "Aqui a descrição do meu serviço"
})
rps.set_footer
rps.save_to_file
```
