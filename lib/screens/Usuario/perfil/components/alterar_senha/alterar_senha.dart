import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igig/components/default_button.dart';
import 'package:igig/constants.dart';

class AlterarSenha extends StatefulWidget {
  static const String routeName = "/alterar-senha";
  @override
  _AlterarSenhaState createState() => _AlterarSenhaState();
}

class _AlterarSenhaState extends State<AlterarSenha> {

  final _formKey = GlobalKey<FormState>();
  String _senhaNova;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text("Alterar senha",),
        centerTitle: true,
        backgroundColor: CONST_COR_PRIMARIA,
        elevation: 5.0,
        brightness: Brightness.dark,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(left: 22, right: 22, top: 22),
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Senha antiga',
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Nova senha',
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Confirmar senha',
                    ),
                  ),
                  SizedBox(height: 20,),
                  DefaultButton(
                    text: "Avançar",
                    press: (){
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

                        final FirebaseAuth auth = FirebaseAuth.instance;
                        User user = auth.currentUser;

                        user.updatePassword(_senhaNova).then((_){
                          print("Senha trocada com sucesso");
                          showTopSnackBar(context);
                        }).catchError((error){
                          print("A senha não pôde ser alterada " + error.toString());
                        });

                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void showTopSnackBar(BuildContext context) => Flushbar(
    icon: Icon(Icons.check_circle, size:32, color: Colors.white),
    shouldIconPulse: true,
    message: 'Dados Salvos',
    duration: Duration(seconds: 2, milliseconds: 500),
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: Colors.green.withOpacity(.80),
  )..show(context);
}
