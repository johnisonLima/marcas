import 'package:flutter/material.dart';

enum Situacao { mostrandoProdutos, mostrandoDetalhes }

class Estado extends ChangeNotifier {
  Situacao _situacao = Situacao.mostrandoProdutos;

  void mostrarProdutos() {
    _situacao = Situacao.mostrandoProdutos;

    notifyListeners();
  }

  bool mostrandoProdutos() {
    return _situacao == Situacao.mostrandoProdutos;
  }

  void mostrarDetalhes() {
    _situacao = Situacao.mostrandoDetalhes;

    notifyListeners();
  }

  bool mostrandoDetalhes() {
    return _situacao == Situacao.mostrandoDetalhes;
  }
}

late Estado estadoApp;
