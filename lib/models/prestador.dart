class Prestador {

  Prestador({String cpf}){
    if(cpf != "" && cpf != null){
      this._cpf = cpf;
    }
  }

  String _cpf = '';
  String _email = '';
  String _nome = '';
  String _senha = '';
  String _telefone = '';
  String _dataNasc = '';
  String _genero = '';
  String _cremepe = '';
  String _conselho = '';
  String _categoria = '';
  String _especialidade = '';

  //ENDEREÇO
  String _cep = '';
  String _endereco = '';
  String _bairro = '';
  String _cidade = '';
  String _uf = '';
  String _complemento = '';
  String _numero = '';

  bool _status = false;
  String _idFirestore = '';

  bool get status => _status;

  set status(bool value) {
    _status = value;
  }

  String get idFirestore => _idFirestore;

  set idFirestore(String value) {
    _idFirestore = value;
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "cpf" : this._cpf,
      "email" : this._email,
      "nome" : this._nome,
      "telefone" : this._telefone,
      "data de nascimento" : this._dataNasc,
      "genero" : this._genero,
      "cremepe" : this._cremepe,
      "conselho" : this._conselho,
      "categoria" : this._categoria,
      "especialidade" : this._especialidade,
      "cep" : this._cep,
      "endereco": this._endereco,
      "bairro" : this._bairro,
      "cidade" : this._cidade,
      "uf" : this._uf,
      "complemento" : this._complemento,
      "numero" : this._numero,
      "status" : this._status,
    };
    return map;
  }

  String get cremepe => _cremepe;

  set cremepe(String value) {
    _cremepe = value;
  }

  String get telefone => _telefone;

  set telefone(String value){
    _telefone = value;
  }

  String get dataNasc => _dataNasc;

  set dataNasc(String value){
    _dataNasc = value;
  }

  String get genero => _genero;

  set genero(String value){
    _genero = value;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get cpf => _cpf;

  set cpf(String value) {
    _cpf = value;
  }

  String get conselho => _conselho;

  set conselho(String value) {
    _conselho = value;
  }

  String get categoria => _categoria;

  set categoria(String value) {
    _categoria = value;
  }

  String get especialidade => _especialidade;

  set especialidade(String value) {
    _especialidade = value;
  }


  String get cep => _cep;

  set cep(String value) {
    _cep = value;
  }

  String get endereco => _endereco;

  set endereco(String value) {
    _endereco = value;
  }

  String get bairro => _bairro;

  set bairro(String value) {
    _bairro = value;
  }

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;
  }

  String get uf => _uf;

  set uf(String value) {
    _uf = value;
  }

  String get complemento => _complemento;

  set complemento(String value) {
    _complemento = value;
  }

  String get numero => _numero;

  set numero(String value) {
    _numero = value;
  }

  @override
  String toString() {
    return 'Prestador{_cpf: $_cpf, _email: $_email, _nome: $_nome, _telefone: $_telefone, _dataNasc: $_dataNasc, _genero: $_genero, _cremepe: $_cremepe, _conselho: $_conselho, _categoria: $_categoria, _especialidade: $_especialidade, _cep: $_cep, _endereco: $_endereco, _bairro: $_bairro, _cidade: $_cidade, _uf: $_uf, _complemento: $_complemento, _numero: $_numero, _idFirestore: $_idFirestore, status: $_status}';
  }
}