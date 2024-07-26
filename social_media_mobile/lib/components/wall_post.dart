import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_mobile/components/comment_button.dart';
import 'package:social_media_mobile/components/like_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_mobile/helper/help_methods.dart';
import 'package:social_media_mobile/components/comment.dart';




class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final List<String> likes;

  const WallPost({
    super.key,
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
  });

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
    // user
    final currentUser = FirebaseAuth.instance.currentUser!;
    bool isLiked = false;

    final _commentTextController = TextEditingController();

    @override
    void initState() {
      super.initState();
      isLiked = widget.likes.contains(currentUser.email);
    }

    void toggleLike() {
       setState(() {
        isLiked = !isLiked;
       });
    // Access firebase doc
      DocumentReference postRef = 
        FirebaseFirestore.instance.collection('UserPosts').doc(widget.postId);

      if (isLiked) {
        postRef.update({
          'Likes': FieldValue.arrayUnion([currentUser.email])
        });
      } else {
        postRef.update({
          'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

    void addComment(String commentText) {
      FirebaseFirestore.instance
      .collection("UserPosts")
      .doc(widget.postId)
      .collection("Comments")
      .add({
        "CommentText": commentText,
        "CommentedBy": currentUser.email,
        "CommentTime": Timestamp.now()
      });
    }

    void showCommentDialog() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Add Comment"),
          content: TextField(
            controller: _commentTextController,
            decoration: InputDecoration(hintText: "Write a comment!"),
          ),
          actions: [
            // make comment
            TextButton(
              onPressed: () { 
                addComment(_commentTextController.text);
                Navigator.pop(context);
                _commentTextController.clear();
              },
              child: Text("Post"),
            ),
          // cancel comment
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _commentTextController.clear();
              }, 
              child: Text("Cancel"),
            ),
          ]
        ),
      );
    }

    @override
    Widget build(BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
        padding: EdgeInsets.all(25.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 20),
            // buttons
              Row(
                children: [
                  // like button
                  Column(
                    children: [
                      LikeButton(
                        isLiked: isLiked,
                        onTap: toggleLike,
                      ),
                  
                      const SizedBox(height: 5),
                  
                    //like count
                    Text(
                      widget.likes.length.toString(),
                      style: const TextStyle(color: Colors.grey),
                    ),

                  const SizedBox(width: 20),
                    ],
                  ),

                    // message and user email
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                      const SizedBox(height: 10),
                      Text(widget.message),
                    ],
                  ),

              const SizedBox(width: 25),
                  // comment button
                  Column(
                    children: [
                      CommentButton(onTap: showCommentDialog),

                      const SizedBox(height: 5),
                    
                      Text(
                        '0',
                        style: const TextStyle(color: Colors.grey)
                      ),
                    ],
                  ),
                ],
              ),
              // comment
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("UserPosts").doc(widget.postId).collection("Comments").orderBy("CommentTime", descending: true,).snapshots(),
                builder: (context, snapshot) {
                  //show loading circle
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: 
                      snapshot.data!.docs.map((doc) {
                        //retrieve comment from firebase
                        final commentData = doc.data() as Map<String, dynamic>;
                        return Comment(
                          text: commentData["CommentText"], 
                          user: commentData["CommentedBy"], 
                          time: formatData(commentData["CommentTime"]),
                        );
                      }).toList(),
                  );
                },
                
              )
            ],
        ),
      );
    }
}
