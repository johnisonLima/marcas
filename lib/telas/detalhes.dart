import 'package:flutter/material.dart';

class Detalhes extends StatefulWidget{

  const Detalhes({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EstadoDetalhe();
  }
}

class _EstadoDetalhe extends State<Detalhes> {

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Detalhe do produto aqui"));
  }

}