import 'package:flutter/material.dart';
import 'package:igig/constants.dart';
import 'package:igig/models/prestador.dart';
import 'package:igig/screens/dashboard/conferir_interna/components_pendentes/body.dart';

class DetalhesDaPropostaPendentes extends StatefulWidget {
  static const String routeName = "/conferir-interna-pendentes";

  DetalhesDaPropostaPendentes(this.snaps, this.prestador);
  var snaps;
  Prestador prestador;

  @override
  _DetalhesDaPropostaPendentesState createState() => _DetalhesDaPropostaPendentesState();
}

class _DetalhesDaPropostaPendentesState extends State<DetalhesDaPropostaPendentes> {

  @override
  Widget build(BuildContext context) {
    var dados = widget.snaps;
    var _prestador = widget.prestador;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text("DETALHES DA PROPOSTA", style: TextStyle(color: Colors.black.withOpacity(0.45), fontSize: 15 ),),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          iconSize: 19,
          // color: Colors.black.withOpacity(0.45),
          color: CONST_COR_PRIMARIA,
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
