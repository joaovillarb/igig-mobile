
import 'dart:ui';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igig/components/default_button.dart';

import '../../../../smtpmail.dart';


class Body extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  String _email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.only(left: 22, right: 22, top: 22),
          children: [
            Text("Digite seu e-mail",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.5,
                )
            ),
            SizedBox(height: 10),
            emailFormField(),
            SizedBox(height: 30),
            DefaultButton(
              text: "Enviar e-mail",
              press: (){
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  enviarEmail(this._email);
                  showTopSnackBar(context);
                }
              },
            ),
            SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }

  TextFormField emailFormField() {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'email@email.com.br',
        labelText: 'E-mail',
      ),
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        this._email = value;
      },
      validator: _validarEmail,
    );
  }

  String _validarEmail(String value) {
    if (value.isEmpty) {
      return 'Email obrigatório';
    }
    // if (!EmailValidator.validate(value)) {
    //   print('Email inválido!');
    //   return "";
    // }
    return null;
  }

  void showTopSnackBar(BuildContext context) => Flushbar(
    icon: Icon(Icons.check_circle, size:32, color: Colors.white),
    shouldIconPulse: true,
    message: 'Senha foi enviada com êxito',
    duration: Duration(seconds: 2, milliseconds: 500),
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: Colors.green.withOpacity(.80),
  )..show(context);
}
