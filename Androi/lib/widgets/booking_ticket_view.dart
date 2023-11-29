import 'package:badmintonbuddy/screens/booking_details_screen.dart';
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
      // height: 290,
      child: Container(
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),



        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Styles.secPrimaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(21),
                  topRight: Radius.circular(21),
                ),
              ),
              padding: const EdgeInsets.only(
                left: 16,
                top: 16,
                right: 16,
                bottom: 16, // Set bottom padding to 0
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(
                      //   formattedDate, // Display the formatted date
                      //   style: Styles.headLineStyle3bold.copyWith(color: Styles.textColor),
                      // ),
                      Text(
                        booking['facility']['facility_name'].toString(),
                        style: Styles.headLineStyle3bold
                            .copyWith(color: Colors.white),
                      ),
                      // Text(
                      //   '${calculateTotalCourtsBooked(booking)} Court', // Display the total courts booked
                      //   style: Styles.headLineStyle3bold.copyWith(color: Styles.textColor),
                      // ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   width: 50,
                      //   child: Text(
                      //     'Date',
                      //     style: Styles.headLineStyle4,
                      //   ),
                      // ),
                      SizedBox(
                        width: 150,
                        child: Center(
                          child: Text(
                            truncateText(
                              booking['facility']['district'].toString(),
                              20, // Set the maximum length you desire
                            ),
                            style: Styles.headLineStyle4.copyWith(color: Colors.white70),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 50,
                      //   child: Text(
                      //     'Total',
                      //     textAlign: TextAlign.end,
                      //     style: Styles.headLineStyle4,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            /*Container(
              // Add a white background to the Divider
              color: Color(0xFF526799),
              child: CustomPaint(
                painter: DashedLinePainter(
                  color: Colors.white,
                  strokeWidth: 1, // Adjust the line width as needed
                  dashLength: 5, // Adjust the length of each dash
                  dashSpacing: 2, // Adjust the spacing between dashes
                ),
              ),
            ),*/
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
              padding: const EdgeInsets.only(
                left: 16,
                top: 16,
                right: 16,
                bottom: 16, // Set bottom padding to 0
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formattedDate, // Display the formatted date
                        style: Styles.headLineStyle3bold
                            .copyWith(color: Styles.textColor),
                      ),
                      // Text(
                      //   booking['facility']['facility_name'].toString(),
                      //   style: Styles.headLineStyle3bold.copyWith(color: Styles.textColor),
                      // ),
                      Text(
                        '${calculateTotalCourtsBooked(booking)} Court', // Display the total courts booked
                        style: Styles.headLineStyle3bold
                            .copyWith(color: Styles.textColor),
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
                          style: Styles.headLineStyle4,
                        ),
                      ),
                      // SizedBox(
                      //   width: 150,
                      //   child: Center(
                      //     child: Text(
                      //       truncateText(
                      //         booking['facility']['district'].toString(),
                      //         20, // Set the maximum length you desire
                      //       ),
                      //       style: Styles.headLineStyle4,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        width: 50,
                        child: Text(
                          'Total',
                          textAlign: TextAlign.end,
                          style: Styles.headLineStyle4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              // Add a white background to the Divider
              color: Colors.white,
              child: CustomPaint(
                painter: DashedLinePainter(
                  color: Styles.boxGrey,
                  strokeWidth: 1, // Adjust the line width as needed
                  dashLength: 5, // Adjust the length of each dash
                  dashSpacing: 2, // Adjust the spacing between dashes
                ),
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
              padding: const EdgeInsets.only(
                left: 16,
                top: 16,
                right: 16,
                bottom: 16, // Set bottom padding to 0
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${booking['time']} ${(booking['AmPm'])}",
                            style: Styles.headLineStyle3bold
                                .copyWith(color: Styles.textColor),
                          ),
                          Text(
                            "Start",
                            style: Styles.headLineStyle4,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            booking['duration'].toString() +
                                ' hours', // Add ' hours' after the duration
                            style: Styles.headLineStyle3bold
                                .copyWith(color: Styles.textColor),
                          ),
                          Text(
                            "Duration",
                            style: Styles.headLineStyle4,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${booking['end_time']} ${(booking['AmPm'])}",
                            style: Styles.headLineStyle3bold
                                .copyWith(color: Styles.textColor),
                          ),
                          Text(
                            "End",
                            style: Styles.headLineStyle4,
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
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => BookingDetailsScreen(booking: booking)),
                              );
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
