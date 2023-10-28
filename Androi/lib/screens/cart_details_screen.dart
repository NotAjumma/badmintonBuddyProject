import 'dart:convert';

import 'package:badmintonbuddy/screens/court_list.dart';
import 'package:badmintonbuddy/utils/app_styles.dart';
import 'package:badmintonbuddy/widgets/cart_items_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../utils/app_api_list.dart';

class CartDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> facility;
  final CartItemsNotifier cartItemsNotifier;

  const CartDetailsScreen(
      {Key? key, required this.facility, required this.cartItemsNotifier})
      : super(key: key);

  void goBack(BuildContext context) {
    // final cartItemsNotifier = Provider.of<CartItemsNotifier>(context, listen: false);
    // cartItemsNotifier.clearCart();
    Navigator.pop(
        context); // Use Navigator.pop to go back to the previous screen
  }

  Future<void> sendBookingData(
      Map<String, dynamic> facility, List<CartItem> cartItems) async {
    final url = (Uri.parse(APIs.addBookingCourtUrl));

    // Create JSON object for time, date, duration, ampm, and total
    final Map<String, dynamic> timeData = {
      'time': cartItems[0].time,
      'date': cartItems[0].date,
      'duration': cartItems[0].duration,
      'ampm': cartItems[0].ampm,
      'total': calculateTotalPrice(cartItemsNotifier.cartItems).toStringAsFixed(2),
      'endT': findEndTime(cartItems[0]),
      'court_details': <Map<String, dynamic>>[], // Initialize with an empty list
    };

    for (int i = 0; i < cartItems.length; i++) {
      // Create JSON object for court details
      final Map<String, dynamic> courtDetails = {
        'courtID': cartItems[i].id,
        // Add more fields as needed from the CartItem object
      };
      timeData['court_details'].add(courtDetails);
    }

    // Print timeData and its court_details
    print('timeData: $timeData');
    print('courtDetails: ${timeData['court_details']}');

    // Convert the time and court details to a JSON string
    final requestDataJson = json.encode(timeData);

    // Prepare the request body
    final Map<String, dynamic> body = {
      'facility_id': facility['id'],
      'requestData': requestDataJson,
      // Add more fields as needed from the facility map
    };
    print('Request Data: $requestDataJson');
    print('Request Body JSON: ${jsonEncode(body)}'); // Print the JSON-encoded body

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),  // Send the entire 'body' map as JSON
    );

    if (response.statusCode == 200) {
      print('Data inserted successfully');
      // Add more fields as needed from the CartItem object
    } else {
      print('Failed to insert data. Status code: ${response.statusCode}');
    }
  }

  String findEndTime(CartItem cartItem) {
    String startTime =
        cartItem.time; // Replace with the actual start time property
    String durationStr =
        cartItem.duration; // Replace with the actual duration property

    // Parse the start time
    List<String> parts = startTime.split(":");
    int startHour = int.parse(parts[0]);
    int startMinute = int.parse(parts[1]);

    // Parse the duration as a double with error handling
    double duration = 0.0;
    try {
      duration = double.parse(durationStr);
    } catch (e) {
      print('Error parsing duration: $e');
      // Handle the error or provide a default value
    }

    // Calculate the end time
    int durationHour = duration.toInt();
    double durationMinutes = (duration - durationHour) * 60;
    int endHour = startHour + durationHour;
    int endMinute = (startMinute + durationMinutes).round();

    if (endMinute >= 60) {
      endHour += 1;
      endMinute %= 60;
    }

    // Format the end time
    String endTime =
        '${endHour.toString().padLeft(2, '0')}:${endMinute.toString().padLeft(2, '0')}';

    return endTime;
  }

  String formatDateString(String dateStr) {
    if (dateStr.isNotEmpty) {
      DateTime date = DateTime.parse(dateStr);
      String formattedDate = DateFormat('d MMM y, EEEE').format(date);
      return formattedDate;
    } else {
      return "No date available";
    }
  }

  String formatCartItem(CartItem cartItem) {
    String startTime =
        cartItem.time; // Replace with the actual start time property
    String durationStr =
        cartItem.duration; // Replace with the actual duration property
    String amPm = cartItem.ampm; // Replace with the actual AM/PM property
    double price = cartItem.price; // Replace with the actual price property

    // Parse the start time
    List<String> parts = startTime.split(":");
    int startHour = int.parse(parts[0]);
    int startMinute = int.parse(parts[1]);

    // Parse the duration as a double with error handling
    double duration = 0.0;
    try {
      duration = double.parse(durationStr);
    } catch (e) {
      print('Error parsing duration: $e');
      // Handle the error or provide a default value
    }

    // Calculate the end time
    int durationHour = duration.toInt();
    double durationMinutes = (duration - durationHour) * 60;
    int endHour = startHour + durationHour;
    int endMinute = (startMinute + durationMinutes).round();

    if (endMinute >= 60) {
      endHour += 1;
      endMinute %= 60;
    }

    // if (endHour >= 12) {
    //   amPm = 'PM';
    // } else {
    //   amPm = 'AM';
    // }

    if (endHour > 12) {
      endHour -= 12;
    }

    // Format the end time
    String endTime =
        '${endHour.toString().padLeft(2, '0')}:${endMinute.toString().padLeft(2, '0')} $amPm';

    String courtName =
        cartItem.name; // Replace with the actual court name property

    return '$startTime - $endTime | $courtName';
  }

  String formatPrice(double price) {
    return 'RM ${price.toStringAsFixed(2)}'; // Format the price with 2 decimal places
  }

  double calculateTotalPrice(List<CartItem> cartItems) {
    double total = 0.0;
    for (var item in cartItems) {
      total += item.price;
    }
    return total;
  }

