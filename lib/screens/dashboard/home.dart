import 'package:flutter/material.dart';
import 'package:igig/constants.dart';
import 'package:igig/database/database.dart';
import 'package:igig/models/prestador.dart';
import 'package:igig/screens/dashboard/telas/AbaDisponiveis.dart';
import 'package:igig/screens/dashboard/telas/AbaPendentes.dart';
import 'package:igig/widgets.dart';

class Home extends StatefulWidget {
  static const String routeName = "/home";

  Home(this.prestador);
  final Prestador prestador;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  DatabaseMetodos dbMetodos = new DatabaseMetodos();
  TabController _tabController;

  @override
  void initState() {
    setState(() {
      dbMetodos;
    });
    _tabController = TabController(
        length: 2,
        vsync: this
    );
  }

  @override
  Widget build(BuildContext context) {
    Prestador prestador = widget.prestador;
    return Scaffold(
      drawer: GlobalDrawer(prestador: prestador,),
      appBar: AppBar(
        title: Text("Plantões disponíveis"),
        backgroundColor: CONST_COR_PRIMARIA,
        bottom: TabBar(
          indicatorWeight: 4,
          labelStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(child: Text(
                "Disponíveis",
                style: TextStyle(fontSize: 17),
              ),
            ),
            Tab(child: Text(
                "Pendentes",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
        elevation: 5.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Atualizar lista de plantões',
            onPressed: () {
              // scaffoldKey.currentState.showSnackBar(snackBar);
              setState(() {
                dbMetodos;
              });
            },
          ),
        ],
        brightness: Brightness.dark,
      ),
      // body: Body(dbMetodos, _prestador),

      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          AbaDisponiveis(dbMetodos, prestador),
          AbaPendentes(dbMetodos, prestador)
        ],
      ),
    );
  }
}
