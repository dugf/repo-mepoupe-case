import 'package:app_mepoupe/bloc/via-cep-address.dart';
import 'package:dio/dio.dart';

class ViaCepService {
  //FUNCAO RESPONSÁVEL POR PEGAR OS DADOS DO LINK
  Future<ViaCepAddress> getAddressFromCEP(String cep) async {
    final cleanCep = cep.replaceAll('.', '').replaceAll('-', '');
    final endPoint = 'https://viacep.com.br/ws/$cleanCep/json/';

    final Dio dio = Dio();

    var response = await dio.get(endPoint);

    print('ENDPOINT $endPoint');

    //VALIDANDO SE O DADO RETORNADO É VÁLIDO
    try {
      final ViaCepAddress address = ViaCepAddress.fromMap(response.data);
      if (response.data.toString() == '{erro: true}') {
        return Future.error('CEP INVÁLIDO');
      }
      return address;
    } on DioError {
      return Future.error('ERRO AO BUSCAR CEP');
    }
  }
}
