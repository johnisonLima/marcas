import 'dart:convert';

import 'package:flat_list/flat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marcas/componentes/card_produto.dart';

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

  final String _filtro = '';

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

    dynamic produtos = _feedDeProdutos["produtos"];

    if (_filtro.isNotEmpty) {
      produtos = produtos
          .where((produtos) =>
              produtos["product"]["name"].toLowerCase().contains(_filtro))
          .toList();
    }

    final totalDeProdutosParaCarregar = _proximaPagina * tamanhoDaPagina;
    if (_feedDeProdutos["produtos"].length >= totalDeProdutosParaCarregar) {
      _produtos =
          // _feedDeProdutos["produtos"].sublist(0, totalDeProdutosParaCarregar);
          _produtos = produtos.sublist(0, totalDeProdutosParaCarregar);
    }

    setState(() {
      _carregando = false;
      _proximaPagina++;
    });
  }

  Future<void> _atualizarProdutos() async {
    _produtos = [];
    _proximaPagina = 1;

    _carregarProdutos();
  }

  void _aplicarFiltro(String filtro) {
    filtro = filtro;

    _carregarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return _carregando
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: const Text('Produtos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              actions: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 90.0, right: 10.0),
                    child: TextField(
                      onSubmitted: (value) {
                        _aplicarFiltro(value);
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.search)),
                    ),
                  ),
                ),
              ],
            ),
            body: FlatList(
              data: _produtos,
              numColumns: 2,
              onEndReached: () => _carregarProdutos(),
              onRefresh: () => _atualizarProdutos(),
              buildItem: (item, index) {
                return SizedBox(height: 370, child: CardProduto(produto: item));
              },
            ),
          );
  }
}
