import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);

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
              child: ListView(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '88330-301',
                                style: TextStyle(fontSize: 16),
                              ),
                              InkWell(
                                child: Image.asset(
                                  'assets/icons/delete_icon.png',
                                  fit: BoxFit.fill,
                                  width: 20,
                                  height: 20,
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: FittedBox(
                              child: Text(
                                  'Rua indaial - até 583 - Itajaí SC -CEP\n88303-301'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '88330-301',
                                style: TextStyle(fontSize: 16),
                              ),
                              InkWell(
                                child: Image.asset(
                                  'assets/icons/delete_icon.png',
                                  fit: BoxFit.fill,
                                  width: 20,
                                  height: 20,
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: FittedBox(
                              child: Text(
                                  'Rua indaial - até 583 - Itajaí SC -CEP\n88303-301'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '88330-301',
                                style: TextStyle(fontSize: 16),
                              ),
                              InkWell(
                                child: Image.asset(
                                  'assets/icons/delete_icon.png',
                                  fit: BoxFit.fill,
                                  width: 20,
                                  height: 20,
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: FittedBox(
                              child: Text(
                                  'Rua indaial - até 583 - Itajaí SC -CEP\n88303-301'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
