import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:igig/components/default_button.dart';
import 'package:igig/components/genericos.dart';
import 'package:igig/components/loading.dart';
import 'package:igig/models/prestador.dart';
import 'package:igig/screens/cadastro/aguardando_validacao.dart';

class Body extends StatefulWidget {

  Body(this.prestador);
  final Prestador prestador;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<FormFieldState<String>> _passwordFieldKey = GlobalKey<FormFieldState<String>>();

  String senha = '';
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  final _formKey = GlobalKey<FormState>();

  // CRIAÇÃO DO USUARIO
  _cadastrar(Prestador prestador, String senha) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    print(prestador.email);
    print(senha);

//PRECISA VERIFICAR SE O EMAIL JA EXISTE

    auth.createUserWithEmailAndPassword(
        email: prestador.email,
        password: senha
    ).then((firebaseUser){

      print('cadastro');
      print(senha);
      print(prestador);

      //Salvar dados do usuário
      FirebaseFirestore db = FirebaseFirestore.instance;

      db.collection("prestador")
          .doc( firebaseUser.user.uid )
          .set( prestador.toMap() );

      prestador.idFirestore = firebaseUser.user.uid;

      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge

      Navigator.pushReplacement(context,
        MaterialPageRoute(
          builder: (context)=> AguardandoValidacao(prestador),
        ),
      );

    }).catchError((error){

      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
      return error.toString();
      // print("erro app: " + error.toString() );
      // setState(() {
      //   _mensagemErro = "Erro ao cadastrar usuário, verifique os campos e tente novamente!";
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    Prestador prestador = widget.prestador;
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 22, right: 22, top: 22),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Por fim...",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          // fontWeight: FontWeight.w400,
                        )
                    ),
                    SizedBox(height:10),
                    Text("Digite sua senha",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        )
                    ),
                    SizedBox(height:20),
                    cadastroSenhaFormField(prestador),
                    SizedBox(height: 20,),
                    DefaultButton(
                      text: "Avançar",
                      press: (){
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          DialogLoading().showLoadingDialog(context, _keyLoader);//invoking login
                          _cadastrar(prestador, senha);
                        }
                      },
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _validateSenha(String value) {
    print('valor: '+value);
    if (value.isEmpty) {
      return 'Instituição obrigatória';
    }
    if (value.length < 8) {
      return 'A senha tem que ter no mínimo 8 caracteres';
    }
    // final nameExp = RegExp(r'^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]+$');
    // if (!nameExp.hasMatch(value)) {
    //   return 'Campo com caracteres inválidos';
    // }
    return null;
  }

  PasswordField cadastroSenhaFormField(Prestador prestador) {
    return PasswordField(
      fieldKey: _passwordFieldKey,
      // helperText:'',
      validator: _validateSenha,
      labelText: 'Senha',
      onSaved: (value) {
        senha = value;
      },
      onFieldSubmitted: (value) {
        setState(() {
          senha = value;
        });
      },
    );
  }
}