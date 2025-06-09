import 'package:flutter/material.dart';
import 'package:predicts_diabetes/Components/button.dart';
import 'package:predicts_diabetes/Components/textfield.dart';
import 'package:predicts_diabetes/JSON/users.dart';
import 'package:predicts_diabetes/SQLite/database_helper.dart';
import 'package:predicts_diabetes/Views/signup.dart';
import 'package:predicts_diabetes/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool isLoginTrue = false;
  final db = DatabaseHelper.instance;

  Future<void> login() async {
    var res = await db
        .authenticate(Users(email: email.text, password: password.text));
    if (res && mounted) {
      final user = await db.getUserByEmail(email.text);
      print("user ${user?.usrId}");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomeScreen(user: user)));
    } else {
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              InputField(hint: "Email", icon: Icons.email, controller: email),
              InputField(
                  hint: "Password",
                  icon: Icons.lock,
                  controller: password,
                  passwordInvisible: true),
              const SizedBox(height: 20),
              Button(
                label: "LOGIN",
                press: login,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? ",
                      style: TextStyle(color: Colors.grey)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen()));
                    },
                    child: const Text("Sign Up",
                        style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
              if (isLoginTrue)
                const Text(
                  "Email or password is incorrect",
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
