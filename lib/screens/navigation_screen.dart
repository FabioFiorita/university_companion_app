import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../themes/color_schemes.dart';

class NavigationScreen extends StatefulWidget {
  final Widget child;

  NavigationScreen({Key? key, required this.child}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).focusColor,
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
          context.go(_getRoute(index));
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
        return '/classes';
      case 2:
        return '/subjects';
      case 3:
        return '/profile';
      default:
        return '/home';
    }
  }
}
