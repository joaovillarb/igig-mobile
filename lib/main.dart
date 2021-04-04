import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igig/routes/RouteGenerator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async{
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();

      // runApp(MaterialApp(home: App(),));

    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plantão Medico',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      // home: TelaInicial(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    ));
}

class App extends StatelessWidget {

  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          child: FlatButton(
            color: Colors.blue,
              onPressed: () async {
            // collectionReference.add(user);
            //   db.collection('usuarios').doc('002').set({"carlos" : "180", "pedro" : "200"});
                //INSERIR
              // DocumentReference ref = await db.collection('usuarios').add({"carlos" : "180", "pedro" : "200"});
              //   print('item salvo: ' + ref.id);

                // ATUALIZAR
                // db.collection('usuarios').doc('UbHXsw1L8hlG8ZPlX3Dr').set({"Teste atualização" : "Atualizado com sucesso!"});

                //REMOVER
                // db.collection('usuarios').doc('001').delete() ;

                // //RECUPERAR 1 UNICO ITEM
                DocumentSnapshot snapshot = await db.collection('rel_pend_prestador_servico').doc('VqyEv7sjMiZXKRTAUpl0').get();
                var dados = snapshot.data();
                print(dados);
                DocumentSnapshot snapshot2 = await db.collection('rel_pend_prestador_servico').doc('QUBkrVFYGOaCaJy3Z7mC').get();

                var dadosServico = snapshot2.data()['servico'];
                DocumentSnapshot dsServico = await dadosServico.get();

                var dadosPrestador = snapshot2.data()['prestador'];
                DocumentSnapshot dsPrestador = await dadosPrestador.get();

                print('Prestador: ' + dsPrestador.data()['nome'] + ' Servico: ' + dsServico.data()['servico']);
                //
                // DocumentSnapshot snapshot2 = await db.collection('usuarios').doc('001').get() ;
                // print('dados: ' + snapshot2.data().toString());
                //
                // //RECUPERAR MAIS DE 1 ITEM
                // QuerySnapshot querySnapshot = await db.collection('usuarios').get();
                // // print('dados: ' + querySnapshot.docs.toString());
                // for (DocumentSnapshot item in querySnapshot.docs ){
                //   var dados = item.data();
                //   print('dados usuarios: ' + dados.toString());
                // }

                // AVISAR QUANDO OS DADOS FOREM ALTERADOS
                // QuerySnapshot querySnapshotListen = await
                // db.collection('usuarios').snapshots().listen((event) {
                //     for (DocumentSnapshot item in event.docs ){
                //       var dados = item.data();
                //       print('dados usuarios: ' + dados.toString());
                //     }
                // });

                // FirebaseAuth auth = FirebaseAuth.instance;
                // String email = "joaovillar@gmail.com";
                // String senha = "123456";

                //CRIAÇÃO DO USUARIO
                // auth.createUserWithEmailAndPassword(
                //     email: email,
                //     password: senha
                // ).then(
                //         (User) => print("Novo usuario: sucesso!! e-mail: " + User.toString())
                // ).catchError((erro){
                //   print("Novo usuario: erro " + erro.toString());
                // });

                // VERIFICAR QUEM TA LOGADO
                // auth.signOut();
                // auth.signInWithEmailAndPassword(
                //     email: email, password: senha
                // ).then(
                //         (User) => print("Logar usuario: sucesso!! e-mail: " + User.toString())
                // ).catchError((erro){
                //   print("Logar usuario: erro " + erro.toString());
                // });
                //
                // User usuarioAtual = await auth.currentUser;
                //
                // if( usuarioAtual != null ){ // logado
                //   print("Usuario logado: "+ email);
                // } else { //deslogado
                //   print("Sem usuario logado");
                // }

              }, child: Text("teste")
          ),
        )

      ),
    );
  }
}