// Assuming cartItemsNotifier.cartItems is a List<CartItem>
//   List<String> formatCartItemsCourt(List<CartItem> cartItems) {
//     List<String> formattedItems = [];
//     for (var cartItem in cartItems) {
//       formattedItems.add(formatCartItemCourt(cartItem));
//     }
//     return formattedItems;
//   }

  List<String> formatCartItems(List<CartItem> cartItems) {
    List<String> formattedItems = [];

    for (var cartItem in cartItems) {
      String bookingDetails = formatCartItem(cartItem);
      String price = formatPrice(cartItem.price);

      // Combine booking details and price for each cart item
      formattedItems.add('$bookingDetails _ $price');
    }

    return formattedItems;
  }

  @override
  Widget build(BuildContext context) {
    print(facility);
    final cartItemsNotifier = Provider.of<CartItemsNotifier>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.secPrimaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Container(
              //   height: 50,
              //   width: 50,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     image: DecorationImage(
              //       fit: BoxFit.fitHeight,
              //       image: AssetImage("assets/images/badminton_buddy_logo.png"),
              //     ),
              //   ),
              // ),
              Container(
                // Adjust the amount of space as needed
                child: Text(
                  "My Cart",
                  style: Styles.headLineStyle2.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Styles.boxGrey, width: 1.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(color: Styles.boxGrey, width: 1.0),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text("Facility Details", style: TextStyle(fontSize: 18)),
                                  Text(
                                    facility['name'],
                                    style: Styles.headLineStyle23
                                        .copyWith(color: Styles.textColor),
                                  ), // Accessing name property from widget.facility
                                  Text(
                                    facility['address'],
                                    style: Styles.headLineStyle4
                                        .copyWith(color: Styles.textColor),
                                  ), // Accessing address property from widget.facility
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                    left:
                                        15), // Add a margin of 10 around the Container
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Styles.primaryColor,
                                  ),
                                  child: Image.network(
                                    facility['image'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Booking Details",
                              style: Styles.headLineStyle23
                                  .copyWith(color: Styles.textColor),
                            ),
                            Text(
                              formatDateString(
                                  cartItemsNotifier.cartItems.isNotEmpty
                                      ? cartItemsNotifier.cartItems[0].date
                                      : ""),
                              style: Styles.headLineStyle4
                                  .copyWith(color: Styles.textColor),
                            ),
                            ...formatCartItems(cartItemsNotifier.cartItems)
                                .map((item) {
                              var parts = item.split(
                                  ' _ '); // Corrected the split separator to ' | ' as in your earlier messages
                              var bookingDetails = parts[0];
                              var price = parts[1];
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      bookingDetails, // Display booking details and court name
                                      style: Styles.headLineStyle4thin
                                          .copyWith(color: Styles.textColor),
                                    ),
                                  ),
                                  Text(
                                    price, // Display the price
                                    style: Styles.headLineStyle4thin
                                        .copyWith(color: Styles.textColor),
                                  ),
                                ],
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Styles.boxGrey, width: 1.0),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Subtotal",
                                        style: Styles.headLineStyle4thin
                                            .copyWith(color: Styles.textColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "RM ${calculateTotalPrice(cartItemsNotifier.cartItems).toStringAsFixed(2)}",
                                  style: Styles.headLineStyle4thin
                                      .copyWith(color: Styles.textColor),
                                ),
                              ],
                            ),
                            const Gap(35),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total",
                                        style: Styles.headLineStyle4thin
                                            .copyWith(color: Styles.textColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "RM ${calculateTotalPrice(cartItemsNotifier.cartItems).toStringAsFixed(2)}",
                                  style: Styles.headLineStyle4thin
                                      .copyWith(color: Styles.textColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  sendBookingData(
                      facility,
                      cartItemsNotifier
                          .cartItems); // Add your SQL processing logic here
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Styles.secPrimaryColor),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.8, // Adjust the fraction as needed
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Checkout",
                      style: Styles.textStyle.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
