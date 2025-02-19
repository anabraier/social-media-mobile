import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_mobile/components/like_button.dart';

class Posts extends StatefulWidget {
  const Posts({
    super.key, 
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
    //required this.time,
    });

  final String message;
  final String user;
  final String postId;
  final List<String> likes;

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {

  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef = 
      FirebaseFirestore.instance.collection('UserPosts').doc(widget.postId);

    if (isLiked) {
      postRef.update({'Likes':  FieldValue.arrayUnion([currentUser.email])});
    }else{
      postRef.update({'Likes': FieldValue.arrayRemove([currentUser.email])});
    }
  }

  //final String time;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          Column(
            children: [
              LikeButton(
                isLiked: isLiked, 
                onTap: toggleLike,
                ),
                const SizedBox(height: 5,),
                Text(widget.likes.length.toString())
            ],
          ),
          const SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.user),
              const SizedBox(height: 10,),
              Text(widget.message),
            ],
          ),
        ]
      )
    );
  }
}