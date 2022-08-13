import 'package:app_mepoupe/views/widgets/address_return_zipcode.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController textNumberEditController = TextEditingController();
  String? validateReturnField = 'none';
  final returnedInvalidData = 'none';
  final returnedValidData = 'returnedOk';
  final returnedNoValidData = 'noReturnedValid';
  final returnedDifferentData = 'differentData';

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);

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
                      controller: textNumberEditController,
                      validator: (cep) {
                        if (cep!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (cep.length != 8) {
                          return 'CEP inválido';
                        } else {
                          null;
                        }
                        return null;
                      },
                      onFieldSubmitted: ((value) => validateTextFormField()),
                      maxLength: 8,
                      // inputFormatters: [FilterRemoveCharacters()],
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
                        prefixIconColor: Colors.black,
                        filled: true,
                        hintText: '88330-301',
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
                      if (validateReturnField == textNumberEditController.text)
                        const AddressReturnZipcode(),
                      if (validateReturnField == returnedNoValidData)
                        const FittedBox(
                          child: Text(
                              'Não conseguimos localizar seu endereço, verifique se as informações passadas estão corretas'),
                        ),
                      if (validateReturnField == returnedInvalidData ||
                          validateReturnField == returnedDifferentData)
                        Flexible(
                          child: Image.asset(
                            'assets/images/location_review_bro_cep.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  validateTextFormField() {
    if (formKey.currentState!.validate()) {
      setState(() {
        validateReturnField = textNumberEditController.text;
      });
      return;
    }
  }
}
