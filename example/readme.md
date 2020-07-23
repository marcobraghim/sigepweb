Utilize serviços dos Correios no seu App como buscar CEP ou calcular preços e prazos de encomendas

### Calcule Precos e Prazos para suas encomendas

```dart
var sigep = SigepwebPrecoPrazo(contrato: SigepContrato.semContrato());

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


