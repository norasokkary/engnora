import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:predicts_diabetes/home_screen.dart';

import 'JSON/reminder_model.dart';
import 'JSON/users.dart';
import 'SQLite/database_helper.dart';
import 'local_notifications_service.dart';

class ReminderScreen extends StatefulWidget {
  final Users? user;

  const ReminderScreen({super.key, this.user});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  List<Map<String, dynamic>> reminders = [];

  bool isReminderActive = true;

  @override
  void initState() {
    loadReminders();
    super.initState();
  }

  loadReminders() async {
    reminders = List<Map<String, dynamic>>.from(
        await DatabaseHelper.instance.getAllReminders());
    setState(() {});
    print("reminders length ${reminders.length}");
  }

  void addReminder(
    String medicineName,
    String dose,
    String repeat,
    DateTime selectedDateTime,
    bool isActive,
  ) async {
    reminders.add(ReminderModel(
      medicineName: medicineName,
      dose: dose,
      repeat: repeat,
      selectedDateTime: selectedDateTime.toString(),
      isActive: isActive.toString(),
    ).toMap());

    setState(() {});

    int res = await DatabaseHelper.instance.createReminder(
      ReminderModel(
        medicineName: medicineName,
        dose: dose,
        repeat: repeat,
        selectedDateTime: selectedDateTime.toString(),
        isActive: isActive.toString(),
      ),
    );

    print("res $res");
  }

  void deleteReminder(int index) {
    setState(() {
      reminders.removeAt(index);
    });
  }

  void openAddReminderDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController medicineController = TextEditingController();
        TextEditingController doseController = TextEditingController();
        TextEditingController repeatController = TextEditingController();
        DateTime selectedDateTime = DateTime.now();

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Add New Reminder',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: Icon(
                      isReminderActive ? Icons.toggle_on : Icons.toggle_off,
                      color: isReminderActive ? Colors.green : Colors.grey,
                      size: 30,
                    ),
                    onPressed: () {
                      setDialogState(() {
                        isReminderActive = !isReminderActive;
                      });
                    },
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: medicineController,
                    decoration: InputDecoration(labelText: 'Medicine Name'),
                  ),
                  TextField(
                    controller: doseController,
                    decoration: InputDecoration(labelText: 'Dose'),
                  ),
                  TextField(
                    controller: repeatController,
                    decoration: InputDecoration(labelText: 'Repeat Times'),
                    keyboardType: TextInputType.number,
                  ),
                  ListTile(
                    title: Text("Pick Date"),
                    subtitle:
                        Text(DateFormat('yyyy-MM-dd').format(selectedDateTime)),
                    trailing: Icon(Icons.calendar_today, color: Colors.blue),
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDateTime,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null) {
                        setDialogState(() {
                          selectedDateTime = pickedDate;
                        });
                      }
                    },
                  ),
                  ListTile(
                    title: Text("Pick Time"),
                    subtitle:
                        Text(DateFormat('HH:mm').format(selectedDateTime)),
                    trailing: Icon(Icons.access_time, color: Colors.blue),
                    onTap: () async {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                      );

                      if (pickedTime != null) {
                        setDialogState(() {
                          selectedDateTime = DateTime(
                            selectedDateTime.year,
                            selectedDateTime.month,
                            selectedDateTime.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                        });
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel', style: TextStyle(color: Colors.red)),
                ),
                TextButton(
                  onPressed: () async {
                    if (medicineController.text.isNotEmpty &&
                        doseController.text.isNotEmpty &&
                        repeatController.text.isNotEmpty) {
                      addReminder(
                        medicineController.text,
                        doseController.text,
                        repeatController.text,
                        selectedDateTime,
                        isReminderActive,
                      );
                      await LocalNotificationService.showBasicNotification(
                        id: 1,
                        title: medicineController.text,
                        body:
                            "Dose: ${doseController.text}\t Repeated: ${repeatController.text}\n",
                      );

                      await LocalNotificationService
                          .showDailyScheduledNotification(
                        id: 1,
                        title: medicineController.text,
                        body:
                            "Dose: ${doseController.text}\t Repeated: ${repeatController.text}\n",
                        time: selectedDateTime,
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Add', style: TextStyle(color: Colors.blue)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(user: widget.user)),
                (Route<dynamic> route) => false,
              ),
              icon: Icon(Icons.arrow_back),
            ),
            SizedBox(width: 100),
            Text('Reminders',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ],
        )),
      ),
      body: reminders.isEmpty
          ? Center(
              child: Text('No Reminders Yet',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
          : ListView.builder(
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(reminders[index]['medicineName']!),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) async {
                    await DatabaseHelper.instance
                        .deleteReminder(reminders[index]['medicineName']);
                    deleteReminder(index);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(15),
                      title: Text(
                        reminders[index]['medicineName']!,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dose: ${reminders[index]['dose']}'),
                          Text('Repeat: ${reminders[index]['repeat']} times'),
                          Text(
                              'Time: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(reminders[index]['selectedDateTime']))}'),
                          Text(
                            'Status: ${reminders[index]['isActive'] == 'true' ? 'Active' : 'Inactive'}',
                            style: TextStyle(
                              color: reminders[index]['isActive'] == 'true'
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // هنا يمكن لاحقًا إضافة نافذة تعديل التذكير
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddReminderDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
