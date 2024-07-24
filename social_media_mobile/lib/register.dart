import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proj2/auth.dart';
import 'package:proj2/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class Register extends StatefulWidget {
  Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
              Text('Register Here!',
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
                        context, MaterialPageRoute(builder: (builder) => LogIn()), (route) => false);
                    },
                    child: Text('For already exitsting users(LogIn)', 
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
        firebase_auth.UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: _emailCtrl.text, password: _passCtrl.text
        );
        print(userCredential.user);
        FirebaseFirestore.instance
        .collection('Users')
        .doc(userCredential.user!.email)
        .set({'username': _emailCtrl.text.split('@')[0], 'bio': 'Empty bio'});
        
       Navigator.pushAndRemoveUntil(
          context, 
          MaterialPageRoute(
            builder: (builder) => AuthPage()), 
          (route) => false);
        }
        //allows user to see they they need to input password
        //longer than 6 characters and/or that the email is already in use
        catch(e){
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
          child: Text('Register',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      )
    );
  }
}