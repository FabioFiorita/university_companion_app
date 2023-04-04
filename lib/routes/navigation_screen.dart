import 'package:beamer/beamer.dart';
import 'package:c317_mobile/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../themes/color_schemes.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key, required this.initialIndex})
      : super(key: key);

  final int initialIndex;

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: lightColorScheme.primary,
        unselectedItemColor: lightColorScheme.onSurface,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(Icons.home_rounded),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(Icons.date_range_rounded),
            label: 'Horarios',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.userGraduate, size: 20),
            label: 'Notas',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(Icons.account_circle_rounded),
            label: 'Perfil',
          ),
        ],
        onTap: (index) {
          Beamer.of(context).update(
            configuration: RouteInformation(
              location: _getRoute(index),
            ),
            rebuild: false,
          );
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  String _getRoute(int index) {
    switch (index) {
      case 0:
        return '/';
      case 1:
        return '/schedule';
      case 2:
        return '/grades';
      case 3:
        return '/profile';
      default:
        return '/';
    }
  }
}
