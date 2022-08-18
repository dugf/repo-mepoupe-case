import 'package:app_mepoupe/bloc/address.dart';
import 'package:app_mepoupe/bloc/address_manager.dart';
import 'package:app_mepoupe/datasources/db_util.dart';
import 'package:app_mepoupe/resources/strings.dart';
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
                      Strings.iconStarFavorite,
                      fit: BoxFit.fill,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      Strings.myFavorites,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontFamily: Strings.fontPoppins,
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
                                                  Strings.iconDelete,
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
                                            child:
                                                pathItem.complement!.isNotEmpty
                                                    ? Text(
                                                        '${pathItem.street} '
                                                        '- ${pathItem.complement} '
                                                        '- ${pathItem.city} '
                                                        '- CEP ${pathItem.zipCode}',
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .longestSide *
                                                                .016),
                                                      )
                                                    : Text(
                                                        '${pathItem.street} '
                                                        '- ${pathItem.city} '
                                                        '- CEP ${pathItem.zipCode}',
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .longestSide *
                                                                .016),
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
    Widget okButton = TextButton(
      child: Text(
        Strings.okValidateAlert,
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
        Strings.cancelValidateAlert,
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text(Strings.titleFavoriteAlert),
      content: const Text(Strings.subtitleFavoriteAlert),
      actions: [cancelButton, okButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
