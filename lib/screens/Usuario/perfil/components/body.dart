import 'package:flutter/material.dart';
import 'package:igig/database/database.dart';
import 'package:igig/models/prestador.dart';

import 'package:igig/routes/slide_from_bottom_page_route.dart';
import 'package:igig/screens/Usuario/perfil/components/alterar_senha/alterar_senha.dart';

import 'package:igig/screens/Usuario/perfil/components/dados_pessoais/dados_pessoais.dart';
import 'package:igig/screens/Usuario/perfil/components/dados_profissionais/dados_profissionais.dart';
import 'package:igig/screens/Usuario/perfil/components/endereco/endereco.dart';

class Body extends StatelessWidget {

  Body(this.prestador);
  Prestador prestador;


  @override
  Widget build(BuildContext context) {
    return Container(

      color: Colors.white,
      child: ListView(
        children: [
          ListTile(
            title: Text("Dados Pessoais", style: TextStyle(color: Colors.black, fontSize: 16), ),
            dense: true,
            trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: () =>  Navigator.push(context,SlideFromBottomPageRoute(widget: DadosPessoais(prestador)))
          ),
          Divider(color: Colors.black,),
          ListTile(
            title: Text("Endereço", style: TextStyle(color: Colors.black, fontSize: 16), ),
            dense: true,
            trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: () =>  Navigator.push(context,SlideFromBottomPageRoute(widget: Endereco(prestador)))
          ),
          Divider(color: Colors.black,),
          ListTile(
            title: Text("Dados profissionais", style: TextStyle(color: Colors.black, fontSize: 16), ),
            dense: true,
            trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: () =>  Navigator.push(context,SlideFromBottomPageRoute(widget: DadosProssionais(prestador)))
          ),
          Divider(color: Colors.black,),
          ListTile(
            title: Text("Alterar senha", style: TextStyle(color: Colors.black, fontSize: 16), ),
            dense: true,
            trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: () =>  Navigator.push(context,SlideFromBottomPageRoute(widget: AlterarSenha()))
          ),
          Divider(color: Colors.black,),
        ],
      ),
    );
  }
}
