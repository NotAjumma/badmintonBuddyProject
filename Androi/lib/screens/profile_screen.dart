import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth_service.dart';
import '../widgets/home_screen_with_bottom_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Add your profile content here

            // Add a logout button
            ElevatedButton(
              onPressed: () async {
                // Call the logout method from auth_service
                await AuthService().logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreenWithBottomBar()),
                );
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
