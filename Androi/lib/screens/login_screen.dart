import 'dart:convert';

import 'package:badmintonbuddy/screens/home_screen.dart';
import 'package:badmintonbuddy/screens/signup_screen.dart';
import 'package:badmintonbuddy/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../auth_service.dart';
import '../utils/app_api_list.dart';
import '../widgets/home_screen_with_bottom_bar.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

void goBack(BuildContext context) {
  // final cartItemsNotifier = Provider.of<CartItemsNotifier>(context, listen: false);
  // cartItemsNotifier.clearCart();
  Navigator.pop(context); // Use Navigator.pop to go back to the previous screen
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true; // Initialize _obscurePassword as true

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Styles.textColor),
        automaticallyImplyLeading: false, // Remove the default back button
        title: Row(
          children: [
            Container(
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreenWithBottomBar()),
                  );
                  // Handle custom back button press
                },
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "Login",
                  style: Styles.headLineStyle23.copyWith(color: Styles.textColor),
                ),
              ),
            ),
            Container(width: 48), // Adjust the width to your preference
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Welcome back",
              style: Styles.headLineStyle1.copyWith(color: Styles.textColor),
            ),
            SizedBox(height: 5),
            GestureDetector(
              child: RichText(
                text: TextSpan(
                  text: "Don't have a Badminton Buddy account yet? ",
                  style: Styles.headLineStyle4.copyWith(color: Styles.textColor),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Sign Up",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print(AuthService().isLoggedIn);
                          // Handle "Sign Up" text click
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                        },
                    ),
                  ],

                ),
              ),
            ),
            SizedBox(height: 40),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: _obscurePassword, // Use obscureText to hide/show password
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: login,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20), // Add padding
                primary: Styles.secPrimaryColor, // Set the background color
              ),
              child: Text(
                "Log In",
                style: Styles.textStyle.copyWith(color: Colors.white),
              ),
            ),

          ],
        ),
      ),
    );
  }
  Future<void> login() async {
    // final url = Uri.parse(APIs.loginUrl);
    //
    final email = emailController.text;
    final password = passwordController.text;
    // print('Email: $email');
    // print('Password: $password');
    //
    // final requestBody = {
    //   'email': email,
    //   'password': password,
    // };
    //
    // try {
    //   final response = await http.post(url, body: requestBody);
    //
    //   print('Response: ${response.body}');
    //
    //   if (response.statusCode == 200) {
    //     final data = json.decode(response.body);
    //     print('Data: $data');
    //
    //     if (data['success']) {
    //       final levelId = data['level_id'].toString(); // Ensure it's treated as a string
    //       await saveUserLevelId(levelId);
    //       // Set the user's login status to true
    //       await saveUserLoginStatus(true);
    //       // Call AuthService to log in
    await AuthService().login(email, password, context);

    //
    //
    //       if (levelId == "3") {
    //         // Navigator.push(
    //         //   context,
    //         //   MaterialPageRoute(builder: (context) => HomeScreen()),
    //         // );
    //       } else if (levelId == "2") {
    //         // Seller user
    //         // Handle accordingly
    //       } else if (levelId == "1") {
    //         // Admin user
    //         // Handle accordingly
    //       }
    //     } else {
    //       final error = data['error'];
    //       print('Login failed: $error');
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text('Login failed: $error')),
    //       );
    //     }
    //   } else {
    //     print('Login failed2: ${response.statusCode}');
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Login failed2: ${response.statusCode}')),
    //     );
    //   }
    // } catch (e) {
    //   print('Login failed3: $e');
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Login failed3: $e')),
    //   );
    // }
  }


  Future<void> saveUserLevelId(String levelId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userLevelId', levelId);
  }

  Future<int> getUserLevelId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userLevelId') ?? 0;
  }

  Future<void> saveUserLoginStatus(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<bool> getUserLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}



