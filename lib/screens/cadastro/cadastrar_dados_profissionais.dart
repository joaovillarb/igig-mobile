import 'package:flutter/material.dart';
import 'package:igig/constants.dart';
import 'package:igig/models/prestador.dart';
import 'package:igig/screens/cadastro/components_dados_profissionais/body.dart';

class TelaCadastrarDadosProfissionais extends StatefulWidget {
  static String routeName = "/completar_dados_profissionais";

  TelaCadastrarDadosProfissionais(this.prestador);
  final Prestador prestador;

  @override
  _TelaCadastrarDadosProfissionaisState createState() => _TelaCadastrarDadosProfissionaisState();
}

class _TelaCadastrarDadosProfissionaisState extends State<TelaCadastrarDadosProfissionais> {
  @override
  Widget build(BuildContext context) {
    Prestador prestador = widget.prestador;
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text(""),
        backgroundColor: CONST_COR_PRIMARIA,
        elevation: 5.0,
        brightness: Brightness.dark,
      ),
      backgroundColor: Colors.white,
      body: Body(prestador),
    );
  }
}
