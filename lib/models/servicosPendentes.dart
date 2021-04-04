import 'package:igig/models/prestador.dart';
import 'package:igig/models/servico.dart';

enum Status {
  GANHO,
  PENDENTE,
  PERDIDO
}

class ServicosPendentes {
  Prestador _prestador;
  Servico _servico;
  Status _status;

  ServicosPendentes(this._prestador, this._servico, this._status);

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "servico" : this._servico,
      "prestador" : this._prestador,
      "status" : this._status,
    };
    return map;
  }

  Prestador get prestador => _prestador;

  set prestador(Prestador value) {
    _prestador = value;
  }

  Servico get servico => _servico;

  set servico(Servico value) {
    _servico = value;
  }


  Status get status => _status;

  set status(Status value) {
    _status = value;
  }

  @override
  String toString() {
    return 'ServicosPendentes{prestador: $_prestador, servico: $_servico, status: $_status}';
  }
}