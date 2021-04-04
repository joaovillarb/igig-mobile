import 'package:flutter/material.dart';
import 'package:igig/components/default_button.dart';
import 'package:igig/constants.dart';
import 'package:flushbar/flushbar.dart';

import 'componets/body.dart';

class EsqueciSenha extends StatefulWidget {
  static const String routeName = "/esqueci-senha";
  @override
  _EsqueciSenhaState createState() => _EsqueciSenhaState();
}

class _EsqueciSenhaState extends State<EsqueciSenha> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text("Recuperar senha"),
        backgroundColor: CONST_COR_PRIMARIA,
        elevation: 5.0,
        brightness: Brightness.dark,
      ),
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}


