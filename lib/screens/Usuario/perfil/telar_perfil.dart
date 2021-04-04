



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:igig/constants.dart';
import 'package:igig/database/database.dart';

import 'package:igig/models/prestador.dart';

import 'package:igig/screens/Usuario/perfil/components/body.dart';



class Perfil extends StatefulWidget {
  static const String routeName = "/perfil";

  Perfil(this.prestador);
  Prestador prestador;

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {

  @override
  Widget build(BuildContext context) {
    Prestador prestador = widget.prestador;
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Perfil"),
        backgroundColor: CONST_COR_PRIMARIA,
        elevation: 5.0,
        brightness: Brightness.dark,
      ),
      body: Body(prestador),
    );
  }
}
