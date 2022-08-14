import 'package:app_mepoupe/bloc/address.dart';
import 'package:flutter/material.dart';

class AddressReturnZipcode extends StatelessWidget {
  final Address address;
  const AddressReturnZipcode({Key? key, required this.address})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);

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
              child: address.complement != null
                  ? Text('${address.street} '
                      '- ${address.complement} '
                      '- ${address.city} '
                      '- CEP ${address.zipCode}')
                  : Text('${address.street} '
                      '- ${address.city} '
                      '- CEP ${address.zipCode}'),
            ),
          ),
          SizedBox(
            width: queryData.size.width * 0.8,
            child: Card(
              color: const Color.fromRGBO(46, 23, 157, 1),
              elevation: 0,
              shape: const StadiumBorder(
                side: BorderSide(
                  color: Colors.transparent,
                  width: 2.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/star_stroke_icon.png',
                      fit: BoxFit.fill,
                    ),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: const FittedBox(
                          child: Text(
                            'Adicionar aos favoritos',
                            style: TextStyle(fontSize: 16, color: Colors.white),
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
}
