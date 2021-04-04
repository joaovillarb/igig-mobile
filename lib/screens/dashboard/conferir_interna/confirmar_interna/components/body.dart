import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igig/constants.dart';
import 'package:igig/models/prestador.dart';
import 'package:igig/screens/dashboard/home.dart';

class Body extends StatelessWidget {
  Body(this.prestador, this.titulo, this.texto);
  Prestador prestador;
  String titulo;
  String texto;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 22, right: 22),
      child: ListView(
        children: [
          Center(
            child: Icon(
              Icons.check_circle,
              color: Color(0xFF00afd8),
              size: 180.0,
            ),
          ),
          SizedBox(height: 20,),
          Text(
            titulo,
            // "Proposta enviada com sucesso",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 20,),
          Text(
              texto,
              // "Agora precisamos esperar a análise da instituição, lembrando, seu plantão não está confirmado, apenas enviamos sua vontade de trabalhar "
              // "para a instituição, agora dependerá dele.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.black,
                // fontWeight: FontWeight.w400,
              )
          ),
          SizedBox(height: 40,),
          Container(
            height: 55,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: CONST_COR_PRIMARIA,
                borderRadius: BorderRadius.all(Radius.circular(30))
            ),
            child: SizedBox.expand(
              child: FlatButton(
                child: Text(
                  "Continuar",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
                onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home(prestador)));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
