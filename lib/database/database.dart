import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:igig/models/prestador.dart';
import 'package:igig/models/user.dart';

enum StatusSolicitacao {
  Pendente,
  Aprovado,
  Finalizado
}

class DatabaseMetodos {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  UsuarioAtual _usuarioLogadoNoFirebase(User user) {
    return user != null ? UsuarioAtual(userId: user.uid) : null;
  }

  // ATUALIZAÇÃO DO USUARIO
  atualizarInformacoesPrestador(String cpf, {String email, String senha , String nome}) async {
    try {
      // print(recuperarPrestadorPorCpf(cpf));
      var buscaPrestador = await recuperarInformacoesPrestador(cpf);
      //AINDA FALTA MELHORAR ESSA FUNÇÃO!
      // nome = 'teste';
      // email = 'email@email.com.br';
      // senha = '1234567';
      db.collection('prestador').doc(buscaPrestador['id']).set({"cpf" : cpf, "nome" : nome, "email" : email, "senha" : senha});
      print('Prestador alterado com sucesso!');
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // recuperarPrestadorPorCpf(String cpf) async {
  //   return await db.collection("prestador")
  //       .where("cpf", isEqualTo: cpf)
  //       .get();
  // }
  // RECUPERAR O USUARIO
  recuperarInformacoesPrestador(String cpf) async {
    try {
      QuerySnapshot querySnapshot = await db.collection('prestador').get();
      // print('dados: ' + querySnapshot.docs.toString());
      for (DocumentSnapshot item in querySnapshot.docs ){
        var dados = item.data();
        var id = item.id;
        if(dados['cpf'] == cpf){
          var retorno = {'id':id,'dados':dados};
          print('Prestador encontrado: ' + id);
          return await retorno;
        }
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  recuperarInformacoesPrestadorEmail(String email) async {
    try {
      QuerySnapshot querySnapshot = await db.collection('prestador').get();
      // print('dados: ' + querySnapshot.docs.toString());
      for (DocumentSnapshot item in querySnapshot.docs ){
        var dados = item.data();
        var id = item.id;
        if(dados['email'] == email){
          var retorno = {'id':id,'dados':dados};
          print('Prestador encontrado: ' + id);
          return await retorno;
        }
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // // ATUALIZAÇÃO DO USUARIO
  // Future logarUsuario(String cpf, String senha) async {
  //   try {
  //     // print(recuperarPrestadorPorCpf(cpf));
  //     var buscaPrestador = await recuperarInformacoesPrestador(cpf);
  //
  //     if(buscaPrestador['id'] == null){
  //       return "Cpf não encontrado";
  //     }
  //
  //     String email = buscaPrestador['dados']['email'];
  //
  //     await auth.signInWithEmailAndPassword(email: email, password: senha);
  //
  //     print("Novo usuario: sucesso!! e-mail: " + email.toString());
  //     return "sucesso";
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  Future logarUsuario(Prestador prestador,cpf,senha) async {
    try {
      print(senha);
      print(cpf);
      print(prestador);
      // print(recuperarPrestadorPorCpf(cpf));
      var buscaPrestador = await recuperarInformacoesPrestador(cpf);

      if(buscaPrestador['id'] == null){
        return "CPF não encontrado";
      }

      print(await buscaPrestador['dados']);
      if(prestador.cpf == null ){
        prestador.cpf               = buscaPrestador['dados']['cpf'];
      }
      prestador.nome              = buscaPrestador['dados']['nome'];
      prestador.email             = buscaPrestador['dados']['email'];

      prestador.idFirestore         = buscaPrestador['id'];
      print('=========================');
      print(buscaPrestador['id'] );
      print(prestador.idFirestore );
      print('=========================');

      String email = buscaPrestador['dados']['email'];

      print("E-mail: " + prestador.email );
      print('senha: ' + senha);
      await auth.signInWithEmailAndPassword(email: email, password: senha);

      return await true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future usuarioLogado() async {
    User usuarioLogado = await auth.currentUser;
    if( usuarioLogado != null ){ // logado
        print("Usuario logado: ");
        return usuarioLogado;
    } else { //deslogado
      print("Sem usuario logado");
      return null;
    }
  }

  Future deslogarPrestador() async {
    if(usuarioLogado() != null){
      return await auth.signOut();
    } else {
      return null;
    }
  }

  Future getServicos() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot qn = await db.collection("servico").orderBy('dataInicial').get();
    return qn.docs;
  }

  Future getPendencias(Prestador prestador) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot qn = await db.collection("rel_pend_prestador_servico").get();
    return qn.docs;
  }

  Future getHistorico(Prestador prestador) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot qn = await db.collection("rel_prestador_servico").get();

    Map<Object, dynamic> _listaServicos = new Map<Object,dynamic>();

    int cont = 0;

    for (DocumentSnapshot item in qn.docs ){
      var dados = item.data();
      print(dados);
      var contains = item.id.contains(prestador.idFirestore);
      if( contains ){
        DocumentSnapshot dsServico = await dados['servico'].get();
        _listaServicos[cont.toString()] = dsServico;
        cont++;
      }
    }
    return _listaServicos;
  }

  Future getSolicitacaoServico() async {
    DocumentSnapshot snapshot = await db.collection('rel_pend_prestador_servico').doc('QUBkrVFYGOaCaJy3Z7mC').get();

    var dadosServico = snapshot.data()['servico'];
    DocumentSnapshot dsServico = await dadosServico.get();

    var dadosPrestador = snapshot.data()['prestador'];
    DocumentSnapshot dsPrestador = await dadosPrestador.get();

    print('Prestador: ' + dsPrestador.data()['nome'] + ' Servico: ' + dsServico.data()['servico']);
  }

  Future setSolicitacaoServico(DocumentReference refPrestador, DocumentReference refServico) async {
    // DocumentReference cadastro = await db.collection('rel_pend_prestador_servico').add({"prestador" : refPrestador, "servico" : refServico, 'alterado':false});

    db.collection('rel_pend_prestador_servico').doc(refPrestador.id+';'+refServico.id).set({"prestador" : refPrestador, "servico" : refServico, 'alterado':false, "status" : StatusSolicitacao.Pendente.index});

    print('pendencia salva');
  }

  Future setSolicitacaoServicoComAlteracao(DocumentReference refPrestador, DocumentReference refServico, var alterado) async {
    DocumentReference cadastro = await db.collection('rel_pend_prestador_servico').add({"prestador" : refPrestador, "servico" : refServico, 'alterado':alterado});
    print('item salvo: ' + cadastro.id);
  }
// //RECUPERAR MAIS DE 1 ITEM
// QuerySnapshot querySnapshot = await db.collection('usuarios').get();
// // print('dados: ' + querySnapshot.docs.toString());
// for (DocumentSnapshot item in querySnapshot.docs ){
//   var dados = item.data();
//   print('dados usuarios: ' + dados.toString());
// }


  // // VERIFICAR QUEM TA LOGADO
  // _auth.signOut();
  // _auth.signInWithEmailAndPassword(
  //     email: email, password: senha
  // ).then(
  //         (User) => print("Logar usuario: sucesso!! e-mail: " + User.toString())
  // ).catchError((erro){
  //   print("Logar usuario: erro " + erro.toString());
  // });
  //
  // User usuarioAtual = await _auth.currentUser;
  //
  // if( usuarioAtual != null ){ // logado
  //   print("Usuario logado: "+ email);
  // } else { //deslogado
  //   print("Sem usuario logado");
  // }

// //AUTENTICAÇÃO DO PRESTADOR
// try {
//   UserCredential result = await _auth.createUserWithEmailAndPassword(
//       email: email,
//       password: senha
//   );
//   User user = result.user;
//   return _usuarioDoFirebase(user);
// } catch (e) {
//   print(e.toString());
//   return null;
// }

}

class HelperFunctions {
  static Future<void> saveUserNamePreference(String userName) async {
    // prefs.setString(sharedPreferenceUserNameKey, userName);
  }
}