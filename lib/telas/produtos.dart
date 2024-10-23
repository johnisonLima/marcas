import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marcas/estado.dart';

class Produtos extends StatefulWidget {
  const Produtos({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EstadoProdutos();
  }
}

const int tamanhoDaPagina = 4;

class _EstadoProdutos extends State<Produtos> {
  late dynamic _feedDeProdutos;
  bool _carregando = false;
  List<dynamic> _produtos = [];

  int _proximaPagina = 1;

  @override
  void initState() {
    super.initState();

    _lerFeedEstatico();
  }

  Future<void> _lerFeedEstatico() async {
    final String resposta =
        await rootBundle.loadString('lib/recursos/jsons/feed.json');
    _feedDeProdutos = await jsonDecode(resposta);

    _carregarProdutos();
  }

  void _carregarProdutos() {
    setState(() {
      _carregando = true;
    });

    final totalDeProdutosParaCarregar = _proximaPagina * tamanhoDaPagina;
    if (_feedDeProdutos["produtos"].length >= totalDeProdutosParaCarregar) {
      _produtos =
          _feedDeProdutos["produtos"].sublist(0, totalDeProdutosParaCarregar);
    }

    setState(() {
      _carregando = false;
      _proximaPagina++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _carregando
        ? const Center(child: CircularProgressIndicator())
        : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("${_produtos.length}"),
            FloatingActionButton(
                child: const Text("detalhes"),
                onPressed: () => {estadoApp.mostrarDetalhes()})
          ]);
  }
}
