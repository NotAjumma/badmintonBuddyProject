import 'dart:math';

import 'package:badmintonbuddy/screens/home_screen.dart';
import 'package:badmintonbuddy/screens/login_screen.dart';
import 'package:badmintonbuddy/utils/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../chats/api/apis.dart';
import '../utils/app_api_list.dart';
import '../widgets/home_screen_with_bottom_bar.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}










// Define controllers for the TextFields
final nameController = TextEditingController();
final mobileNumberController = TextEditingController();
final emailController = TextEditingController();
final passwordController = TextEditingController();


void goBack(BuildContext context) {
  // final cartItemsNotifier = Provider.of<CartItemsNotifier>(context, listen: false);
  // cartItemsNotifier.clearCart();
  Navigator.pop(context); // Use Navigator.pop to go back to the previous screen
}


bool isNameEmpty(String name) {
  return name.isEmpty;
}


bool isMobileNumberValid(String mobileNumber) {
  // Check if the mobile number contains only digits
  final isNumeric = int.tryParse(mobileNumber) != null;
  // Check if the mobile number has a length of 10 or 11 digits
  return isNumeric && (mobileNumber.length == 10 || mobileNumber.length == 11);
}


bool isEmailValid(String email) {
  // Check if the email contains the "@" symbol
  return email.contains('@');
}

bool isPasswordValid(String password) {
  // Password should have at least 6 characters
  return password.length >= 6;
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscurePassword = true;
  List<String> errorMessages = List.filled(4, ''); // Initialize with empty strings
  String nameError = '';
  String mobileNumberError = '';
  String emailError = '';
  String passwordError = '';

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
                  "Sign Up",
                  style: Styles.headLineStyle23.copyWith(color: Styles.textColor),
                ),
              ),
            ),
            Container(width: 48), // Adjust the width to your preference
          ],
        ),
      ),




      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Sign Up",
                  style: Styles.headLineStyle1.copyWith(color: Styles.textColor),
                ),
                SizedBox(height: 5),
                GestureDetector(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have a BadmintonBuddy account? ",
                      style: Styles.headLineStyle4.copyWith(color: Styles.textColor),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Log In.",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle "Sign Up" text click
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                if (nameError.isNotEmpty)
                  Text(
                    nameError,
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 16),
                TextField(
                  controller: mobileNumberController,
                  decoration: InputDecoration(
                    labelText: "Mobile Number",
                    border: OutlineInputBorder(),
                  ),
                ),
                if (mobileNumberError.isNotEmpty)
                  Text(
                    mobileNumberError,
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                if (emailError.isNotEmpty)
                  Text(
                    emailError,
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
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
                if (passwordError.isNotEmpty)
                  Text(
                    passwordError,
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    signUp(); // Call the function to send the HTTP request
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    primary: Styles.secPrimaryColor,
                  ),
                  child: Text(
                    "Sign Up",
                    style: Styles.textStyle.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
  // bool isNameEmpty(String name) {
  //   return name.trim().isEmpty;
  // }


  Future<void> signUp() async {
    final url = (Uri.parse(APIsBook.signupUrl));

    final name = nameController.text;
    final mobileNumber = mobileNumberController.text;
    final email = emailController.text;
    final password = passwordController.text;

    setState(() {
      nameError = '';
      mobileNumberError = '';
      emailError = '';
      passwordError = '';
    });

    if (isNameEmpty(name)) {
      setState(() {
        nameError = 'Enter your name.';
      });
      return;
    }

    if (!isMobileNumberValid(mobileNumber)) {
      setState(() {
        mobileNumberError = 'Invalid phone number!.';
      });
      return;
    }

    if (!isEmailValid(email)) {
      setState(() {
        emailError = 'Enter valid email.';
      });
      return;
    }

    if (!isPasswordValid(password)) {
      setState(() {
        passwordError = 'Password should have at least 6 characters.';
      });
      return;
    }

    final requestBody = {
      'name': name,
      'mobile_phone': mobileNumber,
      'email': email,
      'password': password,
    };

    print('POST Body: $requestBody');

    final response = await http.post(url, body: requestBody);
    // Generate a custom UID (replace this with your preferred method)
    final customUid = generateCustomUid();
    await APIs.createUserFromManual(email, name, customUid);

    if (response.statusCode == 200) {
      print('Sign up successful!');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      print('Sign up failed. Error code: ${response.statusCode}');
    }

    // After successfully registering the user manually, proceed with Firebase registration
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email, password: password);

      // // Retrieve the Firebase UID
      // String firebaseUid = userCredential.user?.uid ?? '';
      //
      // // Store the Firebase UID in your MySQL database (you might need an API endpoint for this)
      // await linkFirebaseUidWithManualUser(email, firebaseUid);
      //
      // Now, you can create the user in your Firestore collection
      await APIs.createUser();

      // Navigate to the home screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      print('Firebase registration failed. Error: $e');
      // Handle Firebase registration failure
    }
  }
  // Function to generate a custom UID (replace this with your preferred method)
  String generateCustomUid() {
    // Use a combination of current timestamp and a random number for simplicity
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(999999); // Adjust as needed

    return '$timestamp$random';
  }


  // // Function to link Firebase UID with manual user in MySQL
  // Future<void> linkFirebaseUidWithManualUser(String email, String firebaseUid) async {
  //   // Make an API call to your server to store the association
  //   final url = Uri.parse(APIsBook.linkFirebaseUidUrl);
  //   final requestBody = {'email': email, 'firebaseUid': firebaseUid};
  //
  //   final response = await http.post(url, body: requestBody);
  //
  //   if (response.statusCode == 200) {
  //     print('Firebase UID linked successfully');
  //   } else {
  //     print('Failed to link Firebase UID. Error code: ${response.statusCode}');
  //     // Handle failure to link Firebase UID
  //   }
  // }
}
