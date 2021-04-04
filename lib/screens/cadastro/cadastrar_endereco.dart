import 'package:flutter/material.dart';
import 'package:igig/constants.dart';
import 'package:igig/models/prestador.dart';
import 'package:igig/screens/cadastro/components_endereco/body.dart';

class TelaCadastrarEndereco extends StatefulWidget {
  static String routeName = "/completar_dados";

  TelaCadastrarEndereco(this.prestador);
  final Prestador prestador;

  @override
  _TelaCadastrarEnderecoState createState() => _TelaCadastrarEnderecoState();
}

class _TelaCadastrarEnderecoState extends State<TelaCadastrarEndereco> {
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
