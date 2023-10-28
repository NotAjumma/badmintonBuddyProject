import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/booking_ticket_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';
import '../session_manager.dart';

class HomeScreenWithBottomBar extends StatefulWidget {
  const HomeScreenWithBottomBar({Key? key}) : super(key: key);

  @override
  State<HomeScreenWithBottomBar> createState() => _HomeScreenWithBottomBarState();
}

class _HomeScreenWithBottomBarState extends State<HomeScreenWithBottomBar> {
  int _selectedIndex = 0; // Set the initial index to the Home tab
  bool isLoggedInNew = false;

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
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: "Booking",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
}

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Home'),
      // ),
      // body: Center(
      //   child: Text('Home Screen Content'),
      // ),
    );
  }
}
