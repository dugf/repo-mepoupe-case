import 'package:app_mepoupe/bloc/via_cep_address.dart';
import 'package:app_mepoupe/resources/strings.dart';
import 'package:dio/dio.dart';

class ViaCepService {
  Future<ViaCepAddress> getAddressFromCEP(String cep) async {
    final cleanCep = cep.replaceAll('.', '').replaceAll('-', '');
    final endPoint = 'https://viacep.com.br/ws/$cleanCep/json/';

    final Dio dio = Dio();

    var response = await dio.get(endPoint);

    try {
      final ViaCepAddress address = ViaCepAddress.fromMap(response.data);
      if (response.data.toString() == '{erro: true}') {
        return Future.error(Strings.zipCodeInvalid);
      }
      return address;
    } on DioError {
      return Future.error(Strings.zipCodeError);
    }
  }
}
