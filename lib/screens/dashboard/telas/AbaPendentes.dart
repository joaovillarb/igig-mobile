import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:igig/constants.dart';
import 'package:igig/database/database.dart';
import 'package:igig/models/prestador.dart';
import 'package:igig/models/servicosPendentes.dart';
import 'package:igig/screens/dashboard/conferir_interna/detalhes_da_proposta.dart';
import 'package:igig/screens/dashboard/conferir_interna/detalhes_da_proposta_pendentes.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class AbaPendentes extends StatefulWidget {

  AbaPendentes(this.db, this.prestador);
  DatabaseMetodos db;
  Prestador prestador;

  @override
  _AbaPendentesState createState() => _AbaPendentesState();
}

class _AbaPendentesState extends State<AbaPendentes> {

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  Future _getPendentes(Prestador prestador) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentReference docRefPrestador = db.collection('prestador').doc(prestador.idFirestore);

    QuerySnapshot qn = await db.collection("rel_pend_prestador_servico")
        .where("prestador",isEqualTo: docRefPrestador)
        .orderBy('status',descending: true)
        .get();

    // print(qn);

    print('Pendentes');

    Map<Object, dynamic> _listaServicos = new Map<Object,dynamic>();

    int cont = 0;

    for (DocumentSnapshot item in qn.docs ){
        var dados = item.data();
        print(dados);
        var dadosServico = dados['servico'];
        DocumentSnapshot dsServico = await dadosServico.get();
        _listaServicos[cont.toString()] = {"dados" : dados, "servico" : dsServico};
        cont++;
      }

    print('end Pendentes');

    return _listaServicos;
  }

  Widget _status(status) {
    if (status == 0) {
      return Container(
        color: CONST_COR_PENDENTE,
        width: double.infinity,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0, top: 16.0),
        child: Text(
          'Avaliação pendente',
          style: TextStyle(fontSize: 17, color: CONST_COR_BRANCA, fontWeight: FontWeight.w600),
        ),
      );
    } else if(status == 1) {
      return Container(
        color: CONST_COR_VERDE,
        width: double.infinity,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0, top: 16.0),
        child: Text(
          'Seu plantão foi aprovado',
          style: TextStyle(fontSize: 17, color: CONST_COR_BRANCA, fontWeight: FontWeight.w600),
        ),
      );
    } else if(status == 2){
      return Text("Waiting");
    }
  }

  @override
  Widget build(BuildContext context) {
    var prestador = widget.prestador;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: FutureBuilder(
                future: _getPendentes(prestador),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return new Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, indice) {

                        var dados = snapshot.data[indice.toString()]['servico'];
                        var dadosGerais = snapshot.data[indice.toString()]['dados'];
                        // print(dadosGerais['status']);
                        // String status;
                        // switch(dadosGerais['status']){
                        //   case 0:
                        //     status = 'pendente';
                        //     break;
                        //   case 1:
                        //     status = 'aprovado';
                        //     break;
                        //   case 2:
                        //     status = 'finalizado';
                        //     break;
                        // }

                        String languageCode = Localizations.localeOf(context).languageCode;

                        String dataInicial = DateFormat('dd/MM/yyyy kk:mm').format(dados['dataInicial'].toDate());
                        String dataFinal = DateFormat('dd/MM/yyyy kk:mm').format(dados['dataFinal'].toDate());
                        String expiracaoDia = DateFormat('EEEE, dd', languageCode).format(dados['expiracao'].toDate());
                        String expiracaoMes = DateFormat('MMMM', languageCode).format(dados['expiracao'].toDate());
                        String expiracaoHora = DateFormat('kk:mm').format(dados['expiracao'].toDate());

                        return GestureDetector(
                          onTap: (){
                            // print('clicou ${index}');
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetalhesDaPropostaPendentes(dados,prestador)));
                          },
                          child: Container(
                            // height: 60,
                            margin: EdgeInsets.fromLTRB(15, 0, 15, 8),
                            decoration: BoxDecoration(
                              // gradient: LinearGradient(
                              //   stops: [0.015, 0.015],
                              //   colors: [Colors.purple, Colors.purple],
                              // ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            child: Card(
                              elevation: 2,
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                children: [
                                  _status(dadosGerais['status']),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0, top: 16.0),
                                  //   child: Column(
                                  //     crossAxisAlignment: CrossAxisAlignment.start,
                                  //     children: [
                                  //       Padding(
                                  //         padding: const EdgeInsets.only(left: 2.0, top: 4.0),
                                  //         child: Row(
                                  //           children: [
                                  //             Text(
                                  //               'Pedido ' + status,
                                  //               style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.6)),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),



                                  ListTile(
                                    // leading: Icon(Icons.arrow_drop_down_circle),
                                    title: Text(
                                      // '_asd'
                                        dados['servico']
                                    ),
                                    subtitle: Text(
                                      dados['instituicao'],
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    trailing: Column(
                                      children: [
                                        Text(
                                          'R\$ ' + dados['valor'].toString(),
                                          style: TextStyle(fontSize: 16, color: Colors.green),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0, top: 0.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(padding: EdgeInsets.only(top: 20.0)),
                                            Icon(
                                              Icons.calendar_today_sharp,
                                              color: Colors.black.withOpacity(0.6),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 4.0, right: 8.0),
                                              child: Text(
                                                dataInicial,
                                                style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                              ),
                                            ),
                                            Icon(
                                              Icons.lock_clock,
                                              color: Colors.black.withOpacity(0.6),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 4.0),
                                              child: Text(
                                                dataFinal,
                                                style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 2.0, top: 4.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Expira: ',
                                                style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.6)),
                                              ),
                                              Text(
                                                expiracaoDia + ' de ' + expiracaoMes + ' as ' + expiracaoHora,
                                                style: TextStyle(fontSize: 14, color: Colors.deepOrangeAccent.withOpacity(0.8)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),





                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
            ),
        ),
      ],
    );
  }
}
