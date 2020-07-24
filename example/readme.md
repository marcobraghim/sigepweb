Utilize serviços dos Correios no seu App como buscar CEP ou calcular preços e prazos de encomendas

### Pesquise um endereço através do CEP

```dart
var sigep = Sigepweb(contrato: SigepContrato.semContrato());

var endereco = await sigep.consultaCEP('70002900');

print(endereco);
```

> Imprime: <br> `{"cep":"70002900","logradouro":"SBN Quadra 1 Bloco A","complemento":null,"bairro":"Asa Norte","cidade":"Brasília","estado":"DF"}`

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

> Imprime: <br>
> Sedex: R$ 53.1 <br>
> PAC: R$ 27.8


