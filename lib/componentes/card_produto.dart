import 'package:flutter/material.dart';
import 'package:marcas/estado.dart';

class CardProduto extends StatelessWidget {
  final dynamic produto;

  const CardProduto({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          estadoApp.mostrarDetalhes();
        },
        child: Card(
          child: Column(children: [
            Image.asset('lib/recursos/imagens/produto.jpeg'),
            Row(children: [
              CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset('lib/recursos/imagens/avatar.png')),
              Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
                  child: Text(produto["company"]["name"],
                      style: const TextStyle(fontSize: 17))),
            ]),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(produto["product"]["name"],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15))),
            Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 10.0),
                child: Text(produto["product"]["description"])),
            Row(children: [
              Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text("R\$ ${produto["product"]["price"].toString()}",
                      style: const TextStyle(fontWeight: FontWeight.bold))),
              Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Row(children: [
                    const Icon(Icons.favorite_rounded,
                        color: Colors.red, size: 18),
                    Text(produto["likes"].toString())
                  ]))
            ])
          ]),
        ));
  }
}
