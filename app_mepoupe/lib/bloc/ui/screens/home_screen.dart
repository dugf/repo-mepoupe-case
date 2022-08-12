import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: queryData.size.height * 0.80 - kBottomNavigationBarHeight,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        text: TextSpan(
                          text: 'Olá,\n',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: queryData.size.longestSide * 0.034,
                              fontWeight: FontWeight.w500),
                          children: const <TextSpan>[
                            TextSpan(
                              text: 'Bem-vindo',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: queryData.size.height * 0.02,
                    child: SizedBox(
                      width: queryData.size.width,
                      height: queryData.size.height * 0.66 -
                          kBottomNavigationBarHeight,
                      child: Image.asset(
                        'assets/images/image_background_home_screen.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    top: queryData.size.height * 0.54 -
                        kBottomNavigationBarHeight,
                    child: Container(
                      height: queryData.size.width * 0.46,
                      width: queryData.size.width * 0.46,
                      decoration: const BoxDecoration(
                        color: Color(0xff6d51ff),
                        borderRadius: BorderRadius.all(Radius.circular(200)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Image.asset(
                                'assets/icons/flag_home_icon.png',
                                fit: BoxFit.fill,
                                scale: 1,
                              ),
                            ),
                            const Flexible(
                              flex: 2,
                              child: FittedBox(
                                child: Text(
                                  '525',
                                  style: TextStyle(
                                      fontSize: 100, color: Colors.white),
                                ),
                              ),
                            ),
                            const Flexible(
                              flex: 1,
                              child: FittedBox(
                                child: Text(
                                  'CEPs pesquisados',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: queryData.size.width * 0.8,
              child: Card(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
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
                        'assets/icons/flag_Icon.png',
                        fit: BoxFit.fill,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'CEPs salvos',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Container(
                        width: 20.0,
                        height: 20.0,
                        decoration: const BoxDecoration(
                          color: Color(0xff6d51ff),
                          borderRadius: BorderRadius.all(Radius.circular(200)),
                        ),
                        child: const Center(
                          child: Text(
                            '3',
                            style: TextStyle(color: Colors.white),
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
    );
  }
}
