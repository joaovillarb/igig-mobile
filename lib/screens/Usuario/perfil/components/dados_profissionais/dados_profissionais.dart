
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igig/components/default_button.dart';
import 'package:igig/constants.dart';
import 'package:igig/database/database.dart';
import 'package:igig/models/prestador.dart';

class DadosProssionais extends StatefulWidget {
  static const String routeName = "/dados-profissionais";

  DadosProssionais(this.prestador);
  Prestador prestador;

  @override
  _DadosProssionaisState createState() => _DadosProssionaisState();
}

class _DadosProssionaisState extends State<DadosProssionais> {

  final _formKey = GlobalKey<FormState>();

  // CONSELHO
  var _conselho =['Tipo 1','Tipo 2','Tipo 3'];
  var _conselhoSelecionado = 'Tipo 1';

  // CATEGORIA
  var _categoria =['Tipo 1','Tipo 2','Tipo 3'];
  var _categoriaSelecionada = 'Tipo 1';

  // ESPECIALIDADE
  var _especialidade =['Tipo 1','Tipo 2','Tipo 3'];
  var _especialidadeSelecionada = 'Tipo 1';
  DatabaseMetodos dbMetodo = new DatabaseMetodos();

  @override
  void initState() {
    Prestador prestador = widget.prestador;
    prestador.conselho.toString().isNotEmpty ? _conselhoSelecionado = prestador.conselho.toString() : _conselhoSelecionado = _conselho[0];
    prestador.categoria.toString().isNotEmpty ? _categoriaSelecionada = prestador.categoria.toString() : _categoriaSelecionada = _categoria[0];
    prestador.especialidade.toString().isNotEmpty ? _especialidadeSelecionada = prestador.especialidade.toString() : _especialidadeSelecionada = _especialidade[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Prestador prestador = widget.prestador;
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text("Dados profissionais",),
        centerTitle: true,
        backgroundColor: CONST_COR_PRIMARIA,
        elevation: 5.0,
        brightness: Brightness.dark,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(left: 22, right: 22, top: 22),
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  cremepeFormField(prestador),
                  SizedBox(height: 20),
                  conselhoFormField(prestador),
                  SizedBox(height: 20),
                  categoriaFormField(prestador),
                  SizedBox(height: 20),
                  especialidadeFormField(prestador),
                  SizedBox(height: 20),
                  DefaultButton(
                    text: "Avançar",
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

  TextFormField cremepeFormField(Prestador prestador) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: "Cremepe",
      ),
      onSaved: (value) => prestador.cremepe = value,
      initialValue: prestador.cremepe.toString(),
      validator: _validarCremepe,
    );
  }

  void _dropConselhoSelecionado(String novoItem){
    setState(() {
      this._conselhoSelecionado = novoItem;
    });
  }

  DropdownButtonFormField conselhoFormField(Prestador prestador){
    return DropdownButtonFormField<String>(
      items : _conselho.map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
          value: dropDownStringItem,
          child: Text(dropDownStringItem),
        );
      }).toList(),
      onChanged: ( String novoItemSelecionado) {
        _dropConselhoSelecionado(novoItemSelecionado);
        setState(() {
          this._conselhoSelecionado =  novoItemSelecionado;
        });
      },
      value: _conselhoSelecionado,
      onSaved: (value) {
        prestador.conselho = value;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Conselho',
      ),
    );
  }

  void _dropCategoriaSelecionada(String novoItem){
    setState(() {
      this._categoriaSelecionada = novoItem;
    });
  }

  DropdownButtonFormField categoriaFormField(Prestador prestador){
    return DropdownButtonFormField<String>(
      items : _categoria.map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
          value: dropDownStringItem,
          child: Text(dropDownStringItem),
        );
      }).toList(),
      onChanged: ( String novoItemSelecionado) {
        _dropCategoriaSelecionada(novoItemSelecionado);
        setState(() {
          this._categoriaSelecionada =  novoItemSelecionado;
        });
      },
      value: _categoriaSelecionada,
      onSaved: (value) {
        prestador.categoria = value;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Categoria',
      ),
    );
  }

  void _dropEspecialidadeSelecionada(String novoItem){
    setState(() {
      this._especialidadeSelecionada = novoItem;
    });
  }

  DropdownButtonFormField especialidadeFormField(Prestador prestador){
    return DropdownButtonFormField<String>(
      items : _especialidade.map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
          value: dropDownStringItem,
          child: Text(dropDownStringItem),
        );
      }).toList(),
      onChanged: ( String novoItemSelecionado) {
        _dropEspecialidadeSelecionada(novoItemSelecionado);
        setState(() {
          this._especialidadeSelecionada =  novoItemSelecionado;
        });
      },
      value: _especialidadeSelecionada,
      onSaved: (value) {
        prestador.especialidade = value;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Especialidade',
      ),
    );
  }

  String _validarCremepe(String value) {
    if (value.isEmpty) {
      return 'Cremepe obrigatório';
    }
    // if (value.length == 0) return "Informe o cremepe de nascimento";

    return null;
  }
}