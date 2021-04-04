import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:igig/components/default_button.dart';
import 'package:igig/constants.dart';
import 'package:igig/database/database.dart';
import 'package:igig/models/prestador.dart';
import 'package:igig/models/user.dart';
import 'package:igig/screens/dashboard/conferir_interna/confirmar_interna/confirmar_interna_screen.dart';
import 'package:igig/screens/dashboard/home.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

enum Status {
  INVALIDO,
  EXISTE,
  NAOEXISTE
}

class Body extends StatelessWidget {
  Body(this.snaps, this.prestador);
  var snaps;
  Prestador prestador;

  String valorDesejado;
  String dataDesejada;

  String msgError = "";

  @override
  void initState() {
    initializeDateFormatting();
  }


  Future<Status> _verificarPropostaPendente(Prestador prestador, var servico) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    if(prestador == null && prestador.idFirestore.isEmpty && servico == null){
      return Status.INVALIDO;
    }

    DocumentSnapshot snapshot = await db.collection('rel_pend_prestador_servico').doc(prestador.idFirestore+';'+servico.id).get();

    if(snapshot.exists){
      print(snapshot.exists);
      return Status.EXISTE;
    }

    return Status.NAOEXISTE;
  }

  _dialogServicoEncontrado(BuildContext context, String titulo){
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(titulo),
        content: Text(msgError),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    String languageCode = Localizations.localeOf(context).languageCode;

    String dataInicial = DateFormat('dd/MM/yyyy').format(snaps['dataInicial'].toDate());
    String horarioChegada = DateFormat('kk:mm').format(snaps['dataInicial'].toDate());
    String dia_da_semana_chegada = DateFormat('EEEE (dd)', languageCode).format(snaps['dataInicial'].toDate());
    String horarioSaida = DateFormat('kk:mm').format(snaps['dataFinal'].toDate());
    String dia_da_semana_saida = DateFormat('EEEE (dd)', languageCode).format(snaps['dataFinal'].toDate());
    String expiracaoDia = DateFormat('EEEE, dd', languageCode).format(snaps['expiracao'].toDate());
    String expiracaoMes = DateFormat('MMMM', languageCode).format(snaps['expiracao'].toDate());
    String expiracaoHora = DateFormat('kk:mm').format(snaps['expiracao'].toDate());

    return ListView(
      padding: const EdgeInsets.only(top: 0, left: 22, right: 22),
      children: [
        // Text(
        //   'Nome da instituição',
        //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CONST_COR_SUBTITULO),
        // ),
        Text(
          snaps['instituicao'],
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 15,),
        // Text(
        //   'Detalhes da proposta',
        //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        // ),
        // SizedBox(height: 10,),
        // Text(
        //   'Confira todos os dados.',
        //   style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
        // ),
        // SizedBox(height: 20,),
        Text(
          'Serviço ofertado',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CONST_COR_SUBTITULO),
        ),
        SizedBox(height: 5,),
        Row(
          children: [
            Text(
              snaps['servico'],
              style: TextStyle(fontSize: 18, color: CONST_COR_PRIMARIA),
            ),
            Spacer(),
            Text(
              'R\$ ' + snaps['valor'].toString(),
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
          ],
        ),
        // SizedBox(height: 18,),
        // Text(
        //   'Nome da instituição',
        //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CONST_COR_SUBTITULO),
        // ),
        // SizedBox(height: 5,),
        // Text(
        //   snaps['instituicao'],
        //   style: TextStyle(fontSize: 18),
        // ),
        // SizedBox(height: 18,),
        // Text(
        //   'Valor do plantão',
        //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CONST_COR_SUBTITULO),
        // ),
        // SizedBox(height: 5,),
        // Text(
        //   'R\$ ' + snaps['valor'].toString(),
        //   style: TextStyle(fontSize: 18),
        // ),
        SizedBox(height: 15,),
        Text(
          'Data do plantão',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CONST_COR_SUBTITULO),
        ),
        SizedBox(height: 5,),
        Text(
          dataInicial,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 15,),
        Text(
          'Horário de chegada',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CONST_COR_SUBTITULO),
        ),
        SizedBox(height: 5,),
        Text(
          horarioChegada + ' da ' + dia_da_semana_chegada,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 15,),
        Text(
          'Horário de saída',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CONST_COR_SUBTITULO),
        ),
        SizedBox(height: 5,),
        Text(
          horarioSaida + ' da ' + dia_da_semana_saida,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 15,),
        Text(
          'Descrição do plantão',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CONST_COR_SUBTITULO),
        ),
        SizedBox(height: 5,),
        Text(
          '',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 25,),
        Container(
          height: 55,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(30))
          ),
          child: SizedBox.expand(
            child: FlatButton(
              child: Text(
                "Cancelar proposta",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
              onPressed: (){
                msgError = "";
                return showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Cancelar proposta"),
                    content: Text("Você deseja cancelar a proposta descrita?"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Não"),
                      ),
                      FlatButton(
                        onPressed: () async {
                            print('cancelando serviço');

                            FirebaseFirestore db = FirebaseFirestore.instance;

                            db.collection('rel_pend_prestador_servico').doc((prestador.idFirestore+';'+snaps.id)).delete().then((value) {
                              String titulo = "Proposta cancelada com sucesso";
                              String texto = "Sua solicitação foi cancelada com sucesso.";
                              Navigator.of(context).pop();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmarInterna(prestador,titulo,texto)));
                            }).catchError((error){
                              Navigator.of(context).pop();
                              msgError = error.toString();
                              _dialogServicoEncontrado(context,"Error");
                            });
                        },
                        child: Text("Sim"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],

    );
  }
}
