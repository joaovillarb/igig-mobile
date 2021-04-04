import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:igig/constants.dart';
import 'package:igig/models/prestador.dart';
import 'package:igig/screens/dashboard/home.dart';
import 'package:igig/screens/login/components/body.dart';


class Login extends StatefulWidget {
  static const String routeName = "/login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _idUsuarioLogado;
  @override
  void initState() {
    _verificarUsuarioLogado();
    super.initState();
  }
  Future _verificarUsuarioLogado() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = auth.currentUser;
    print(usuarioLogado);
    if( usuarioLogado != null ){ // logado
      Prestador prestador = new Prestador();

      _idUsuarioLogado = usuarioLogado.uid;

      FirebaseFirestore db = FirebaseFirestore.instance;
      DocumentSnapshot snapshot = await db.collection("prestador")
          .doc( _idUsuarioLogado )
          .get();

      if(snapshot == null || !snapshot.exists){
        return "Prestador não encontrado";
      }

      Map<String, dynamic> dados = snapshot.data();

      //pessoal
      prestador.cpf                 = dados['cpf'];
      prestador.nome                = dados['nome'];
      prestador.dataNasc            = dados['data de nascimento'];
      prestador.telefone            = dados['telefone'];
      prestador.genero              = dados['genero'];
      prestador.email               = dados['email'];

      //endereço
      prestador.cep                 = dados['cep'];
      prestador.endereco            = dados['endereco'];
      prestador.cidade              = dados['cidade'];
      prestador.uf                  = dados['uf'];
      prestador.bairro              = dados['bairro'];
      prestador.numero              = dados['numero'];
      prestador.complemento         = dados['complemento'];

      //profissional
      prestador.cremepe             = dados['cremepe'];
      prestador.conselho            = dados['conselho'];
      prestador.categoria           = dados['categoria'];
      prestador.especialidade       = dados['especialidade'];

      prestador.status              = dados['status'];
      prestador.idFirestore         = _idUsuarioLogado;

      print('=========================');
      if(prestador.status){
        print(_idUsuarioLogado );
        print(prestador.idFirestore );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(prestador)));
      }else {
        auth.signOut();
        print('Usuario deslogado com sucesso' );
      }
      print('=========================');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0.0),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: CONST_COR_PRIMARIA,
            )
        ),
      body: Body(),
    );
  }
}
