import 'package:flutter/material.dart';
import 'package:marcas/estado.dart';
import 'package:marcas/telas/detalhes.dart';
import 'package:marcas/telas/produtos.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const Marcas());
}

class Marcas extends StatelessWidget {
  const Marcas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Melhores Marcas',
      theme: ThemeData(
        // 
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lime),
        useMaterial3: true,
      ),
      home: const TelaPrincipal(title: 'Flutter Demo Home Page'),
    );
  }
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key, required this.title});

  final String title;

  @override
  State<TelaPrincipal> createState() => _EstadoTelaPrincipalState();
}

class _EstadoTelaPrincipalState extends State<TelaPrincipal> {  

  @override
  Widget build(BuildContext context) {
    estadoApp = context.watch<Estado>();

    Widget tela = const SizedBox.shrink();

    if(estadoApp.mostrandoProdutos()){
      tela = const Produtos();
    }
    else if(estadoApp.mostrandoDetalhes()){
      tela = const Detalhes();
    }

    return tela;
  }
}
