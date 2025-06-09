import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'JSON/users.dart';
import 'custom_bottom_navigation.dart';

class SettingsScreen extends StatefulWidget {
  final Users? user;

  const SettingsScreen({super.key, this.user});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool isNotificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('darkMode') ?? false;
      isNotificationsEnabled = prefs.getBool('notifications') ?? true;
    });
  }

  void _updateSetting(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  int selectedNavIndex = 2; // الإعدادات هي الصفحة الثالثة في البار السفلي

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Settings',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        user: widget.user!,
        selectedIndex: selectedNavIndex,
        onTabTapped: (index) {
          if (index != selectedNavIndex) {
            if (index == 0) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (index == 1) {
              Navigator.pushReplacementNamed(context, '/profile');
            }
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // إضافة التمرير
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Privacy and Security Policy",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10),
              Text(
                "At our application, your privacy and security are very important to us. \nWe are committed to protecting your personal information and ensuring that it is never shared with third parties without your consent."
                    "We follow industry standards and best practices to safeguard your data. \nAll the information you provide is stored securely and is used only for improving your experience within the app."
                    "We do not collect or distribute political opinions or sensitive data, and we strongly believe in respecting users’ freedom and privacy.\n"
                    "Please use the app responsibly, and do not share your login credentials or personal details with anyone. \nIf you have any questions or concerns about how we handle your information, feel free to reach out to us through the support section."
                    "Your trust means everything to us.",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    shadowColor: Colors.red.shade600,
                    alignment: Alignment.center,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          AlertDialog(
                            title: Text("تأكيد تسجيل الخروج"),
                            content: Text(
                                "هل أنت متأكد أنك تريد تسجيل الخروج؟"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("إلغاء"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/auth');
                                },
                                child: Text("تأكيد",
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                    );
                  },
                  child: Text(
                    "Log out",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
