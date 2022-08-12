import 'package:app_mepoupe/bloc/helpers/provider/screen_index_provider.dart';
import 'package:app_mepoupe/bloc/ui/screens/favorite_screen.dart';
import 'package:app_mepoupe/bloc/ui/screens/home_screen.dart';
import 'package:app_mepoupe/bloc/ui/screens/search_screen.dart';
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
    const FavoriteScreen(),
    const SearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenIndexProvider = Provider.of<ScreenIndexProvider>(context);
    int currentScreenIndex = screenIndexProvider.fetchCurrentScreenIndex;
    return Scaffold(
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
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/flag_home_icon.png'),
              size: 20,
            ),
            label: 'Procurar',
          ),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/icons/star_stroke_icon.png'),
                size: 20,
              ),
              label: 'Favoritos'),
        ],
      ),
    );
  }
}
