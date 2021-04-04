import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:igig/constants.dart';

import 'package:igig/screens/dashboard/home.dart';


import 'package:igig/screens/cadastro/cadastro_screen.dart';
import 'package:igig/screens/login/components/login_form.dart';
import 'package:igig/screens/login/esqueci_senha/esqueci_senha_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30, left: 40,right: 40),
      child: Center(
        child: ListView(
          children: <Widget>[

            Center(
              child: Text(
                "IGIG",
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 120,
                  fontWeight: FontWeight.bold,
                  color: CONST_COR_PRIMARIA,
                ),
              ),
            ),
            // Image.asset("imagens/logo.png"),

            SizedBox(height: 20),
            LoginForm(),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Não lembra sua senha?"),
                FlatButton(
                  child: Text(
                    "Recuperar",
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, EsqueciSenha.routeName);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Não possui uma conta? "),
                FlatButton(
                  child: Text(
                    "Cadastre-se",
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Cadastro.routeName);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
