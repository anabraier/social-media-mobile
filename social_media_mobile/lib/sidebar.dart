import 'package:flutter/material.dart';
import 'package:social_media_mobile/post_tile.dart';


class Sidebar extends StatelessWidget {
  const Sidebar({super.key, required this.onProfileTap, required this.onSignOut});
  final VoidCallback onProfileTap;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 81, 43, 7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 64,
                ),
              ),

              PostTile(
                icon: Icons.home, 
                text: 'H O M E', 
                onTap: () => Navigator.pop(context),
                ),
              PostTile(
                icon: Icons.person, 
                text: 'P R O F I L E', 
                onTap: onProfileTap,
                ),
            ]
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: PostTile(
                icon: Icons.logout, 
                text: 'L O G O U T', 
                onTap: onSignOut
                ),
          )
        ]
      ),
    );
  }
}