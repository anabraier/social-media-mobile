import 'package:proj2/auth.dart';
import 'package:proj2/profilepage.dart';
import 'package:proj2/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class LogIn extends StatefulWidget {
  LogIn({super.key});

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color.fromARGB(153, 255, 181, 107),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('LogIn Below!',
              style: TextStyle(
                fontSize: 35, 
                color: Colors.black,
                fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 20,),
              emailItem('Enter Email', _emailCtrl,false),
              SizedBox(height: 16,),
              emailItem('Enter Password', _passCtrl,true),
              SizedBox(height: 16,),
              registerButton(),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap:() {
                      Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (builder) => Register()), (route) => false);
                    },
                    child: Text('Register here if a new user!', 
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),)
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget emailItem(String labeltext, TextEditingController controller, bool obscureText) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 55,
      child: TextFormField(
        controller: controller,
        style: TextStyle(fontSize: 17),
        decoration: InputDecoration(
          labelText: labeltext,
          labelStyle: TextStyle(
            fontSize: 17,
            color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 81, 43, 7),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 81, 43, 7),
            ),
          ),
        ),
      ),
    );
  }
  Widget registerButton() {
    return InkWell(
      onTap: () async {
        try{
          firebase_auth.UserCredential userCredential = 
          await firebaseAuth.signInWithEmailAndPassword(email: _emailCtrl.text, password: _passCtrl.text);

          print(userCredential.user);
          Navigator.pushAndRemoveUntil(
          context, 
          MaterialPageRoute(
            builder: (builder) => AuthPage()), 
          (route) => false);
        } catch(e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);

        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width-90,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            Colors.black,
            Colors.black87,
            Colors.black54,
            ]
          )
        ),
        child: Center(
          child: Text('Log In',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      )
    );
  }
}