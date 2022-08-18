import 'package:app_mepoupe/bloc/address.dart';
import 'package:app_mepoupe/bloc/address_manager.dart';
import 'package:app_mepoupe/datasources/via_cep_service.dart';
import 'package:app_mepoupe/resources/strings.dart';
import 'package:app_mepoupe/views/widgets/address_return_zipcode.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController textCepEditingController = TextEditingController();
  String? validateReturnScreen = Strings.returnNoneSearchType;
  final returnedInvalidData = Strings.returnNoneSearchType;
  final returnedValidData = Strings.returnOkeSearchType;
  final returnedNoValidData = Strings.noReturnValidSearchType;
  final returnedDifferentData = Strings.returnDifferentSearchType;
  final returndatashared = Strings.returnNoneSearchType;
  var returnCep = Strings.emptyText;

  var maskFormatter = MaskTextInputFormatter(
      mask: '#####-###', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    getScreenShared();
    super.initState();
  }

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
                        Strings.searchZipCode,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: Strings.fontPoppins,
                          fontWeight: FontWeight.w600,
                          fontSize:
                              MediaQuery.of(context).size.longestSide * 0.034,
                        ),
                      ),
                    ),
                    Center(
                      child: FittedBox(
                        child: Text(
                          Strings.insertZipCodeToSearch,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: Strings.fontPoppins,
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
                            return Strings.requiredField;
                          } else if (cep.length != 9) {
                            return Strings.invalidZipCode;
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
                              Strings.iconSearchZipCode,
                              fit: BoxFit.fill,
                            ),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          prefixIconColor: Colors.black,
                          filled: true,
                          hintText: Strings.hintTextZipCode,
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
                      if (addressManager.returnScreen == returnedValidData)
                        address.zipCode == null
                            ? const CircularProgressIndicator()
                            : AddressReturnZipcode(
                                colorFavoriteZipCode: getCeps.contains(
                                        addressManager.address?.zipCode)
                                    ? true
                                    : false,
                                address: address,
                              ),
                      if (addressManager.returnScreen == returnedNoValidData)
                        const Flexible(
                          child: Text(
                            Strings.noReturnValidSearch,
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      if (addressManager.returnScreen == returnedInvalidData)
                        Flexible(
                          child: Image.asset(
                            Strings.imageLocationReviewBroCep,
                            fit: BoxFit.fill,
                          ),
                        ),
                      if (addressManager.returnScreen == returnedDifferentData)
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
    bool result = await InternetConnectionChecker().hasConnection;

    if (result == true) {
      if (formKey.currentState!.validate()) {
        var returnCounter = int.parse(addressManager.counter);
        if (!mounted) {}
        addCounterShared(returnCounter, context);
        addressManager.returnScreen = returnedDifferentData;
        setScreenShared(returnedDifferentData, context);
        setZipcodeShared(textCepEditingController.text, context);

        if (!mounted) {}
        context
            .read<AddressManager>()
            .getAddress(textCepEditingController.text)
            .toString();

        try {
          await viaCepAddress.getAddressFromCEP(textCepEditingController.text);
          addressManager.returnScreen = returnedValidData;
          if (!mounted) {}
          setScreenShared(returnedValidData, context);
          setZipcodeShared(textCepEditingController.text, context);
        } catch (e) {
          addressManager.returnScreen = returnedNoValidData;
          setScreenShared(returnedNoValidData, context);
          setZipcodeShared(textCepEditingController.text, context);

          return;
        }
      }
    } else {
      if (!mounted) {}
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text(Strings.noInternet)));
    }
  }

  getScreenShared() async {
    final prefs = await SharedPreferences.getInstance();
    final returnDataCep = prefs.getString('returnCep') ?? Strings.emptyText;
    returnCep = returnDataCep;
    setState(() {
      textCepEditingController.text = returnCep;
    });
  }

  addCounterShared(int counterData, BuildContext context) {
    context.read<AddressManager>().addCounter(counterData);
  }

  setScreenShared(String screenData, BuildContext context) {
    context.read<AddressManager>().setScreen(screenData);
  }

  setZipcodeShared(String zipCodeData, BuildContext context) {
    context.read<AddressManager>().setZipCode(zipCodeData);
  }
}
