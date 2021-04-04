import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:igig/components/default_button.dart';
import 'package:igig/models/prestador.dart';
import 'package:igig/screens/cadastro/cadastrar_senha.dart';

class Body extends StatefulWidget {

  Body(this.prestador);
  final Prestador prestador;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final _formKey = GlobalKey<FormState>();
  Prestador prestador = Prestador();

  // CONSELHO
  var _conselho =['Tipo 1','Tipo 2','Tipo 3'];
  var _conselhoSelecionado = 'Tipo 1';

  // CATEGORIA
  var _categoria =['Tipo 1','Tipo 2','Tipo 3'];
  var _categoriaSelecionada = 'Tipo 1';

  // ESPECIALIDADE
  var _especialidade =['Tipo 1','Tipo 2','Tipo 3'];
  var _especialidadeSelecionada = 'Tipo 1';

  @override
  void initState() {
    Prestador prestador = widget.prestador;
    print(prestador.categoria);
    prestador.conselho.toString().isNotEmpty ? _conselhoSelecionado = prestador.conselho.toString() : _conselhoSelecionado = _conselho[0];
    prestador.categoria.toString().isNotEmpty ? setState(() => _categoriaSelecionada = prestador.categoria.toString()) : _categoriaSelecionada = _categoria[0];
    prestador.especialidade.toString().isNotEmpty ? _especialidadeSelecionada = prestador.especialidade.toString() : _especialidadeSelecionada = _especialidade[0];
    super.initState();
  }

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
                    Text("Dados profissionais",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        )
                    ),
                    SizedBox(height: 20),
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

                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context)=> CadastrarSenha(prestador),
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
