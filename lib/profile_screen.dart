import 'dart:io';
import 'package:flutter/material.dart';
import 'package:predicts_diabetes/JSON/users.dart';
import 'package:predicts_diabetes/SQLite/database_helper.dart';
import 'EditProfileScreen.dart';
import 'custom_bottom_navigation.dart';

class ProfileScreen extends StatefulWidget {
  final Users user;

  const ProfileScreen({super.key, required this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Users currentUser;
  int selectedNavIndex = 1;

  @override
  void initState() {
    super.initState();
    currentUser = widget.user;
    _reloadUser();
  }

  Future<void> _reloadUser() async {
    if (currentUser.usrId != null) {
      final freshUser = await DatabaseHelper.instance.getUserById(currentUser.usrId!);
      if (freshUser != null) {
        setState(() {
          currentUser = freshUser;
        });
      }
    } else {
      // يمكن هنا تعالج حالة عدم وجود usrId، مثلاً تطبع رسالة أو تتجاهل
      print('User ID is null, cannot reload user');
    }
  }


  Future<void> _navigateToEditProfile() async {
    final updatedUser = await Navigator.push<Users>(
      context,
      MaterialPageRoute(builder: (_) => EditProfileScreen(user: currentUser)),
    );

    if (updatedUser != null) {
      await _reloadUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _navigateToEditProfile,
            tooltip: "Edit Profile",
          )
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        user: currentUser,
        selectedIndex: selectedNavIndex,
        onTabTapped: (index) {
          if (index != selectedNavIndex) {
            if (index == 0) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (index == 2) {
              Navigator.pushReplacementNamed(context, '/settings');
            }
          }
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: currentUser.profilePhotoPath != null
                  ? FileImage(File(currentUser.profilePhotoPath!))
                  : const AssetImage('assets/profile.jpg') as ImageProvider,
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.person, color: Colors.blue),
                title: const Text("Full Name", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(currentUser.fullName ?? 'N/A'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.email, color: Colors.blue),
                title: const Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(currentUser.email),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.phone, color: Colors.blue),
                title: const Text("Phone Number", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(currentUser.phoneNumber ?? 'N/A'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.favorite, color: Colors.blue),
                title: const Text("Blood Sugar Level", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(currentUser.bloodSugarLevel ?? 'Not set'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
