import 'package:flutter/material.dart';
import 'package:marcas/estado.dart';

import 'package:provider/provider.dart';

import 'telas/detalhes.dart';
import 'telas/produtos.dart';

void main() {
  runApp(const Marcas());
}

class Marcas extends StatelessWidget {
  const Marcas({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Estado(),
      child: MaterialApp(
        title: 'Melhores Marcas',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(),
          useMaterial3: true,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blueGrey)
        ),
        home: const TelaPrincipal(title: 'Flutter Demo Home Page'),
      )
    );
  }
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key, required this.title});

  final String title;

  @override
  State<TelaPrincipal> createState() => _EstadoTelaPrincipal();
}

class _EstadoTelaPrincipal extends State<TelaPrincipal> {
  @override
  Widget build(BuildContext context) {
    estadoApp = context.watch<Estado>();

    Widget tela = const SizedBox.shrink();
    if (estadoApp.mostrandoProdutos()) {
      tela = const Produtos();
    } 
    else if (estadoApp.mostrandoDetalhes()) {
      tela = const Detalhes();
    }
    return tela;
  }
}