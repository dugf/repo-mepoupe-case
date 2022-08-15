import 'package:app_mepoupe/bloc/screen_index_provider.dart';
import 'package:app_mepoupe/resources/strings.dart';
import 'package:app_mepoupe/views/screens/favorite_screen.dart';
import 'package:app_mepoupe/views/screens/home_screen.dart';
import 'package:app_mepoupe/views/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  List<dynamic> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const FavoriteScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenIndexProvider = Provider.of<ScreenIndexProvider>(context);
    int currentScreenIndex = screenIndexProvider.fetchCurrentScreenIndex;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: screens[currentScreenIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: Theme.of(context).primaryColor,
          selectedLabelStyle: const TextStyle(fontSize: 12),
          currentIndex: currentScreenIndex,
          onTap: (value) => screenIndexProvider.updateScreenIndex(value),
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/icons/home_icon.png'),
                size: 20,
              ),
              label: Strings.labelHome,
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/icons/flag_home_icon.png'),
                size: 20,
              ),
              label: Strings.labelSearch,
            ),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/icons/star_stroke_icon.png'),
                  size: 20,
                ),
                label: Strings.labelFavorites),
          ],
        ),
      ),
    );
  }
}
