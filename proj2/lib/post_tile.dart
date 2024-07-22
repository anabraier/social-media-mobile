import 'package:flutter/material.dart';

class PostTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  const PostTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      onTap: onTap,
      title: Text(text, style: TextStyle(color: Colors.white),),
    );
  }
}