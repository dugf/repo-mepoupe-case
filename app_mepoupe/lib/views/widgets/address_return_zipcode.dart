import 'package:app_mepoupe/bloc/address.dart';
import 'package:app_mepoupe/bloc/address_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressReturnZipcode extends StatefulWidget {
  final Address address;
  final bool? colorFavoriteZipCode;
  const AddressReturnZipcode(
      {Key? key, required this.address, required this.colorFavoriteZipCode})
      : super(key: key);

  @override
  State<AddressReturnZipcode> createState() => _AddressReturnZipcodeState();
}

class _AddressReturnZipcodeState extends State<AddressReturnZipcode> {
  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    bool? colorFavoriteZipCode = widget.colorFavoriteZipCode;

    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              'Endereço:',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: widget.address.complement != null &&
                      widget.address.complement!.isNotEmpty
                  ? Text('${widget.address.street} '
                      '- ${widget.address.complement} '
                      '- ${widget.address.city} '
                      '- CEP ${widget.address.zipCode}')
                  : Text('${widget.address.street} '
                      '- ${widget.address.city} '
                      '- CEP ${widget.address.zipCode}'),
            ),
          ),
          Flexible(
            child: SizedBox(
              width: queryData.size.width,
              child: ElevatedButton(
                onPressed: () {
                  if (Form.of(context)!.validate() &&
                      colorFavoriteZipCode == false) {
                    currentZipCode(context);
                    if (widget.address.zipCode != null &&
                        widget.address.zipCode!.isNotEmpty) {
                      colorFavoriteZipCode = true;
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: colorFavoriteZipCode == true
                        ? Colors.white
                        : const Color.fromRGBO(46, 23, 157, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    elevation: colorFavoriteZipCode == true ? 4 : null),
                child: Row(
                  children: [
                    Image.asset(
                      colorFavoriteZipCode == true
                          ? 'assets/icons/colored_star_icon.png'
                          : 'assets/icons/star_stroke_icon.png',
                      fit: BoxFit.fill,
                    ),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: FittedBox(
                          child: colorFavoriteZipCode == true
                              ? Text(
                                  'Adicionado aos favoritos',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor),
                                )
                              : const Text(
                                  'Adicionar aos favoritos',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  currentZipCode(BuildContext context) {
    context.read<AddressManager>().addPlace(
        widget.address.zipCode,
        widget.address.street,
        widget.address.number,
        widget.address.complement,
        widget.address.district,
        widget.address.city,
        widget.address.state);
  }
}
