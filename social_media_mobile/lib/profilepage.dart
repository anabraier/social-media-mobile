import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_mobile/posts.dart';

import 'package:social_media_mobile/sidebar.dart';
import 'package:social_media_mobile/personal_prof.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final currentUser = FirebaseAuth.instance.currentUser!;
  final postController = TextEditingController();

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void postMessage() {
    if (postController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentUser.email,
        'Post': postController.text,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
      });
    }
    setState(() {
      postController.clear();
    });
  }

  void goToProfile(){
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PersonalProf(),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile Page'),
        backgroundColor: Colors.white
      ),
      drawer: Sidebar(
        onProfileTap: goToProfile,
        onSignOut: signOut,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
              .collection('User Posts')
              .orderBy("TimeStamp", descending: false)
              .snapshots(), 
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data!.docs[index];
                      return Posts(
                        message: post['Post'], 
                        user: post['UserEmail'],
                        postId: post.id,
                        likes: List<String>.from(post['Likes'] ?? []), 
                        //time: post[]
                        );
                    });
                } else if(snapshot.hasError){
                  return Center(
                    child: Text("Error: + ${snapshot.error}"),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: postController,
                    decoration: new InputDecoration(hintText: "Post something on the wall..."),
                    obscureText: false,
                  )
                  ),
                  IconButton(
                    onPressed: postMessage, 
                    icon: const Icon(Icons.arrow_circle_up))
              ],
            ),
          ),

          Text('Logged in as:' + currentUser.email!,
          style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}