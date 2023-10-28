import 'dart:convert';

import 'package:badmintonbuddy/screens/home_screen.dart';
import 'package:badmintonbuddy/session_manager.dart';
import 'package:badmintonbuddy/utils/app_api_list.dart';
import 'package:badmintonbuddy/widgets/home_screen_with_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String email, String password, BuildContext context) async {
    final url = Uri.parse(APIs.loginUrl);

    print('Email: $email');
    print('Password: $password');

    final requestBody = {
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(url, body: requestBody);

      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Data: $data');

        if (data['success']) {
          final levelId = data['level_id'].toString();
          if (levelId == "3") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreenWithBottomBar()),
            );

            _isLoggedIn = true;
            await SessionManager.storeUsername(email);
            notifyListeners();
          }
        } else {
          final error = data['error'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: $error')),
          );
        }
      } else {
        print('Login failed2: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed2: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Login failed3: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed3: $e')),
      );
    }
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    notifyListeners();

    // You can also remove the username from your session manager if needed
    await SessionManager.removeUsername();
  }
}
