import 'package:flutter/material.dart';
import 'package:igig/models/prestador.dart';

import 'package:igig/screens/Usuario/perfil/components/alterar_senha/alterar_senha.dart';
import 'package:igig/screens/Usuario/perfil/components/dados_pessoais/dados_pessoais.dart';
import 'package:igig/screens/Usuario/perfil/components/dados_profissionais/dados_profissionais.dart';
import 'package:igig/screens/Usuario/perfil/components/endereco/endereco.dart';
import 'package:igig/screens/Usuario/perfil/telar_perfil.dart';
import 'package:igig/screens/apresentacao/tela_apresentacao.dart';
import 'package:igig/screens/cadastro/aguardando_validacao.dart';
import 'package:igig/screens/cadastro/cadastrar_dados_pessoais.dart';
import 'package:igig/screens/dashboard/conferir_interna/detalhes_da_proposta.dart';
import 'package:igig/screens/dashboard/conferir_interna/confirmar_interna/confirmar_interna_screen.dart';
import 'package:igig/screens/dashboard/home.dart';
import 'package:igig/screens/cadastro/cadastro_screen.dart';
import 'package:igig/screens/login/esqueci_senha/esqueci_senha_screen.dart';
import 'package:igig/screens/login/login_screen.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings){
    var dados;
    Prestador prestador;
    String msg1;
    String msg2;

    switch( settings.name ){
      case "/" :
        return MaterialPageRoute(
          builder: (_) => Login()
        );
      case Login.routeName :
        return MaterialPageRoute(
            builder: (_) => Login()
        );
      case Cadastro.routeName :
        return MaterialPageRoute(
            builder: (_) => Cadastro()
        );
      case Home.routeName :
        return MaterialPageRoute(
            builder: (_) => Home(prestador)
        );
      case Apresentacao.routeName :
        return MaterialPageRoute(
            builder: (_) => Apresentacao()
        );
      case CadastrarDadosPessoais.routeName :
        return MaterialPageRoute(
            builder: (_) => CadastrarDadosPessoais(prestador)
        );
      case EsqueciSenha.routeName :
        return MaterialPageRoute(
            builder: (_) => EsqueciSenha()
        );
      case AguardandoValidacao.routeName :
        return MaterialPageRoute(
            builder: (_) => AguardandoValidacao(prestador)
        );
      case DetalhesDaProposta.routeName :
        return MaterialPageRoute(
            builder: (_) => DetalhesDaProposta(dados,prestador)
        );
      case ConfirmarInterna.routeName :
        return MaterialPageRoute(
            builder: (_) => ConfirmarInterna(prestador,msg1,msg2)
        );
      case Perfil.routeName :
        return MaterialPageRoute(
            builder: (_) => Perfil(prestador)
        );
      case DadosPessoais.routeName :
        return MaterialPageRoute(
            builder: (_) => DadosPessoais(prestador)
        );
      case Endereco.routeName :
        return MaterialPageRoute(
            builder: (_) => Endereco(prestador)
        );
      case DadosProssionais.routeName :
        return MaterialPageRoute(
            builder: (_) => DadosProssionais(prestador)
        );
      case AlterarSenha.routeName :
        return MaterialPageRoute(
            builder: (_) => AlterarSenha()
        );
      default:
        _erroRota();
    }

  }

  static Route<dynamic> _erroRota(){
    return MaterialPageRoute(
      builder: (_){
        return Scaffold(
          appBar: AppBar(title: Text("Tela não encontrada!"),),
          body: Center(
            child: Text("Tela não encontrada!"),
          ),
        );
      }
    );
  }

}