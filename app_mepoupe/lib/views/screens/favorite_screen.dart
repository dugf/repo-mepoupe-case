import 'package:app_mepoupe/bloc/address.dart';
import 'package:app_mepoupe/bloc/address_manager.dart';
import 'package:app_mepoupe/datasources/db_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  DbUtil dbUtil = DbUtil();

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    final load =
        Provider.of<AddressManager>(context, listen: false).loadPlaces();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.2),
            Colors.white,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 30.0, left: 30.0, right: 30.0, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/icons/star_stroke_icon.png',
                      fit: BoxFit.fill,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      'Meus favoritos',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontFamily: 'Poppins',
                          fontSize: queryData.size.longestSide * 0.034,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: FutureBuilder(
                future: load,
                builder: (ctx, snapshot) => snapshot.connectionState ==
                        ConnectionState.waiting
                    ? Container(
                        color: Colors.transparent,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Consumer<AddressManager>(
                        child: const Center(
                          child: null,
                        ),
                        builder: (ctx, greatPlaces, ch) => greatPlaces
                                    .itemsCount ==
                                0
                            ? ch!
                            : ListView.builder(
                                itemCount: greatPlaces.itemsCount,
                                itemBuilder: (ctx, i) {
                                  final pathItem =
                                      greatPlaces.getItemByIndex(i);
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                pathItem.zipCode!,
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                              InkWell(
                                                child: Image.asset(
                                                  'assets/icons/delete_icon.png',
                                                  fit: BoxFit.fill,
                                                  width: 20,
                                                  height: 20,
                                                ),
                                                onTap: () {
                                                  showAlertDialog(
                                                      context, pathItem);
                                                },
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: FittedBox(
                                              child: pathItem
                                                      .complement!.isNotEmpty
                                                  ? Text('${pathItem.street} '
                                                      '- ${pathItem.complement} '
                                                      '- ${pathItem.city} '
                                                      '- CEP ${pathItem.zipCode}')
                                                  : Text('${pathItem.street} '
                                                      '- ${pathItem.city} '
                                                      '- CEP ${pathItem.zipCode}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, Address pathItem) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      onPressed: () {
        setState(() {
          dbUtil.deletePlace(int.parse(pathItem.id!));
        });
        Navigator.pop(context);
      },
    );

    Widget cancelButton = TextButton(
      child: const Text(
        "Cancelar",
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Deseja realmente remover?"),
      content: const Text("Esta ação não pode ser desfeita."),
      actions: [cancelButton, okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
