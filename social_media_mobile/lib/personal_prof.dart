import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_mobile/detailbox.dart';

class PersonalProf extends StatefulWidget {
  const PersonalProf({super.key});

  @override
  State<PersonalProf> createState() => _PersonalProfState();
}
class _PersonalProfState extends State<PersonalProf>{

  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection('Users');

  Future<void> editField(String field) async {
    String newValue = '';
    await showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("Edit " + field),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter new $field',
            hintStyle: TextStyle(color: Colors.black)
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: Text('Cancel', style: TextStyle(color: Colors.white),)
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(newValue), 
            child: Text('Save', style: TextStyle(color: Colors.white),)
          ),
        ],
      ));

      if (newValue.trim().length > 0) {
        await usersCollection.doc(currentUser.email).update({field: newValue});
      }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(153, 255, 181, 107),
      appBar: AppBar(
        title: Text('Personal Profile', style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 81, 43, 7),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser.email)
        .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              children: [
                const SizedBox(height: 50,),
                Icon(
                  Icons.person, 
                  size: 72
                ),

                const SizedBox(height: 10,),
  // usr email
                Text(
                  currentUser.email!, 
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 50,),

  //usr deets
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'My Bio',
                    style: TextStyle(color: Colors.white),
                  ),  
                ),

  // username
                Detailbox(
                  text: userData['username'], 
                  sectionName: 'username', 
                  onPressed: () => editField('username'),
                  ),

// bio
                Detailbox(
                  text: userData['bio'], 
                  sectionName: 'My Bio', 
                  onPressed: () => editField('bio'),
                  ),
                  const SizedBox(height: 30,),

  // usr posts
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      'My Posts',
                      style: TextStyle(color: Colors.white),
                  ),  
                ),
              ],
            );
          } else if(snapshot.hasError){
            return Center(
              child: Text('Error${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        } ,

        ),
  
    );
  }
}