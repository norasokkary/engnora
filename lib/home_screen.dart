import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'JSON/users.dart';
import 'SQLite/database_helper.dart';
import 'custom_bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  final Users? user;
  const HomeScreen({super.key, this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime today = DateTime.now();
  List<DateTime> weekDays =
  List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
  int selectedDayIndex = 0;
  int selectedNavIndex = 0;
  List<Map<String, dynamic>> reminders = [];
  List<Map<String, dynamic>> remindersForSelectedDay = [];

  @override
  void initState() {
    super.initState();
    _loadReminders();
    getRemindersForSelectedDay();
  }

  void _loadReminders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedReminders = prefs.getString('reminders');
    if (storedReminders != null) {
      setState(() {
        reminders =
        List<Map<String, dynamic>>.from(json.decode(storedReminders));
      });
    }
  }

  void getRemindersForSelectedDay() async {
    String selectedDate =
    DateFormat('yyyy-MM-dd').format(weekDays[selectedDayIndex]);
    remindersForSelectedDay = List<Map<String, dynamic>>.from(
        await DatabaseHelper.instance.getAllReminders())
        .where((reminder) {
      return DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(reminder['selectedDateTime'])) ==
          selectedDate;
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNavigationBar(
        user: widget.user!,
        selectedIndex: selectedNavIndex,
        onTabTapped: (index) {
          setState(() {
            selectedNavIndex = index;
          });
          // يمكنك استخدام التنقل هنا حسب حاجتك
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الترحيب والايقونة
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [

                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('''          Hi, Welcome Back''',

                              style: TextStyle(color: Colors.blue)),
                          Text(widget.user?.fullName.toString() ?? "N/A",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/reminder',
                          arguments: widget.user);
                    },
                    child: Icon(Icons.notifications, color: Colors.blue),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // تواريخ الأسبوع أفقيًا
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(weekDays.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDayIndex = index;
                          getRemindersForSelectedDay();
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        padding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                          color: index == selectedDayIndex
                              ? Colors.blue
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text("${weekDays[index].day}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text(DateFormat('EEE')
                                .format(weekDays[index])
                                .toUpperCase()),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),

              SizedBox(height: 20),

              // قائمة التذكيرات لليوم المحدد
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Reminders for ${DateFormat('EEEE').format(weekDays[selectedDayIndex])}",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Column(
                      children: remindersForSelectedDay.map((reminder) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            title: Text(reminder['medicineName']),
                            subtitle: Text(DateFormat.yMMMd().add_jm().format(
                                DateTime.parse(reminder['selectedDateTime']))),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Services For You
              Text("Services For You",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () => Navigator.pushReplacementNamed(
                              context, '/reminder',
                              arguments: widget.user),
                          child: ServiceCard(
                            image: 'assets/reminder.png',
                            label: 'Reminder',
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/corneal-exam',
                            arguments: widget.user,
                          ),
                          child: ServiceCard(
                            image: 'assets/eye_scan.jpg',
                            label: 'Corneal examination',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/doctors'),
                          child: ServiceCard(
                            image: 'assets/doctor.jpg',
                            label: 'Doctors',
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, '/recommendation'),
                          child: ServiceCard(
                            image: 'assets/recommendation.png',
                            label: 'Recommendation',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String image;
  final String label;

  const ServiceCard({
    super.key,
    required this.image,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 180,
          width: double.infinity, // هنا عرض مرن
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}
