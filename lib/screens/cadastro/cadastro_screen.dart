import 'package:flutter/material.dart';
import 'package:igig/constants.dart';
import 'package:igig/screens/cadastro/components/body.dart';

class Cadastro extends StatefulWidget {
  static const String routeName = "/cadastro";
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text(""),
        backgroundColor: CONST_COR_PRIMARIA,
        elevation: 5.0,
        brightness: Brightness.dark,
      ),
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}
