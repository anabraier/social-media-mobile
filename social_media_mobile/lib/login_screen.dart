import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_mobile/components/button.dart';
import 'package:social_media_mobile/components/text_field.dart';


class LoginScreen extends StatefulWidget {
  final Function()? onTap;
  const LoginScreen({super.key, required this.onTap});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // signin
  void signIn() async {
    showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator()));

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text, 
      password: _passwordController.text,);
    Navigator.pop(context);
  }

  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], 
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // logo
                const Icon(
                  Icons.lock,
                  size: 100,                
                ),
                const SizedBox(height: 50),
                // welcome message
                const Text(
                  "Welcome back!"
                ),
                const SizedBox(height:25),
                //email
                MyTextField(
                  controller: _emailController, 
                  hintText: 'Email', 
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                //password
                MyTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                //sign in butt
                MyButton(
                  onTap: signIn,
                  text: 'Sign In',
                ),
                const SizedBox(height: 25),
                Row(
                  children: <Widget>[
                    Text("Not a member?",
                      style: 
                      TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: 
                        Text("Register Now", 
                        style: 
                          TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                    ),
                  ]
                )
              ],
            )
            )
          )
        )
      );
  }
}
