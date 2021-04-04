import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:igig/components/default_button.dart';
import 'package:igig/models/prestador.dart';
import 'package:igig/screens/cadastro/cadastrar_endereco.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Body extends StatefulWidget {

  Body(this.prestador);
  final Prestador prestador;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final _formKey = GlobalKey<FormState>();
  Prestador prestador = Prestador();
  var _genero =['Feminino','Masculino','Não informar'];
  var _generoSelecionado = 'Não informar';

  @override
  Widget build(BuildContext context) {
    Prestador prestador = widget.prestador;
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
                    Text("Dados pessoais",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        )
                    ),
                    SizedBox(height: 20),
                    nomeFormField(prestador),
                    SizedBox(height: 20),
                    Row(
                        children: [
                          Expanded(
                            child: generoFormField(prestador),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: dataNascFormField(prestador),
                          )
                        ]
                    ),
                    SizedBox(height: 20),
                    emailFormField(prestador),
                    SizedBox(height: 20),
                    telefoneFormField(prestador),
                    SizedBox(height: 20),
                    DefaultButton(
                      text: "Avançar",
                      press: (){
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context)=> TelaCadastrarEndereco(prestador),
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
        ],
      ),
    );
  }

  TextFormField nomeFormField(Prestador prestador) {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Seu nome completo',
        labelText: 'Nome',
      ),
      maxLines: 1,
      onSaved: (value) {
        prestador.nome = value;
      },
      validator: _validarNome,
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

  TextFormField dataNascFormField(Prestador prestador) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: '01/01/1900',
        labelText: 'Data de nascimento',
      ),
      keyboardType: TextInputType.datetime,
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

  TextFormField emailFormField(Prestador prestador) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'email@email.com.br',
        labelText: 'E-mail',
      ),
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        prestador.email = value;
      },
      validator: _validarEmail,
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
    final phoneExp = RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\d\d$');
    if (!phoneExp.hasMatch(value)) {
      return 'Telefone com caracteres inválidos';
    }
    return null;
  }

  String _validarEmail(String value) {
    if (value.isEmpty) {
      return 'Email obrigatório';
    }
    // if (!EmailValidator.validate(value)) {
    //   print('Email inválido!');
    //   return "";
    // }
    return null;
  }

  String _validarNome(String value) {
    if (value.isEmpty) {
      return 'Nome obrigatório';
    }
    final nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Caracteres inválidos inseridos.';
    }
    return null;
  }

}
