import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_mobile/detailbox.dart';

class PersonalProf extends StatefulWidget {
  const PersonalProf({super.key});

  @override
  State<PersonalProf> createState() => _PersonalProfState();
}

class _PersonalProfState extends State<PersonalProf> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  String displayName = '';
  String email = '';
  String photoURL = '';

  @override
  void initState() {
    super.initState();
    // Initialize user info from Firebase Authentication
    displayName = currentUser.displayName ?? 'No display name';
    email = currentUser.email ?? 'No email';
    photoURL = currentUser.photoURL ?? 'No photo URL';
  }

  Future<void> editDisplayName() async {
    String newDisplayName = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Display Name"),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Enter new display name',
          ),
          onChanged: (value) {
            newDisplayName = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await currentUser.updateDisplayName(newDisplayName);
              setState(() {
                displayName = newDisplayName;
              });
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> editPhotoURL() async {
    String newPhotoURL = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Photo URL"),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Enter new photo URL',
          ),
          onChanged: (value) {
            newPhotoURL = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await currentUser.updatePhotoURL(newPhotoURL);
              setState(() {
                photoURL = newPhotoURL;
              });
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(153, 255, 181, 107),
      appBar: AppBar(
        title: Text('Personal Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 81, 43, 7),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 50),
          Icon(
            Icons.person,
            size: 72,
          ),
          const SizedBox(height: 10),
          // User email
          Text(
            email,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          // User details
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'My Bio',
              style: TextStyle(color: Colors.white),
            ),
          ),
          // Display Name
          Detailbox(
            text: displayName,
            sectionName: 'Display Name',
            onPressed: editDisplayName,
          ),
          // Photo URL
          Detailbox(
            text: photoURL,
            sectionName: 'Photo URL',
            onPressed: editPhotoURL,
          ),
          const SizedBox(height: 30),
          // User posts (Placeholder since you are not using Firestore for posts)
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'My Posts',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
