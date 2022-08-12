import 'package:app_mepoupe/bloc/helpers/provider/screen_index_provider.dart';
import 'package:app_mepoupe/bloc/ui/widgets/bottom_navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ScreenIndexProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Me Poupe',
        theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: Colors.indigo,
          primaryColor: const Color(0xff6d51ff),
        ),
        home: const BottomNavigationWidget(),
      ),
    );
  }
}
