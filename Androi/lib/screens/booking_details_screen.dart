import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../utils/app_styles.dart';
import 'package:qr/qr.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';



class BookingDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> booking;
  const BookingDetailsScreen({Key? key, required this.booking})
      : super(key: key);

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

  void goBack(BuildContext context) {
    // final cartItemsNotifier = Provider.of<CartItemsNotifier>(context, listen: false);
    // cartItemsNotifier.clearCart();
    Navigator.pop(
        context); // Use Navigator.pop to go back to the previous screen
  }


  @override
  Widget build(BuildContext context) {
    DateTime bookingDate = DateTime.parse(booking['date']);

    final Map<String, dynamic> data = {
      'booking': booking,
      'redirectUrl': 'http://localhost/BadmintonBuddyAdmin/',
    };
    final String qrCodeData = json.encode(data);

    // Format the date to "dd MMM yyyy" format
    String formattedDate = DateFormat('dd MMM').format(bookingDate);
    print(booking);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.secPrimaryColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false, // Remove the default back button
        title: Row(
          children: [
            Container(
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  goBack(context);
                  // Handle custom back button press
                },
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "Entrance Pass",
                  style: Styles.headLineStyle23.copyWith(color: Colors.white),
                ),
              ),
            ),
            Container(width: 48), // Adjust the width to your preference
          ],
        ),
      ),
      backgroundColor: Styles.bgColor,
      body: Container(
        margin: EdgeInsets.only(top: 20),
        width: double.infinity,
        // height: 480,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
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
                              .copyWith(color: Styles.textColor),
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
                              style: Styles.headLineStyle4,
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
                              booking['bookingID'].toString(),
                              style: Styles.headLineStyle3bold
                                  .copyWith(color: Styles.textColor),
                            ),
                            Text(
                              "Booking Code",
                              style: Styles.headLineStyle4,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'RM ' + booking['total'].toString(),
                              style: Styles.headLineStyle3bold
                                  .copyWith(color: Styles.textColor),
                            ),
                            Text(
                              "Price",
                              style: Styles.headLineStyle4,
                            ),
                          ],
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text(
                        //   formattedDate, // Display the formatted date
                        //   style: Styles.headLineStyle3bold.copyWith(color: Styles.textColor),
                        // ),
                        Text(
                          'Court info',
                          style: Styles.headLineStyle3bold
                              .copyWith(color: Styles.textColor),
                        ),
                        // Text(
                        //   '${calculateTotalCourtsBooked(booking)} Court', // Display the total courts booked
                        //   style: Styles.headLineStyle3bold.copyWith(color: Styles.textColor),
                        // ),
                      ],
                    ),
                    /*Row(
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
                              style: Styles.headLineStyle4,
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

                    ),*/
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
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 0,
                  right: 16,
                  bottom: 16, // Set bottom padding to 0
                ),
                child: Column(
                  children: [
                    for (var court in booking['court'])
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Text(
                          court['court_name'].toString(),
                          style: Styles.headLineStyle3bold.copyWith(color: Styles.textColor),
                        ),
                      ),
                  ],
                )

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
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(21),
                      bottomRight: Radius.circular(21),
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
                      Text(
                        "SCAN QR AT ENTRANCE",
                        style: Styles.headLineStyle4.copyWith(color: Styles.textColor),
                      ),
                      // SizedBox(height: 20), // Add space between the court details and QR code
                      // Create a QrImage widget with your data
                      QrImageView(
                        data: '/BadmintonBuddyAdmin/frontend/seller/validate/entrance-pass.php?ticket_id=${booking['bookingID']}',
                        version: QrVersions.auto,
                        size: 200.0,
                      ),





                    ],
                  )

              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashSpacing;

  DashedLinePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.dashSpacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;

    double currentX = 0;
    while (currentX < size.width) {
      canvas.drawLine(
        Offset(currentX, 0),
        Offset(currentX + dashLength, 0),
        paint,
      );
      currentX += dashLength + dashSpacing;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

