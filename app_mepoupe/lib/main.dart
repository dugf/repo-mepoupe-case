import 'package:app_mepoupe/bloc/address_manager.dart';
import 'package:app_mepoupe/bloc/screen_index_provider.dart';
import 'package:app_mepoupe/resources/strings.dart';
import 'package:app_mepoupe/views/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    funcInitShared();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ScreenIndexProvider()),
        ChangeNotifierProvider(
          create: (context) => AddressManager(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Me Poupe',
        theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: Colors.indigo,
          primaryColor: const Color(0xff6d51ff),
        ),
        home: const SplashScreen(),
      ),
    );
  }

  funcInitShared() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('returnScreen', Strings.returnNoneSearchType);
  }
}
