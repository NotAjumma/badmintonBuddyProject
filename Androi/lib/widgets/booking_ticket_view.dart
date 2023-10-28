import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/app_styles.dart';

class BookingTicketView extends StatelessWidget {
  final Map<String, dynamic> booking;
  const BookingTicketView({Key? key, required this.booking}) : super(key: key);

  int calculateTotalCourtsBooked(Map<String, dynamic> booking) {
    final courtList = booking['court'] as List;
    final uniqueCourtIds = courtList.map((court) => court['courtID']).toSet();
    return uniqueCourtIds.length;
  }

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + '...';
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime bookingDate = DateTime.parse(booking['date']);


    // Format the date to "dd MMM yyyy" format
    String formattedDate = DateFormat('dd MMM').format(bookingDate);
    return SizedBox(
      width: double.infinity,
      height: 220,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(21),
                  topRight: Radius.circular(21),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formattedDate, // Display the formatted date
                        style: TextStyle(
                          color: Styles.textColor,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        booking['facility']['facility_name'].toString(),
                        style: TextStyle(
                          color: Styles.textColor,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '${calculateTotalCourtsBooked(booking)} Court', // Display the total courts booked
                        style: TextStyle(
                          color: Styles.textColor,
                          fontSize: 13,
                        ),
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 50,
                        child: Text(
                          'Date',
                          style: TextStyle(
                            color: Styles.textColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Center(
                          child: Text(
                            truncateText(
                              booking['facility']['district'].toString(),
                              20, // Set the maximum length you desire
                            ),
                            style: TextStyle(
                              color: Styles.textColor,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: Text(
                          'Total',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Styles.textColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],

                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking['time'].toString(),
                            style: TextStyle(
                              color: Styles.textColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "Start",
                            style: TextStyle(
                              color: Styles.textColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking['duration'].toString() + ' hours', // Add ' hours' after the duration
                            style: TextStyle(
                              color: Styles.textColor,
                              fontSize: 14,
                            ),
                          ),

                          Text(
                            "",
                            style: TextStyle(
                              color: Styles.textColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            booking['end_time'].toString(),
                            style: TextStyle(
                              color: Styles.textColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "End",
                            style: TextStyle(
                              color: Styles.textColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Material(
              // elevation: 5, // Set the elevation to control the shadow
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(21),
                bottomRight: Radius.circular(21),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(21),
                    bottomRight: Radius.circular(21),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),

                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end, // Align the buttons to the right
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {
                              // Handle the "Refund" button click, e.g., perform a refund action
                            },
                            child: Container(
                              width: 70,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Styles.secPrimaryColor, // Button background color
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center( // Center the text within the button
                                child: Text(
                                  "Refund",
                                  style: TextStyle(
                                    color: Colors.white, // Text color
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {
                              // Handle the "View" button click, e.g., navigate to another screen
                            },
                            child: Container(
                              width: 70,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Styles.secPrimaryColor, // Button background color
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center( // Center the text within the button
                                child: Text(
                                  "View",
                                  style: TextStyle(
                                    color: Colors.white, // Text color
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )




                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
