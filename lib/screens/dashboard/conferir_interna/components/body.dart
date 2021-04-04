import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  _dialogServicoEncontrado(BuildContext context){
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Serviço não confirmado"),
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
        Text(
          'Detalhes da proposta',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 10,),
        Text(
          'Confira todos os dados antes de aceitar esta proposta.',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 20,),
        Text(
          'Serviço ofertado',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CONST_COR_SUBTITULO),
        ),
        SizedBox(height: 5,),
        Text(
          snaps['servico'],
          style: TextStyle(fontSize: 18, color: CONST_COR_PRIMARIA),
        ),
        SizedBox(height: 18,),
        Text(
          'Nome da instituição',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CONST_COR_SUBTITULO),
        ),
        SizedBox(height: 5,),
        Text(
          snaps['instituicao'],
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 18,),
        Text(
          'Valor do plantão',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CONST_COR_SUBTITULO),
        ),
        SizedBox(height: 5,),
        Text(
          'R\$ ' + snaps['valor'].toString(),
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 18,),
        Text(
          'Data do plantão',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CONST_COR_SUBTITULO),
        ),
        SizedBox(height: 5,),
        Text(
          dataInicial,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 18,),
        Text(
          'Horário de chegada',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CONST_COR_SUBTITULO),
        ),
        SizedBox(height: 5,),
        Text(
          horarioChegada + ' da ' + dia_da_semana_chegada,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 18,),
        Text(
          'Horário de saída',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CONST_COR_SUBTITULO),
        ),
        SizedBox(height: 5,),
        Text(
          horarioSaida + ' da ' + dia_da_semana_saida,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 18,),
        Text(
          'Descrição do plantão',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CONST_COR_SUBTITULO),
        ),
        SizedBox(height: 5,),
        Text(
          '',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 28,),
        Container(
          height: 55,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              border: Border.all(color: CONST_COR_PRIMARIA),
              borderRadius: BorderRadius.all(Radius.circular(30))
          ),
          child: SizedBox.expand(
            child: FlatButton(
              child: Text(
                "Solicitar alteração",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: CONST_COR_PRIMARIA
                ),
              ),
              onPressed: () {
                return showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Alterar proposta"),
                    content: Container(
                      height: 240,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.number,
                            onSaved: (newValue) => valorDesejado = newValue,
                            onChanged: (value) { valorDesejado = value;},
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              icon: Icon(Icons.attach_money_rounded),
                              hintText: 'R\$ 1.000,00',
                              labelText: 'Valor desejado',
                            ),
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            onSaved: (newValue) => dataDesejada = newValue,
                            onChanged: (value) { dataDesejada = value;},
                            // obscureText: true,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              icon: Icon(Icons.more_time),
                              labelText: 'Horário',
                            ),
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Mensagem adicional',
                            ),
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancelar"),
                      ),
                      FlatButton(
                        onPressed: () {
                          DatabaseMetodos dbMetodos = new DatabaseMetodos();

                          print(prestador.idFirestore.isEmpty);
                          // FirebaseFirestore db = FirebaseFirestore.instance;
                          // DocumentReference docRefPrestador = db.collection('prestador').doc(prestador.idFirestore);
                          // DocumentReference docRefServico = db.collection('servico').doc(snaps.id);
                          //
                          // var alteracoes = ({'valor':valorDesejado,'turno':dataDesejada});
                          //
                          // dbMetodos.setSolicitacaoServicoComAlteracao(docRefPrestador,docRefServico,alteracoes);
                          //
                          // Navigator.of(context).pop();
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => TelaConfirmarInterna(prestador)));
                        },
                        child: Text("Confirmar"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),

        SizedBox(height: 10,),

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
                "Confirmar proposta",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
              onPressed: (){
                msgError = "";
                return showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Confirmar proposta"),
                    content: Text("Você deseja confirmar a proposta descrita?"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Não"),
                      ),
                      FlatButton(
                        onPressed: () async {

                          var verificacao = await _verificarPropostaPendente(prestador, snaps);

                          if(verificacao == Status.NAOEXISTE){
                            print('salvando serviço');
                            DatabaseMetodos dbMetodos = new DatabaseMetodos();
                            FirebaseFirestore db = FirebaseFirestore.instance;
                            DocumentReference docRefPrestador = db.collection('prestador').doc(prestador.idFirestore);
                            DocumentReference docRefServico = db.collection('servico').doc(snaps.id);

                            dbMetodos.setSolicitacaoServico(docRefPrestador,docRefServico);


                            String titulo = "Proposta enviada com sucesso";
                            String texto = "Agora precisamos esperar a análise da instituição, lembrando, seu plantão não está confirmado, apenas enviamos sua vontade de trabalhar "
                                "para a instituição, agora dependerá dele.";

                            Navigator.of(context).pop();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmarInterna(prestador, titulo, texto)));
                          }else if(verificacao == Status.EXISTE){
                            print('serviço já cadastrado');
                            Navigator.of(context).pop();
                            msgError = "Encontramos uma confirmação deste serviço na sua lista de pendências";
                            _dialogServicoEncontrado(context);
                          } else {
                            print('prestador ou serviço inválido');
                            Navigator.of(context).pop();
                          }

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
