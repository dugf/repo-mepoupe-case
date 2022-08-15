class ViaCepAddress {
  String? cep;
  String? logradouro;
  String? bairro;
  String? localidade;
  String? complemento;
  String? uf;

  ViaCepAddress.fromMap(Map<String, dynamic>? map) {
    cep = map!['cep'];
    logradouro = map['logradouro'];
    bairro = map['bairro'];
    localidade = map['localidade'];
    complemento = map['complemento'];
    uf = map['uf'];
  }
}
