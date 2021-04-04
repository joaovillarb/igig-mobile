import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:igig/database/database.dart';
import 'package:igig/models/prestador.dart';

import 'package:igig/screens/Usuario/perfil/telar_perfil.dart';
import 'package:igig/screens/dashboard/historico/historico.dart';
import 'package:igig/screens/dashboard/home.dart';
import 'package:igig/screens/login/login_screen.dart';

class GlobalDrawer extends StatefulWidget {

  GlobalDrawer({this.prestador});
  final Prestador prestador;

  @override
  _GlobalDrawerState createState() => _GlobalDrawerState();
}

class _GlobalDrawerState extends State<GlobalDrawer> {
  @override
  Widget build(BuildContext context) {
    Prestador prestador = widget.prestador;
    print(prestador.toString());
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 170.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-1.0, 0.0),
                end: Alignment(1.0, 0.0),
                colors: [const Color(0xFF006fa4), const Color(0xFF047bb4)],
              ),
            ),
            child: DrawerHeader(
              child: Column(
                children: [
                  Align(
                    alignment: FractionalOffset.centerLeft,
                    child: Text(
                      'Olá, '+ prestador.nome,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Icon(Icons.person,color: Colors.white,size: 80,)),
                      margin: EdgeInsets.only(
                        top: 15.0,
                      ),
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // image: DecorationImage(
                        //   fit: BoxFit.fill,
                        //   image: ExactAssetImage("imagens/desgraca.png"),
                        // ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            // onTap: () => Navigator.pushNamed(context, TelaUsuarioInicial.routeName),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(prestador))),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Perfil(prestador))),
          ),
          // ExpansionTile(
          //   leading: Icon(Icons.mood),
          //   title: Text("Notificacoes"),
          // ),
          ListTile(
            leading: Icon(Icons.article_rounded),
            title: Text('Meus plantoes'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Historico(prestador))),
          ),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Suporte'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              DatabaseMetodos dbMetodos = new DatabaseMetodos();
              dbMetodos.deslogarPrestador();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
              },
          ),
        ],
      ),
    );
  }
}
