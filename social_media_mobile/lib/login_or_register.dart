import 'package:flutter/material.dart';
import 'package:social_media_mobile/signup_screen.dart';
import 'login_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override 
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      // login_screen.dart
      return LoginScreen(onTap: togglePages);
    } else {
      // signup_screen.dart
      return RegisterPage(onTap: togglePages);
    }
  }
}