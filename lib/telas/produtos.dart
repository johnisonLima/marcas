// ignore_for_file: dead_code

import 'dart:convert';

import 'package:flat_list/flat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marcas/componentes/card_produto.dart';
import 'package:marcas/estado.dart';

class Produtos extends StatefulWidget {
  const Produtos({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EstadoProdutos();
  }
}

const int tamanhoDaPagina = 6;

class _EstadoProdutos extends State<Produtos> {
  late dynamic _feedDeProdutos;
  bool _carregando = false;
  List<dynamic> _produtos = [];

  final TextEditingController _controladorDoFiltro = TextEditingController();
  String _filtro = "";

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

    if (_filtro.isNotEmpty) {
      _produtos = _produtos
          .where((produto) =>
              produto["product"]["name"].toLowerCase().contains(_filtro))
          .toList();
    } else {
      final totalDeProdutosParaCarregar = _proximaPagina * tamanhoDaPagina;
      if (_feedDeProdutos["produtos"].length >= totalDeProdutosParaCarregar) {
        _produtos =
            _feedDeProdutos["produtos"].sublist(0, totalDeProdutosParaCarregar);
      }
    }

    setState(() {
      _carregando = false;
      _proximaPagina++;
    });
  }

  Future<void> _atualizarProdutos() async {
    _produtos = [];
    _proximaPagina = 1;

    _controladorDoFiltro.text = "";
    _filtro = "";

    _carregarProdutos();
  }

  void _aplicarFiltro(String filtro) {
    _filtro = filtro;

    _carregarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    bool usuarioLogado = false; // corrigir aqui

    return _carregando
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(actions: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 60, right: 20),
                      child: TextField(
                        controller: _controladorDoFiltro,
                        onSubmitted: (filtro) {
                          _aplicarFiltro(filtro);
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.search)),
                      ))),
              usuarioLogado
                  ? IconButton(
                      onPressed: () {
                        // preencher aqui
                      },
                      icon: const Icon(Icons.logout))
                  : IconButton(
                      onPressed: () {
                        // preencher aqui
                      },
                      icon: const Icon(Icons.login))
            ]),
            body: FlatList(
                data: _produtos,
                loading: _carregando,
                numColumns: 2,
                onRefresh: () => _atualizarProdutos(),
                onEndReached: () => _carregarProdutos(),
                buildItem: (item, index) {
                  return SizedBox(
                      height: estadoApp.altura * 0.45,
                      child: CardProduto(produto: item));
                }));
  }
}
