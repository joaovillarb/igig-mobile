import 'package:flutter/material.dart';
import 'package:igig/constants.dart';
import 'package:igig/database/database.dart';
import 'package:igig/models/prestador.dart';
import 'package:igig/screens/dashboard/historico/components/AbaHistorico.dart';


class Historico extends StatefulWidget {
  static String routeName = "/historico";

  Historico(this.prestador);
  final Prestador prestador;

  @override
  _HistoricoState createState() => _HistoricoState();
}

class _HistoricoState extends State<Historico> {

  DatabaseMetodos dbMetodos = new DatabaseMetodos();

  @override
  void initState() {
    setState(() {
      dbMetodos;
    });
  }

  @override
  Widget build(BuildContext context) {
    Prestador prestador = widget.prestador;
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text("Plantões realizados"),
        backgroundColor: CONST_COR_PRIMARIA,
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
        elevation: 5.0,
        brightness: Brightness.dark,
      ),
      backgroundColor: Colors.white,
      body: AbaHistorico(dbMetodos, prestador),
    );
  }
}
