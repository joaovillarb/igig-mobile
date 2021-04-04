import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:igig/components/default_button.dart';
import 'package:igig/models/prestador.dart';
import 'package:igig/screens/cadastro/cadastrar_dados_pessoais.dart';

class Body extends StatefulWidget {
  @override
  _CadastroFormState createState() => _CadastroFormState();
}

class _CadastroFormState extends State<Body> {

  final _formKey = GlobalKey<FormState>();
  Prestador prestador = Prestador();

  var retorno;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 22, right: 22, top: 22),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Validação de CPF",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        )
                    ),
                    SizedBox(height:8),
                    Text(
                      "Ele é usado como sua principal identificação no IGIG",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height:20),
                    cpfFormField(),
                    SizedBox(height: 20,),
                    DefaultButton(
                      text: "Avançar",
                      press: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context)=> CadastrarDadosPessoais(prestador),
                            ),
                          );

                        }
                      },
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          ),
          // Container(
          //   child: BottomButton(
          //     text: "Cadastre-se",
          //     press: () {
          //       if (_formKey.currentState.validate()) {
          //         _formKey.currentState.save();
          //
          //         Navigator.push(context,
          //           MaterialPageRoute(
          //             builder: (context)=> TelaCadastrarDadosPessoais(prestador),
          //           ),
          //         );
          //       }
          //     },
          //   ),
          // ),
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
        prestador.cpf = value;
      },
      onChanged: (value) async {
        print(value);
        if(value.length == 14){
          print('entrou');
          retorno = null;
          FirebaseFirestore db = FirebaseFirestore.instance;

          QuerySnapshot querySnapshot = await db.collection('prestador').get();

          for (DocumentSnapshot item in querySnapshot.docs ){
            var dados = item.data();
            var id = item.id;
            if(dados['cpf'] == value){
              retorno = {'id':id,'dados':dados};
              print('Prestador encontrado: ' + id);
              break;
            }
          }
          if(retorno != null) {
            print('prestador ja cadastrado');
            retorno = 'Cpf encontrado em nossa base de dados';
          }

          print('saiu');
        }

      },
      initialValue: prestador.cpf.toString(),
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
    if (retorno != null) {
      return retorno;
    }
    return null;
  }
}
