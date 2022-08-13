import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textNumberEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);

    return Column(
      children: [
        Container(
          height: queryData.size.height * 0.4 - kBottomNavigationBarHeight,
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 20),
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
                      fontSize: MediaQuery.of(context).size.longestSide * 0.034,
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
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide.none),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/icons/search_icon.png',
                          fit: BoxFit.fill,
                          width: 20,
                          height: 20,
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
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
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
                  const Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                          'Rua indaial - até 583 - Itajaí SC -\nCEP 88303-301'),
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
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
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
            ),
          ),
        ),
      ],
    );
  }
}
