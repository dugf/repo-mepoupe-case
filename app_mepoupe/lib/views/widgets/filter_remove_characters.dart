import 'package:flutter/services.dart';

class FilterRemoveCharacters extends TextInputFormatter {
  static final _reg = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return _reg.hasMatch(newValue.text) ? newValue : oldValue;
  }
}
