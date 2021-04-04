import 'package:flutter/material.dart';
import 'package:igig/constants.dart';
import 'package:igig/models/prestador.dart';
import 'package:igig/screens/cadastro/components_aguardando_validacao/body.dart';
import 'package:igig/screens/dashboard/home.dart';
import 'package:igig/screens/login/login_screen.dart';

class AguardandoValidacao extends StatefulWidget {
  static const String routeName = "/aguardando-validacao-mensagem";

  AguardandoValidacao(this.prestador);
  final Prestador prestador;

  @override
  _AguardandoValidacaoState createState() => _AguardandoValidacaoState();
}

class _AguardandoValidacaoState extends State<AguardandoValidacao> {
  @override
  Widget build(BuildContext context) {
    Prestador prestador = widget.prestador;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Aguardando validação",),
        centerTitle: true,
        backgroundColor: CONST_COR_PRIMARIA,
        elevation: 5.0,
        brightness: Brightness.dark,
      ),
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}
