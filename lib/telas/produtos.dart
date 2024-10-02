
import 'package:flutter/material.dart';

class Produtos extends StatefulWidget{

  const Produtos({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EstadoProdutos();
  }
}

class _EstadoProdutos extends State<Produtos> {

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("lista de produtos aqui"));
  }

}