import 'package:badmintonbuddy/screens/booking_ticket_screen.dart';
import 'package:badmintonbuddy/screens/home_screen.dart';
import 'package:badmintonbuddy/screens/login_screen.dart';
import 'package:badmintonbuddy/screens/search_screen.dart';
import 'package:badmintonbuddy/widgets/my_qr_code_screen.dart';
// import 'package:badmintonbuddy/widgets/qr_code.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late String qrCodeImagePath;

  @override
  void initState() {
    super.initState();
    // Retrieve qrCodeImagePath here, e.g., set it from the file path.
    qrCodeImagePath = 'path_to_your_qr_code_image';
  }
  int _selectedIndex=3;
  static final List<Widget>_widgetOptions = <Widget>[
    const HomeScreen(),
    const BookingTicketScreen(),
    MyQRCodeScreen(qrCodeImagePath: 'path_to_your_qr_code_image'),

    // MyQRCodeScreen(qrCodeImagePath: '',),

    // const MyQrCode(),
    const LoginScreen()

  ];

  void _onItemTapped(int index){
    setState((){
      _selectedIndex=index;
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  Center(
        child: _widgetOptions[_selectedIndex],
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
          // BottomNavigationBarItem(
          //     icon: Icon(FluentSystemIcons.ic_fluent_search_regular),
          //     activeIcon: Icon(FluentSystemIcons.ic_fluent_search_filled),
          //     label: "Search"),
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
              label: "Account")
        ],
      ),
    );
  }
}
