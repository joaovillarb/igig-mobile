import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:igig/components/default_button.dart';
import 'package:igig/components/form_error.dart';
import 'package:igig/components/genericos.dart';
import 'package:igig/components/loading.dart';
import 'package:igig/database/database.dart';
import 'package:igig/models/prestador.dart';
import 'package:igig/models/user.dart';
import 'package:igig/screens/dashboard/home.dart';
import 'package:igig/screens/login/esqueci_senha/esqueci_senha_screen.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../constants.dart';


class LoginForm extends StatefulWidget {
  @override
  _FormLoginState createState() => _FormLoginState();
}

class LoginData {
  String cpf = '';
  String senha = '';
}

class _FormLoginState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey = GlobalKey<FormFieldState<String>>();
  String cpf;
  String senha;
  bool remember = false;
  final List<String> errors = [];
  LoginData login = LoginData();

  String _idUsuarioLogado;

  DatabaseMetodos dbMetodos = new DatabaseMetodos();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  Future<void> _submit() async {
    final form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidateMode = AutovalidateMode.always; // Start validating on every change.
      // showInSnackBar('GalleryLocalizations.of(context).demoTextFieldFormErrors',);
    } else {
      form.save();
      print('logando...');
      DialogLoading().showLoadingDialog(context, _keyLoader);//invoking login
      Prestador prestador = new Prestador(cpf: login.cpf);

      final FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;

      QuerySnapshot querySnapshot = await db.collection('prestador').get();

      var retorno;

      for (DocumentSnapshot item in querySnapshot.docs ){
        var dados = item.data();
        var id = item.id;
        if(dados['cpf'] == prestador.cpf){
          retorno = {'id':id,'dados':dados};
          print('Prestador encontrado: ' + id);
          break;
        }
      }

      if(retorno == null){
        Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Prestador não encontrado"),
            content: Text('CPF não encontrado em nossa base de dados'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Entendi", style: TextStyle(color: CONST_COR_PRIMARIA),),
              ),
            ],
          ),
        );
      }

      String _uid = retorno['id'];
      Map<String, dynamic> dados = retorno['dados'];

      //pessoal
      prestador.cpf                 = dados['cpf'];
      prestador.nome                = dados['nome'];
      prestador.dataNasc            = dados['data de nascimento'];
      prestador.telefone            = dados['telefone'];
      prestador.genero              = dados['genero'];
      prestador.email               = dados['email'];

      //endereço
      prestador.cep                 = dados['cep'];
      prestador.endereco            = dados['endereco'];
      prestador.cidade              = dados['cidade'];
      prestador.uf                  = dados['uf'];
      prestador.bairro              = dados['bairro'];
      prestador.numero              = dados['numero'];
      prestador.complemento         = dados['complemento'];

      //profissional
      prestador.cremepe             = dados['cremepe'];
      prestador.conselho            = dados['conselho'];
      prestador.categoria           = dados['categoria'];
      prestador.especialidade       = dados['especialidade'];

      prestador.status              = dados['status'];
      prestador.idFirestore         = _uid;

      // print(prestador);
      print('=========================');
      if(prestador.status){
        auth.signInWithEmailAndPassword(email: prestador.email, password: login.senha)
            .then((firebaseUser) {
          Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(prestador)));
        })
        .catchError((error) {
          Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
          return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Prestador não autenticado"),
              content: Text(error.toString()),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Entendi", style: TextStyle(color: CONST_COR_PRIMARIA),),
                ),
              ],
            ),
          );
        });
      }else{
        print('Conta não validada - status = false');
        Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Conta não validada"),
            content: Text('Sua conta ainda não foi validada pelo RH da instituição, caso demore mais que 72H, entrar em contato com a empresa.'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Entendi", style: TextStyle(color: CONST_COR_PRIMARIA),),
              ),
            ],
          ),
        );
      }
      print('=========================');

      // showInSnackBar('GalleryLocalizations.of(context).demoTextFieldNameHasPhoneNumber(person.name, person.phoneNumber)');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // CircularProgressIndicator(),
          cpfFormField(),
          SizedBox(height: 30),
          senhaFormField(),
          SizedBox(height: 20),
          DefaultButton(
            text: "Login",
            press: () {
              _submit();
            },
          ),
          // SizedBox(height: 30),
          // GestureDetector(
          //   onTap: () => Navigator.pushNamed(context, EsqueciSenha.routeName),
          //   child: Text(
          //     "Esqueci minha senha",
          //     style: TextStyle(decoration: TextDecoration.underline),
          //   ),
          // ),
          // Row(
          //   children: [
          //     // Checkbox(
          //     //   value: remember,
          //     //   activeColor: CONST_COR_PRIMARIA,
          //     //   onChanged: (value) {
          //     //     setState(() {
          //     //       remember = value;
          //     //     });
          //     //   },
          //     // ),
          //     // Text("Lembrar-me"),
          //     // Spacer(),
          //     GestureDetector(
          //       onTap: () => Navigator.pushNamed(context, EsqueciSenha.routeName),
          //       child: Text(
          //         "Esqueci minha senha",
          //         style: TextStyle(decoration: TextDecoration.underline),
          //       ),
          //     ),
          //   ],
          // ),
          FormError(errors: errors),
        ],
      ),
    );
  }

  TextFormField cpfFormField() {
    return TextFormField(
      maxLength: 14,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: '000.000.000-00',
        labelText: 'CPF',
      ),
      onSaved: (value) {
        login.cpf = value;
      },
      initialValue: login.cpf.toString(),
      validator: _validateCpf,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        // Fit the validating format.
        CpfInputFormatter(),
      ],
    );
  }

  String _validateCpf(String value) {
    if (value.isEmpty) {
      return 'Cpf obrigatório';
    }
    // final nameExp = RegExp(r'^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]+$');
    // if (!nameExp.hasMatch(value)) {
    //   return 'Campo com caracteres inválidos';
    // }
    return null;
  }

  String _validateSenha(String value) {
    print('valor: '+value);
    if (value.isEmpty) {
      return 'Instituição obrigatória';
    }
    if (value.length < 8) {
      return 'A senha tem que ter no mínimo 8 caracteres';
    }
    // final nameExp = RegExp(r'^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]+$');
    // if (!nameExp.hasMatch(value)) {
    //   return 'Campo com caracteres inválidos';
    // }
    return null;
  }

  PasswordField senhaFormField() {
    return PasswordField(
      fieldKey: _passwordFieldKey,
      // helperText:'',
      validator: _validateSenha,
      labelText: 'Senha',
      onSaved: (value) {
        login.senha = value;
      },
      onFieldSubmitted: (value) {
        setState(() {
          login.senha = value;
        });
      },
    );
  }
}

// Future<void> _handleSubmit(BuildContext context) async {
//   try {
//     Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
//     await serivce.login(user.uid);
//     Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
//     Navigator.pushReplacementNamed(context, "/home");
//   } catch (error) {
//     print(error);
//   }
// }

