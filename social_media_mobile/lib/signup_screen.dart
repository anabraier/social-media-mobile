import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_mobile/components/button.dart';
import 'package:social_media_mobile/components/text_field.dart';


class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passConfirmController = TextEditingController();


  // signin
  void signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text, 
      password: _passwordController.text,);
  }

  // signup
  void signUp() async {
    showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator()));

    if (_passwordController.text != _passConfirmController.text) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Password don't match")
        )
      );
        return; 
    } else {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
    } 
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
                  "Let's create an account!"
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
                //password confirm
                MyTextField(
                  controller: _passConfirmController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                //sign up butt
                MyButton(
                  onTap: signUp, 
                  text: 'Sign Up',
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",
                      style: 
                      TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                    ),
                    const SizedBox(height: 4),
                    //register page
                    GestureDetector(
                      onTap: widget.onTap,
                      child: 
                        Text("Login Here", 
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
