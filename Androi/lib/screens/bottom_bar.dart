import 'package:badmintonbuddy/screens/booking_ticket_screen.dart';
import 'package:badmintonbuddy/screens/home_screen.dart';
import 'package:badmintonbuddy/screens/login_screen.dart';
import 'package:badmintonbuddy/screens/profile_screen.dart';
import 'package:badmintonbuddy/screens/search_screen.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth_service.dart';
import '../session_manager.dart';
import '../widgets/home_screen_with_bottom_bar.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 1;
  bool isLoggedInNew = false;

  @override
  void initState() {
    super.initState();

    // checkLoginStatus();
  }
  static final List<Widget> _widgetOptionsNotLogin = <Widget>[
    const HomeScreen(),
    const LoginScreen(),
    const SearchScreen(),
    const LoginScreen(),
  ];

  static final List<Widget> _widgetOptionsLogin = <Widget>[
    const HomeScreen(),
    const BookingTicketScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> checkLoginStatus() async {
    print('inside checkLoginStatus');
    String? username = await SessionManager.getUsername();
    if (username != null) {
      print("Username: $username");
      return true; // User is logged in
    } else {
      print("Username not found.");
      return false; // User is not logged in
    }
  }




  @override
  Widget build(BuildContext context) {
    // final authService = Provider.of<AuthService>(context); // Get the AuthService instance
    // final isLoggedIn = authService.isLoggedIn;
    if (isLoggedInNew) {
      // User is logged in
      print('User is logged in');
    } else {
      // User is not logged in
      print('User is not logged in');
    }
    print(isLoggedInNew);
    return Scaffold(
      body: Center(
        child: FutureBuilder<bool>(
          future: checkLoginStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              isLoggedInNew = snapshot.data ?? false; // Update isLoggedInNew based on the result
              return isLoggedInNew
                  ? _widgetOptionsLogin[_selectedIndex]
                  : _widgetOptionsNotLogin[_selectedIndex];
            } else {
              return CircularProgressIndicator(); // Show a loading indicator while checking the login status.
            }
          },
        )

      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        elevation: 10,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: const Color(0xFF526480),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_ticket_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_ticket_filled),
              label: "Booking"),
          BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_chat_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_chat_filled),
              label: "Chats"),
          BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_person_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled),
              label: "Account"),
        ],
      ),
    );
  }
}



