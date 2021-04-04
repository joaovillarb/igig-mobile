import 'package:flutter/material.dart';
import 'package:igig/constants.dart';
import 'package:igig/models/prestador.dart';
import 'package:igig/screens/cadastro/components_senha/body.dart';

class CadastrarSenha extends StatefulWidget {
  static String routeName = "/cadastro-senha";

  CadastrarSenha(this.prestador);
  final Prestador prestador;

  @override
  _CadastrarSenhaState createState() => _CadastrarSenhaState();
}

class _CadastrarSenhaState extends State<CadastrarSenha> {
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
