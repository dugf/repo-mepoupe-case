import 'package:app_mepoupe/bloc/address.dart';
import 'package:app_mepoupe/bloc/address_manager.dart';
import 'package:app_mepoupe/datasources/via_cep_service.dart';
import 'package:app_mepoupe/views/widgets/address_return_zipcode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController textCepEditingController = TextEditingController();
  String? validateReturnField = 'none';
  final returnedInvalidData = 'none';
  final returnedValidData = 'returnedOk';
  final returnedNoValidData = 'noReturnedValid';
  final returnedDifferentData = 'differentData';

  var maskFormatter = MaskTextInputFormatter(
      mask: '#####-###', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);

    return Consumer<AddressManager>(builder: (_, addressManager, __) {
      final address = addressManager.address ?? Address();
      final getCeps = addressManager.items.map((e) => e.zipCode);

      return Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              height: queryData.size.height * 0.44 - kBottomNavigationBarHeight,
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 30, right: 30, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      child: Text(
                        'Procurar CEP',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize:
                              MediaQuery.of(context).size.longestSide * 0.034,
                        ),
                      ),
                    ),
                    Center(
                      child: FittedBox(
                        child: Text(
                          'Digite o CEP que você\n desejo procurar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize:
                                MediaQuery.of(context).size.longestSide * 0.02,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: TextFormField(
                        controller: textCepEditingController,
                        validator: (cep) {
                          if (cep!.isEmpty) {
                            return 'Campo obrigatório!';
                          } else if (cep.length != 9) {
                            return 'CEP inválido!';
                          } else {
                            null;
                          }
                          return null;
                        },
                        onFieldSubmitted: ((value) =>
                            validateTextFormField(addressManager)),
                        maxLength: 9,
                        inputFormatters: [maskFormatter],
                        textInputAction: TextInputAction.search,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: '',
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 14),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              borderSide: BorderSide.none),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              'assets/icons/search_icon.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          prefixIconColor: Colors.black,
                          filled: true,
                          hintText: '12345-678',
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: queryData.size.width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (validateReturnField == returnedValidData)
                        address.zipCode == null
                            ? const CircularProgressIndicator()
                            : AddressReturnZipcode(
                                colorFavoriteZipCode: getCeps.contains(
                                        addressManager.address?.zipCode)
                                    ? true
                                    : false,
                                address: address,
                              ),
                      if (validateReturnField == returnedNoValidData)
                        const Flexible(
                          child: Text(
                            'Não conseguimos localizar seu endereço, verifique se as informações passadas estão corretas!',
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      if (validateReturnField == returnedInvalidData)
                        Flexible(
                          child: Image.asset(
                            'assets/images/location_review_bro_cep.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      if (validateReturnField == returnedDifferentData)
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Future<dynamic> validateTextFormField(AddressManager addressManager) async {
    final ViaCepService viaCepAddress = ViaCepService();

    if (formKey.currentState!.validate()) {
      validateReturnField = returnedDifferentData;
      context
          .read<AddressManager>()
          .getAddress(textCepEditingController.text)
          .toString();

      try {
        await viaCepAddress.getAddressFromCEP(textCepEditingController.text);
        setState(() {
          validateReturnField = returnedValidData;
        });
      } catch (e) {
        setState(() {
          validateReturnField = returnedNoValidData;
        });
        return;
      }
    }
  }
}
