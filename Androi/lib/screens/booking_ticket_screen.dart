import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../session_manager.dart';
import '../utils/app_api_list.dart';
import '../utils/app_styles.dart';
import '../widgets/booking_ticket_view.dart';

class BookingTicketScreen extends StatefulWidget {
  const BookingTicketScreen({Key? key}) : super(key: key);

  @override
  _BookingTicketScreenState createState() => _BookingTicketScreenState();
}

class _BookingTicketScreenState extends State<BookingTicketScreen> {
  List<Map<String, dynamic>> bookings = [];

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    String? email = await SessionManager.getUsername();
    print(email);
    final url = Uri.parse('${APIsBook.getBookingByIdUrl}?email=$email');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final String responseBody = response.body;

      try {
        final data = json.decode(responseBody);

        if (data is List) {
          setState(() {
            bookings = List<Map<String, dynamic>>.from(data);
          });
        } else {
          // Handle unexpected response format
          print("Unexpected JSON format: $data");
        }
      } catch (e) {
        // Handle JSON parsing error
        print("Error parsing JSON: $e");
      }
    } else {
      // Handle non-200 response (e.g., error or HTML content)
      print("HTTP Error: ${response.statusCode}");
      print("Response Content: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs (Upcoming and Previous)
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Booking History",
            style: TextStyle(
              color: Styles.textColor, // Text color
            ),
          ),
          backgroundColor: Styles.bgColor,
          bottom: TabBar(
            // Define your tabs
            tabs: [
              Tab(text: "Upcoming"),
              Tab(text: "Previous"),
            ],
            labelStyle: Styles.textStyle,
            unselectedLabelStyle: Styles.textStyle,
            labelColor: Styles.textColor,
            unselectedLabelColor: Styles.textColor,
            indicator: BoxDecoration(
              color: Styles.bgColor, // Change the indicator color to Styles.bgColor
            ),
          ),
        ),
        backgroundColor: Styles.bgColor, // Set the background color of the entire screen
        body: TabBarView(
            children: [
              // Content for the "Upcoming" tab
              Column(
                children: [
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (var booking in bookings)
                          BookingTicketView(booking: booking),
                      ],
                    ),
                  ),
                ],
              ),

              // Content for the "Previous" tab
              Column(
                children: [
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        // Your content for the Previous tab here
                      ],
                    ),
                  ),
                ],
              ),
            ],

        ),
      ),
    );
  }
}
