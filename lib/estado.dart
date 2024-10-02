
import 'package:flutter/material.dart';

enum Situacao{
  mostrandoProdutos,
  mostrandoDetalhes
}

class Estado extends ChangeNotifier {
  Situacao _situacao = Situacao.mostrandoProdutos;


  void mostrandoProdutos() {
    _situacao = Situacao.mostrandoProdutos;

    notifyListeners();
  }

   bool mostrarProdutos(){
    return _situacao == Situacao.mostrandoProdutos;
  }

  void mostrandoDetalhes() {
    _situacao = Situacao.mostrandoDetalhes;
    
    notifyListeners();
  }

  bool mostrarDetalhes(){
    return _situacao == Situacao.mostrandoDetalhes;
  }
}

late Estado estadoApp;