
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:igig/components/default_button.dart';
import 'package:igig/constants.dart';
import 'package:igig/models/prestador.dart';
import 'package:search_cep/search_cep.dart';

class Endereco extends StatefulWidget {
  static const String routeName = "/endereco";

  Endereco(this.prestador);
  Prestador prestador;

  @override
  _EnderecoState createState() => _EnderecoState();
}

class _EnderecoState extends State<Endereco> {

  final _formKey = GlobalKey<FormState>();

  final _cepController = TextEditingController(); // CEP
  final _enderecoController = TextEditingController(); // Nome da Rua
  final _bairroController = TextEditingController(); // Bairro
  final _cidadeContoller = TextEditingController(); // Cidade / Localidade
  final _ufController = TextEditingController(); //  Unidade federativa Estado.

  var _estado =["AC","AL","AP","AM","BA","CE","ES","GO","MA","MT","MS","MG","PA","PB","PR",
    "PE","PI","RJ","RN","RS","RO","RR","SC","SP","SE","TO","DF"];
  var _ufSelecionado = 'AC';

  void _cpe() async {
    // Variáveis que receberão os dados do WebService
    var _bairro;
    String _cidade;
    String _cep;
    String _uf;
    String _endereco;
    final viaCepSearchCep = ViaCepSearchCep();
    _cep = _cepController.text;

    final infoCepJSON = await viaCepSearchCep.searchInfoByCep(cep: '$_cep');

    var retorno = infoCepJSON.toIterable();

    // variáveis recebendo os dados em JSON da API

    _bairro = infoCepJSON.fold((_) => null, (data) => data.bairro);
    _endereco = infoCepJSON.fold((_) => null, (data) => data.logradouro);
    _cidade = infoCepJSON.fold((_) => null, (data) => data.localidade);
    _uf = infoCepJSON.fold((_) => null, (data) => data.uf);

// controller recebendo os dados das variáveis
    _enderecoController.text = _endereco;
    _bairroController.text = _bairro;
    _cidadeContoller.text = _cidade;
    setState(() {
      this._ufSelecionado = _uf;
    });
    // _ufController.text = _uf;
  }

  @override
  void initState() {
    Prestador prestador = widget.prestador;
    prestador.cep.toString() != null ? _cepController.text = prestador.cep.toString() : _cepController.text = "";
    prestador.endereco.toString() != null ? _enderecoController.text = prestador.endereco.toString() : _enderecoController.text = "";
    prestador.bairro.toString() != null ? _bairroController.text = prestador.bairro.toString() : _bairroController.text = "";
    prestador.cidade.toString() != null ? _cidadeContoller.text = prestador.cidade.toString() : _cidadeContoller.text = "";
    prestador.uf.toString().isNotEmpty ? _ufSelecionado = prestador.uf.toString() : _ufSelecionado = _estado[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Prestador prestador = widget.prestador;
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text("Endereço",),
        centerTitle: true,
        backgroundColor: CONST_COR_PRIMARIA,
        elevation: 5.0,
        brightness: Brightness.dark,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.only(left: 22, right: 22, top: 8),
            children: <Widget>[
              SizedBox(height: 20),
              cepFormField(prestador),
              SizedBox(height: 20),
              enderecoFormField(prestador),
              SizedBox(height: 20),
              numeroFormField(prestador),
              SizedBox(height: 20),
              complementoFormField(prestador),
              SizedBox(height: 20),
              bairroFormField(prestador),
              SizedBox(height: 20),
              ufFormField(prestador),
              SizedBox(height: 20),
              cidadeFormField(prestador),
              SizedBox(height: 20),
              DefaultButton(
                text: "Avançar",
                press: (){
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();

                    showTopSnackBar(context);
                  }
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
  void showTopSnackBar(BuildContext context) => Flushbar(
    icon: Icon(Icons.check_circle, size:32, color: Colors.white),
    shouldIconPulse: true,
    message: 'Dados salvos',
    duration: Duration(seconds: 2, milliseconds: 500),
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: Colors.green.withOpacity(.80),
  )..show(context);


  TextFormField cepFormField(Prestador prestador) {
    return TextFormField(
      controller: _cepController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: '00000000',
        labelText: "CEP",
      ),
      keyboardType: TextInputType.number,
      onChanged: (_cepController) {
        if (_cepController.length >= 8) {
          _cpe();
        }
      },
      onSaved: (value) {
        prestador.cep = value;
      },
      maxLength: 8,
      // inputFormatters: <TextInputFormatter>[
      //   FilteringTextInputFormatter.digitsOnly,
      //   CepInputFormatter(),
      // ],
      // validator: _validarCep,
    );
  }

  TextFormField enderecoFormField(Prestador prestador) {
    return TextFormField(
      controller: _enderecoController,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Rua, avenida, travessa, praça, etc',
        labelText: 'Endereço',
      ),
      maxLines: 1,
      onSaved: (value) {
        prestador.endereco = value;
      },
      // validator: _validarNome,
    );
  }

  TextFormField bairroFormField(Prestador prestador) {
    return TextFormField(
      controller: _bairroController,
      textCapitalization: TextCapitalization.words,
      // initialValue: prestador.bairro.toString(),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Nome do bairro',
        labelText: 'Bairro',
      ),
      maxLines: 1,
      onSaved: (value) {
        prestador.bairro = value;
      },
      // validator: _validarNome,
    );
  }

  TextFormField numeroFormField(Prestador prestador) {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      initialValue: prestador.numero.toString(),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Numero da residência',
        labelText: 'Numero',
      ),
      maxLines: 1,
      onSaved: (value) {
        prestador.numero = value;
      },
      // validator: _validarNome,
    );
  }

  TextFormField complementoFormField(Prestador prestador) {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      initialValue: prestador.complemento.toString(),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Bloco, apartamento, casa, etc',
        labelText: 'Complemento',
      ),
      maxLines: 1,
      onSaved: (value) {
        prestador.complemento = value;
      },
      // validator: _validarNome,
    );
  }

  TextFormField cidadeFormField(Prestador prestador) {
    return TextFormField(
      controller: _cidadeContoller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Bloco, apartamento, casa, etc',
        labelText: 'Cidade',
      ),
      maxLines: 1,
      onSaved: (value) {
        prestador.cidade = value;
      },
      // validator: _validarNome,
    );
  }

  void _dropDownItemSelected(String novoItem){
    setState(() {
      this._ufSelecionado = novoItem;
    });
  }

  DropdownButtonFormField ufFormField(Prestador prestador){
    return DropdownButtonFormField<String>(
      items : _estado.map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
          value: dropDownStringItem,
          child: Text(dropDownStringItem),
        );
      }).toList(),
      onChanged: ( String novoItemSelecionado) {
        _dropDownItemSelected(novoItemSelecionado);
        setState(() {
          this._ufSelecionado =  novoItemSelecionado;
        });
      },
      value: _ufSelecionado,
      onSaved: (value) {
        prestador.uf = value;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Estado',
      ),
    );
  }

  String _validarCep(String value) {
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
