import 'package:flutter/material.dart';
import 'package:marcas/estado.dart';

class Detalhes extends StatefulWidget {
  const Detalhes({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EstadoDetalhes();
  }
}

class _EstadoDetalhes extends State<Detalhes> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Text("detalhes"),
      FloatingActionButton(
          child: const Text("produtos"),
          onPressed: () => {estadoApp.mostrarProdutos()})
    ]);
  }
}
