import 'package:flutter/material.dart';
import 'package:igig/models/prestador.dart';
import 'package:igig/screens/dashboard/conferir_interna/confirmar_interna/components/body.dart';
import 'package:igig/screens/dashboard/home.dart';

class ConfirmarInterna extends StatefulWidget {
  static const String routeName = "/confirmar-interna";

  ConfirmarInterna(this.prestador,this.titulo, this.texto);
  Prestador prestador;
  String titulo;
  String texto;

  @override
  _ConfirmarInternaState createState() => _ConfirmarInternaState();
}

class _ConfirmarInternaState extends State<ConfirmarInterna> {
  @override
  Widget build(BuildContext context) {
    Prestador prestador = widget.prestador;
    String titulo = widget.titulo;
    String texto = widget.texto;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        // leading: IconButton(
        //   icon: const Icon(Icons.close),
        //   iconSize: 19,
        //   color: Colors.black.withOpacity(0.45),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //     Navigator.push(context, MaterialPageRoute(builder: (context) => Home(prestador)));
        //   },
        // ),
        elevation: 0,
        brightness: Brightness.dark,
      ),
      backgroundColor: Colors.white,
      body: Body(prestador,titulo,texto),
    );
  }
}
