import 'package:flutter/material.dart';
import 'package:igig/database/database.dart';
import 'package:igig/routes/slide_from_bottom_page_route.dart';
import 'package:igig/screens/dashboard/conferir_interna/detalhes_da_proposta.dart';

class TelaPrincipalCard extends StatefulWidget {
  @override
  _TelaPrincipalCardsState createState() => _TelaPrincipalCardsState();
}

class _TelaPrincipalCardsState extends State<TelaPrincipalCard> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print('clicou em cima');
        print('_lista');
        // Navigator.push(context,SlideFromBottomPageRoute(widget: TelaConferirInterna()));
      },
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              // leading: Icon(Icons.arrow_drop_down_circle),
              title: const Text('Plantão Geriátrico'),
              subtitle: Text(
                'Hospital Esperança',
                style: TextStyle(fontSize: 14),
              ),
              trailing: Column(
                children: [
                  Text(
                    'R\$ 1.000',
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
                          '13/01/2021',
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
                          '08:00 - 12:00',
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
                          'Expira em: ',
                          style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.6)),
                        ),
                        Text(
                          '09:45',
                          style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.6)),
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
    );
  }
}
