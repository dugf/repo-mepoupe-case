import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: queryData.size.height * 0.80 - kBottomNavigationBarHeight,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Olá,\nBem-vindo',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
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
                              child: Image.asset(
                                'assets/icons/flag_home_icon.png',
                                scale: 1.6,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const Flexible(
                              child: FittedBox(
                                child: Text(
                                  '525',
                                  style: TextStyle(
                                      fontSize: 50, color: Colors.white),
                                ),
                              ),
                            ),
                            const Flexible(
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
              width: MediaQuery.of(context).size.width * 0.8,
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
                        scale: 1,
                        fit: BoxFit.fill,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'CEPs salvos',
                          style: TextStyle(
                              fontSize: 18,
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
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: Theme.of(context).primaryColor,
          onTap: (int index) {},
          currentIndex: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/icons/home_icon.png'),
                size: 50,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/icons/explore_icon.png'),
                size: 50,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/icons/favorite_icon.png'),
                size: 50,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
