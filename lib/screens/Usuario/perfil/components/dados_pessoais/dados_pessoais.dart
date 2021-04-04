

import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:igig/components/default_button.dart';
import 'package:igig/constants.dart';
import 'package:igig/database/database.dart';
import 'package:igig/models/prestador.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DadosPessoais extends StatefulWidget {
  static const String routeName = "/dados-pessoais";

  DadosPessoais(this.prestador);
  Prestador prestador;

  @override
  _DadosPessoaisState createState() => _DadosPessoaisState();
}

class _DadosPessoaisState extends State<DadosPessoais> {

  final _formKey = GlobalKey<FormState>();
  int _value = 1;
  String email;
  String nome;
  String cpf;
  String telefone;
  String data;
  String genero;

  var _genero =['Feminino','Masculino','Não informar'];
  var _generoSelecionado = 'Não informar';

  DatabaseMetodos dbMetodo = new DatabaseMetodos();

  @override
  void initState() {
    Prestador prestador = widget.prestador;
    print(prestador.categoria);
    prestador.genero.toString().isNotEmpty ? _generoSelecionado = prestador.genero.toString() : _generoSelecionado = _genero[0];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Prestador prestador = widget.prestador;
    print(prestador.toString());
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text("Dados pessoais",),
        centerTitle: true,
        backgroundColor: CONST_COR_PRIMARIA,
        elevation: 5.0,
        brightness: Brightness.dark,
      ),
      body:
      SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(left: 22, right: 22, top: 22),
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  nomeFormField(prestador),
                  SizedBox(height: 20,),
                  cpfFormField(prestador),
                  SizedBox(height: 20,),
                  emailFormField(prestador),
                  SizedBox(height: 20,),
                  telefoneFormField(prestador),
                  SizedBox(height: 20,),
                  dataNascFormField(prestador),
                  SizedBox(height: 20,),
                  generoFormField(prestador),
                  SizedBox(height: 20,),
                  DefaultButton(
                    text: "Salvar",
                    press: (){
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

                        showTopSnackBar(context);

                        final FirebaseFirestore db = FirebaseFirestore.instance;

                        db.collection("prestador")
                            .doc( prestador.idFirestore )
                            .set( prestador.toMap() );
                      }
                    },
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showTopSnackBar(BuildContext context) =>
      Flushbar(
        icon: Icon(Icons.check_circle, size: 32, color: Colors.white),
        shouldIconPulse: true,
        message: 'Dados salvos',
        duration: Duration(seconds: 2, milliseconds: 500),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.green.withOpacity(.80),
      )
        ..show(context);

  TextFormField nomeFormField(Prestador p) {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Seu nome completo',
        labelText: 'Nome',
      ),
      keyboardType: TextInputType.name,
      onSaved: (newValue) => p.nome = newValue,
      validator: (value) {
        final nameExp = RegExp(r'^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]+$');
        if (value.isEmpty) return 'Instituição obrigatória';
        if (value.length < 3) return 'O nome tem que ter mais do que 3 caracteres';
        if (!nameExp.hasMatch(value)) return 'Campo com caracteres inválidos';
        return null;
      },
      initialValue: p.nome.toString(),
    );
  }

  TextFormField cpfFormField(Prestador prestador) {
    return TextFormField(
      enabled: false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: '000.000.000-00',
        labelText: 'CPF',
      ),
      onSaved: (value) {
        prestador.cpf = value;
      },
      initialValue: prestador.cpf.toString(),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        // Fit the validating format.
        CpfInputFormatter(),
      ],
    );
  }

  TextFormField emailFormField(Prestador prestador) {
    return TextFormField(
      enabled: false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'email@email.com.br',
        labelText: 'E-mail',
      ),
      keyboardType: TextInputType.emailAddress,
      initialValue: prestador.email.toString(),
      onSaved: (value) {
        prestador.email = value;
      },
      validator: _validarEmail,
    );
  }

  void _dropDownItemSelected(String novoItem){
    setState(() {
      this._generoSelecionado = novoItem;
    });
  }

  DropdownButtonFormField generoFormField(Prestador prestador){
    return DropdownButtonFormField<String>(
      items : _genero.map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
          value: dropDownStringItem,
          child: Text(dropDownStringItem),
        );
      }).toList(),
      onChanged: ( String novoItemSelecionado) {
        _dropDownItemSelected(novoItemSelecionado);
        setState(() {
          this._generoSelecionado =  novoItemSelecionado;
        });
      },
      value: _generoSelecionado,
      onSaved: (value) {
        prestador.genero = value;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Gênero',
      ),
    );
  }

  TextFormField telefoneFormField(Prestador prestador) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: '(81) 99999-9999',
        labelText: 'DDD + Telefone',
        prefixText: '+55 ',
      ),
      maxLines: 1,
      keyboardType: TextInputType.phone,
      initialValue: prestador.telefone.toString(),
      onSaved: (value) {
        prestador.telefone = value;
      },
      maxLength: 15,
      maxLengthEnforced: false,
      // validator: _validarTelefone,
      // TextInputFormatters are applied in sequence.
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        // Fit the validating format.
        // _phoneNumberFormatter,
        TelefoneInputFormatter(),
      ],
    );
  }

  String _validarTelefone(String value) {
    String patttern = r'[0-9]';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) return "Informe o celular";
    if (value.length != 14) return "O telefone esta incorreto";
    if (!regExp.hasMatch(value))
      return "O número do celular so deve conter dígitos";
    return null;
  }

  // TextFormField telefoneFormField(Prestador p) {
  //   return TextFormField(
  //     inputFormatters: [maskTelefone],
  //     keyboardType: TextInputType.phone,
  //     onSaved: (newValue) => p.telefone = newValue,
  //     validator: (value) {
  //       String patttern = r'[0-9]';
  //       RegExp regExp = new RegExp(patttern);
  //       if (value.length == 0) return "Informe o celular";
  //       if (value.length != 14) return "O telefone esta incorreto";
  //       if (!regExp.hasMatch(value))
  //         return "O número do celular so deve conter dígitos";
  //       return null;
  //     },
  //     initialValue: p.telefone.toString(),
  //     decoration: InputDecoration(
  //       labelText: "Telefone",
  //       border: OutlineInputBorder(),
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       labelStyle: TextStyle(
  //         fontWeight: FontWeight.w400,
  //         fontSize: 20,
  //       ),
  //     ),
  //   );
  // }

  TextFormField dataNascFormField(Prestador prestador) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: '01/01/1900',
        labelText: 'Data de nascimento',
      ),
      keyboardType: TextInputType.datetime,
      initialValue: prestador.dataNasc.toString(),
      onSaved: (value) {
        prestador.dataNasc = value;
      },
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        // Fit the validating format.
        DataInputFormatter(),
      ],
      // validator: _validarEmail,
    );
  }

  String _validarEmail(String value) {
    if (value.isEmpty) {
      return 'Email obrigatório';
    }
    if (!EmailValidator.validate(value)) {
      return "Email inválido!";
    }
    return null;
  }

}

