import 'package:flutter/material.dart';
import 'package:igig/database/database.dart';
import 'package:igig/models/prestador.dart';
import 'package:igig/screens/dashboard/conferir_interna/detalhes_da_proposta.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class AbaDisponiveis extends StatefulWidget {

  AbaDisponiveis(this.db, this.prestador);
  DatabaseMetodos db;
  Prestador prestador;

  @override
  _AbaDisponiveisState createState() => _AbaDisponiveisState();
}

class _AbaDisponiveisState extends State<AbaDisponiveis> {

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    var dbMetodos = widget.db;
    var prestador = widget.prestador;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: FutureBuilder(
              future: dbMetodos.getServicos(),
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
                        var dados = snapshot.data[indice];

                        String languageCode = Localizations.localeOf(context).languageCode;

                        String dataInicial = DateFormat('dd/MM/yyyy kk:mm').format(dados['dataInicial'].toDate());
                        String dataFinal = DateFormat('dd/MM/yyyy kk:mm').format(dados['dataFinal'].toDate());
                        String expiracaoDia = DateFormat('EEEE, dd', languageCode).format(dados['expiracao'].toDate());
                        String expiracaoMes = DateFormat('MMMM', languageCode).format(dados['expiracao'].toDate());
                        String expiracaoHora = DateFormat('kk:mm').format(dados['expiracao'].toDate());

                        return GestureDetector(
                              onTap: (){
                                // print('clicou ${index}');
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetalhesDaProposta(dados,prestador)));
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
                                  ListTile(
                                    // leading: Icon(Icons.arrow_drop_down_circle),
                                    title: Text(
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
                      });
                }
              }),
        ),
      ],
    );
  }
}

