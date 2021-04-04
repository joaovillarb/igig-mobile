import 'package:flutter/material.dart';
import 'package:igig/constants.dart';
import 'package:igig/models/prestador.dart';
import 'package:igig/screens/cadastro/components_dados_pessoais/body.dart';

class CadastrarDadosPessoais extends StatefulWidget {
  static const String routeName = "/cadastrar-dados-pessoais";

  CadastrarDadosPessoais(this.prestador);
  final Prestador prestador;

  @override
  _CadastrarDadosPessoaisState createState() => _CadastrarDadosPessoaisState();
}

class _CadastrarDadosPessoaisState extends State<CadastrarDadosPessoais> {
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
