# sigepweb

Utilize serviços dos Correios no seu App como buscar CEP ou calcular preços e prazos de encomendas

## O que é isso?

O Sigepweb é um sistema dos Correios criado para prover os serviços desta "incrível" empresa de entregas com sua empresa.

> Para o gerenciamento das postagens, os Correios oferecem aos clientes de contrato o sistema SIGEP Web.
> O SIGEP Web auxilia na preparação das encomendas, gerando rótulos com códigos de rastreamento e encaminha essas informações à unidade dos Correios para postagem dos pacotes com maior agilidade.
> [Confira aqui](https://www.correios.com.br/logistica/e-commerce/solucoes-correios-para-o-e-commerce)

## A integração está completa?

Você pode estar se perguntando se este package oferece todos os serviços que a API disponibiliza e até este momento a resposta é NÃO!

O fato é que são muitos métodos para implementar e por enquanto eu sinceramente não sei se isso é realmente útil a comunidade. Eu vou estar trabalhando à medida do possível neste package para ele crescer, mas honestamente não tenho muito tempo para isso. Portanto se você tem alguma necessidade que este package pode resolver futuramente entre em contato para pedir sua implementação e eu poderei então lhe dar prioridade. Lembrando que tudo será feito à medida do possível.

## Contribua

Ajude este package a crescer e chegar ao ponto de oferecer todos os serviços que a API disponibiliza. Deixe seu Pull-Request. Fique também a vontade para entrar em contato comigo.

## Exemplo

### Calcule Precos e Prazos para suas encomendas

```dart
var sigep = Sigepweb(contrato: SigepContrato.semContrato());

var calcPrecoPrazo = await sigep.calcPrecoPrazo(
  cepOrigem: '70002900',
  cepDestino: '04547000',
  valorPeso: 1,
);

// Isso vai retornar uma lista com os 
// resultados do calculo
for (var item in calcPrecoPrazo) {
  print("${item.nome}: R\$ ${item.valor}");
}
```

## Métodos já funcionando

 - calcPrecoPrazo
 - consultaCEP
 