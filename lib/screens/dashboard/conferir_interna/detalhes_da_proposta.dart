import 'package:flutter/material.dart';
import 'package:igig/models/prestador.dart';
import 'package:igig/screens/dashboard/conferir_interna/components/body.dart';

class DetalhesDaProposta extends StatefulWidget {
  static const String routeName = "/conferir-interna";

  DetalhesDaProposta(this.snaps, this.prestador);
  var snaps;
  Prestador prestador;

  @override
  _DetalhesDaPropostaState createState() => _DetalhesDaPropostaState();
}

class _DetalhesDaPropostaState extends State<DetalhesDaProposta> {

  @override
  Widget build(BuildContext context) {
    var dados = widget.snaps;
    var _prestador = widget.prestador;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          iconSize: 19,
          color: Colors.black.withOpacity(0.45),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        brightness: Brightness.dark,
      ),
      backgroundColor: Colors.white,
      body: Body(dados,_prestador),
    );
  }
}
