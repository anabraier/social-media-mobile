import 'package:flutter/material.dart';

class Detailbox extends StatelessWidget{
  final String text;
  final String sectionName;
  final VoidCallback onPressed;
  const Detailbox({super.key, required this.text, required this.sectionName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)
        ),
        padding: EdgeInsets.only(left: 15, bottom: 15),
        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sectionName),
              IconButton(
                onPressed: onPressed, 
                icon: Icon(Icons.edit, color: Colors.black,)
                )
            ],
          ),
          Text(text),
        ],
      ),
    );
  }
}