import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_mobile/components/text_field.dart';
import 'package:social_media_mobile/components/wall_post.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
final textController = TextEditingController();

  //sign out
  void signOut() {
    FirebaseAuth.instance.signOut();
  }
//post message
  void postMessage() {
    if (textController.text.isNotEmpty) {}
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'TimeStamp': Timestamp.now()
    });

    setState(() {
      textController.clear();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts~"),
      actions: [
        //sign out butt
        IconButton(
          onPressed: signOut, 
          icon: Icon(Icons.logout)
        ),
      ],
      ),
      body: Center(
        child: Column(
          children: [
            // the wlal
            Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                .collection("User Posts")
                .orderBy("TimeStamp", 
                descending: false)
                .snapshots(), 
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data!.docs[index];
                      return WallPost(
                        message: post['Message'],
                        user: post['UserEmail'],
                        postId: post[''],
                        likes: post['Likes'],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error has occurred"),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
              ),
            ),
            // the posts
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: textController,
                      hintText: "Write something for the wall!",
                      obscureText: false,
                    )
                  ),
                  IconButton(onPressed: postMessage, icon: const Icon(Icons.arrow_circle_down))
                ],
              ),
            ),
            // text logged in as
            Text("Logged in as: " + currentUser.email!)
          ],
        )
      )
    );
  }
}