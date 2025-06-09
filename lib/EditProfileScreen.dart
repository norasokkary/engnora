import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:predicts_diabetes/JSON/users.dart';
import 'package:predicts_diabetes/SQLite/database_helper.dart';

class EditProfileScreen extends StatefulWidget {
  final Users user;

  const EditProfileScreen({super.key, required this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController fullNameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController bloodSugarController;

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController(text: widget.user.fullName);
    phoneController = TextEditingController(text: widget.user.phoneNumber);
    emailController = TextEditingController(text: widget.user.email);
    bloodSugarController = TextEditingController(text: widget.user.bloodSugarLevel);
    if (widget.user.profilePhotoPath != null) {
      _selectedImage = File(widget.user.profilePhotoPath!);
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    bloodSugarController.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromGallery() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  Future<void> _saveChanges() async {
    if (emailController.text.isEmpty || widget.user.password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email and password are required!')),
      );
      return;
    }

    Users updatedUser = Users(
      usrId: widget.user.usrId,
      fullName: fullNameController.text,
      phoneNumber: phoneController.text,
      email: emailController.text,
      password: widget.user.password,
      bloodSugarLevel: bloodSugarController.text,
      profilePhotoPath: _selectedImage?.path ?? widget.user.profilePhotoPath,
    );

    await DatabaseHelper.instance.updateUser(updatedUser);

    Navigator.pop(context, updatedUser);
  }

  Widget buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          hintText: 'Enter your $label',
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImageFromGallery,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : (widget.user.profilePhotoPath != null
                      ? FileImage(File(widget.user.profilePhotoPath!))
                      : const AssetImage('assets/profile.jpg') as ImageProvider),
                  child: const Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 14,
                      child: Icon(Icons.edit, size: 18, color: Colors.blue),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              buildTextField(fullNameController, 'Full Name'),
              buildTextField(phoneController, 'Phone Number', keyboardType: TextInputType.phone),
              buildTextField(emailController, 'Email', keyboardType: TextInputType.emailAddress),
              buildTextField(bloodSugarController, 'Blood Sugar Level', keyboardType: TextInputType.number),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text("Save Changes", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
