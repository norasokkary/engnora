import 'package:flutter/material.dart';

import 'JSON/users.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final Users user;

  final int selectedIndex;
  final Function(int) onTabTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.user,
    required this.selectedIndex,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        if (index == selectedIndex) return; // منع إعادة تحميل نفس الصفحة

        Widget nextScreen;
        switch (index) {
          case 0:
            nextScreen = HomeScreen(user: user);
            break;
          case 1:
            nextScreen = ProfileScreen(user: user);
            break;
          case 2:
            nextScreen = SettingsScreen(user: user);
            break;
          default:
            return;
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => nextScreen),
        );
      },
      backgroundColor: Colors.blue, // الخلفية الزرقاء
      selectedItemColor: Colors.white, // لون الأيقونات عند اختيارها
      unselectedItemColor:
          Colors.white.withOpacity(0.6), // لون الأيقونات غير المختارة
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
