class Servico{
  String _instituicao = "";
  String _servico = "";
  bool _status = false;
  double _valor = 0.0;
  DateTime _dataInicial;
  DateTime _dataFinal;
  DateTime _expiracao;
  String _idFirestore = '';

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "servico" : this._servico,
      "instituicao" : this._instituicao,
      "valor" : this._valor,
      "dataInicial" : this._dataInicial,
      "dataFinal" : this._dataFinal,
      "expiracao" : this._expiracao,
      "status" : this._status,
    };
    return map;
  }

  String get instituicao => _instituicao;

  set instituicao(String value) {
    _instituicao = value;
  }

  String get servico => _servico;

  DateTime get expiracao => _expiracao;

  set expiracao(DateTime value) {
    _expiracao = value;
  }

  DateTime get dataFinal => _dataFinal;

  set dataFinal(DateTime value) {
    _dataFinal = value;
  }

  DateTime get dataInicial => _dataInicial;

  set dataInicial(DateTime value) {
    _dataInicial = value;
  }

  double get valor => _valor;

  set valor(double value) {
    _valor = value;
  }

  bool get status => _status;

  set status(bool value) {
    _status = value;
  }

  set servico(String value) {
    _servico = value;
  }

  String get idFirestore => _idFirestore;

  set idFirestore(String value) {
    _idFirestore = value;
  }

  @override
  String toString() {
    return 'Servico{_instituicao: $_instituicao, _servico: $_servico, _status: $_status, _valor: $_valor, _dataInicial: $_dataInicial, _dataFinal: $_dataFinal, _expiracao: $_expiracao, _idFirestore: $_idFirestore}';
  }
}