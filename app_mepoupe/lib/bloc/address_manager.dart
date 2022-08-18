import 'dart:math';
import 'package:app_mepoupe/bloc/address.dart';
import 'package:app_mepoupe/datasources/db_util.dart';
import 'package:app_mepoupe/datasources/via_cep_service.dart';
import 'package:app_mepoupe/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressManager extends ChangeNotifier {
  Address? address;
  List<Address> _items = [];
  String counter = Strings.initializeNumberCounter;
  String? returnScreen = Strings.returnNoneSearchType;

  //FUNÇÃO RESPONSÁVEL POR BUSCAR OS DADOS DA API E PREENCHER A INTERFACE DE ADDRESS
  Future<void> getAddress(String cep) async {
    final ViaCepService viaCepAddress = ViaCepService();
    try {
      final addressViaCep = await viaCepAddress.getAddressFromCEP(cep);
      address = Address(
        street: addressViaCep.logradouro,
        district: addressViaCep.bairro,
        complement: addressViaCep.complemento!.contains('-')
            ? addressViaCep.complemento
                ?.substring(0, addressViaCep.complemento?.indexOf('-'))
            : addressViaCep.complemento,
        zipCode: addressViaCep.cep,
        city: addressViaCep.localidade,
        state: addressViaCep.uf,
      );
      notifyListeners();
    } catch (e) {
      return;
    }
  }

  //CARREGA OS LUGARES SALVOS DO SQFLITE
  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('places');
    _items = dataList
        .map(
          (item) => Address(
            id: item['id'],
            zipCode: item['titlecep'],
            street: item['address'],
            number: item['number'],
            complement: item['complement'],
            district: item['district'],
            city: item['city'],
            state: item['state'],
          ),
        )
        .toList();

    notifyListeners();
  }

  List<Address> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Address getItemByIndex(int index) {
    return _items[index];
  }

  //ADC CADA LOCAL NO SQFLITE
  Future<void> addPlace(String? title, String? address, String? number,
      String? complement, String? district, String? city, String? state) async {
    final newPlace = Address(
      id: Random().nextInt(99999).toString(),
      zipCode: title,
      street: address,
      number: number,
      complement: complement,
      district: district,
      city: city,
      state: state,
    );

    _items.add(newPlace);
    DbUtil.insert('places', {
      'id': newPlace.id!,
      'titlecep': newPlace.zipCode ?? Strings.emptyText,
      'address': newPlace.street ?? Strings.emptyText,
      'number': newPlace.number ?? Strings.emptyText,
      'complement': newPlace.complement ?? Strings.emptyText,
      'district': newPlace.district ?? Strings.emptyText,
      'city': newPlace.city ?? Strings.emptyText,
      'state': newPlace.state ?? Strings.emptyText,
    });
    notifyListeners();
  }

  Future<void> addCounter(int? count) async {
    final prefs = await SharedPreferences.getInstance();
    if (count != null) {
      final addition = count + 1;
      await prefs.setInt('counter', addition);
    }
    notifyListeners();
  }

  Future<void> getCounter() async {
    final prefs = await SharedPreferences.getInstance();
    final returnCountShared = prefs.getInt('counter') ?? 0;
    counter = returnCountShared.toString();
    notifyListeners();
  }

  Future<void> setScreen(String textScreen) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('returnScreen', textScreen);
    notifyListeners();
  }

  Future<void> getScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final getScreenData = prefs.getString('returnScreen');
    returnScreen = getScreenData ?? Strings.returnNoneSearchType;
    notifyListeners();
  }

  Future<void> setZipCode(String textZipCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('returnCep', textZipCode);
    notifyListeners();
  }
}
