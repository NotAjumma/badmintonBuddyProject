import 'dart:convert';

import 'package:badmintonbuddy/screens/badminton_facility_vertical_screen.dart';
import 'package:badmintonbuddy/screens/badmiton_facility_screen.dart';
import 'package:badmintonbuddy/screens/bottom_bar.dart';
import 'package:badmintonbuddy/screens/cart_details_screen.dart';
import 'package:badmintonbuddy/screens/court_list.dart';
import 'package:badmintonbuddy/screens/home_screen.dart';
import 'package:badmintonbuddy/utils/app_info_list.dart';
import 'package:badmintonbuddy/utils/app_layout.dart';
import 'package:badmintonbuddy/utils/app_styles.dart';
import 'package:badmintonbuddy/widgets/cart_items_notifier.dart';
import 'package:badmintonbuddy/widgets/home_screen_with_bottom_bar.dart';
import 'package:badmintonbuddy/widgets/icon_text_widget.dart';
import 'package:badmintonbuddy/widgets/date_input.dart';
import 'package:badmintonbuddy/data_service.dart';
import 'package:badmintonbuddy/widgets/my_cart_view.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../session_manager.dart';
import '../utils/app_api_list.dart';

final TextEditingController searchController = TextEditingController();

class BookingCourtScreen extends StatefulWidget {
  final Map<String, dynamic> facility;
  final String? sourceScreen; // Add this line

  const BookingCourtScreen({Key? key, required this.facility, this.sourceScreen})
      : super(key: key);
  @override
  _BookingCourtScreenState createState() => _BookingCourtScreenState();

  void onDateSelected(DateTime? selectedDate) {}
}

class _BookingCourtScreenState extends State<BookingCourtScreen> {
  DateTime? _selectedDate;
  String? _selectedStartTime;
  String? _selectedAMPM;
  String? _selectedDuration;
  List<Map<String, dynamic>> courtList = [];
  bool isSearching = false;

  String? selectedDate; // Variable to store the user-selected date
  String? selectedTime; // Variable to store the user-selected time
  String? selectedAMPM; // Variable to store the user-selected AM/PM
  String? selectedDuration; // Variable to store the user-selected duration

  @override
  void initState() {
    super.initState();
    print(widget.facility);
  }

  // Future<void> fetchBadmintonCourts() async {
  //   final facilityId = widget.facility['id']; // Replace 'facility_id' with the correct key if needed.
  //   final response = await http.get(Uri.parse(
  //       'http://192.168.137.1/BadmintonBuddyServerSide/get_court_by_facility.php?facility_id=$facilityId'));
  //
  //   print('Response status code: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  //   print('Facility Current Id: $facilityId');
  //
  //   if (response.statusCode == 200) {
  //     List<dynamic> jsonResponse = json.decode(response.body);
  //     setState(() {
  //       courtList = jsonResponse.cast<Map<String, dynamic>>();
  //     });
  //   } else {
  //     throw Exception('Failed to load facilities from the server');
  //   }
  // }

  final List<String> startTimes = [
    '12:00',
    '12:30',
    '1:00',
    '1:30',
    '2:00',
    '2:30',
    '3:00',
    '3:30',
    '4:00',
    '4:30',
    '5:00',
    '5:30',
    '6:00',
    '6:30',
    '7:00',
    '7:30',
    '8:00'
  ];

  final List<String> AMPMOptions = ['AM', 'PM'];

  final List<String> durations = [
    '1',
    '1.5',
    '2',
    '2.5',
    '3',
    '3.5',
    '4',
    '4.5',
    '5',
    '5.5',
    '6'
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      final formattedDate = DateFormat('yyyy-MM-dd')
          .format(picked); // Format the DateTime to 'yyyy-MM-dd'
      setState(() {
        _selectedDate = picked;
        selectedDate = formattedDate;
        print('Selected Date after inside async: $selectedDate');
        print('Selected Date: $formattedDate');
        // Add this check in the relevant parts of your code where you capture input
        if (_selectedDate != null && _selectedStartTime != null && _selectedAMPM != null && _selectedDuration != null) {
          // Perform AJAX request to fetch court data
          fetchCourtData();
        }
      });
      widget.onDateSelected(_selectedDate);
    }



  }

  void _showCustomDropdownDialog(BuildContext context, List<String> items,
      String? initialValue, Function(String?) onSelected) {
    String? selectedValueTime = initialValue;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 300, // Set the desired height
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                  onTap: () {
                    selectedValueTime = items[index];
                    onSelected(selectedValueTime);
                    selectedTime = selectedValueTime;
                    Navigator.of(context).pop();
                    print('Selected Time: $selectedValueTime');

                    // Call fetchCourtData directly after selecting AM/PM
                    if (_selectedDate != null && selectedValueTime != null && _selectedAMPM != null && _selectedDuration != null) {
                      fetchCourtData();
                    }
                  },
                );
              },
            ),
          ),
        );
      },
    );

  }

  double calculateTotalPrice(List<CartItem> cartItems) {
    double total = 0.0;
    for (var item in cartItems) {
      total += item.price;
    }
    return total;
  }


  void _showCustomDropdownDialogDuration(BuildContext context,
      List<String> items, String? initialValue, Function(String?) onSelected) {
    String? selectedValueDuration = initialValue;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 300, // Set the desired height
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                  onTap: () {
                    selectedValueDuration = items[index];
                    onSelected(selectedValueDuration);
                    selectedDuration = selectedValueDuration;
                    Navigator.of(context).pop();
                    print('Selected Duration: $selectedValueDuration');
                    // Call fetchCourtData directly after selecting AM/PM
                    if (_selectedDate != null && _selectedStartTime != null && _selectedAMPM != null && selectedDuration != null) {
                      fetchCourtData();
                    }
                  },
                );
              },
            ),
          ),
        );
      },
    );


  }

  void _showCustomDropdownDialogAmPm(BuildContext context, List<String> items,
      String? initialValue, Function(String?) onSelected) {
    String? _selectedAMPM = initialValue;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: items.length * 50.0, // Set the desired height
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                  onTap: () {
                    _selectedAMPM = items[index];
                    onSelected(_selectedAMPM);
                    selectedAMPM = _selectedAMPM;
                    Navigator.of(context).pop();
                    print('Selected AMPM: $_selectedAMPM');
                    // Call fetchCourtData directly after selecting AM/PM
                    if (_selectedDate != null && _selectedStartTime != null && _selectedAMPM != null && _selectedDuration != null) {
                      fetchCourtData();
                    }
                  },
                );
              },
            ),
          ),
        );
      },
    );



  }

/*  Future<void> handleFindCourtsButtonClick() async {
    if (selectedDate == null ||
        selectedTime == null ||
        selectedAMPM == null ||
        selectedDuration == null) {
      // Handle the case where not all input values are selected.
      print(
          'Inside null, Date, Time, Am, Duration: $selectedDate, $selectedTime, $selectedAMPM, $selectedDuration');
      return;
    }

    setState(() {
      isSearching = true;
    });

    try {
      print(
          'inside try null, Date, Time, Am, Duration: $selectedDate, $selectedTime, $selectedAMPM, $selectedDuration');
      final facilityId = widget.facility['id'];
      // final url =
      //     'http://192.168.0.11/BadmintonBuddyServerSide/get_available_courts.php?facility_id=$facilityId&date=$selectedDate&time=$selectedTime&ampm=$selectedAMPM&duration=$selectedDuration';
      final response = await http.get(Uri.parse(
          '${APIs.getAvailableCourtUrl}?facility_id=$facilityId&date=$selectedDate&time=$selectedTime&ampm=$selectedAMPM&duration=$selectedDuration'));

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('Facility current id: $facilityId');

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse != null) {
          final List<Map<String, dynamic>> searchResults =
              jsonResponse.cast<Map<String, dynamic>>();

          setState(() {
            courtList = searchResults;
          });
        } else {
          print('Empty or invalid JSON response.');
        }
      } else {
        print('API request failed with status code ${response.statusCode}');
      }
    } catch (error) {
      print('Error searching for facilities: $error');
    }
  }*/
 /* void handleFindCourtsButtonClick() {
    // Check if all required inputs are selected
    if (_selectedDate != null && _selectedStartTime != null && _selectedAMPM != null && _selectedDuration != null) {
      // Perform AJAX request to fetch court data
      fetchCourtData();
    } else {
      // Handle case when not all inputs are selected
      print('Please select all required inputs.');
    }
  }*/

  Future<void> fetchCourtData() async {
    try {
      final facilityId = widget.facility['id'];
      final response = await http.get(Uri.parse(
          '${APIsBook.getAvailableCourtUrl}?facility_id=$facilityId&date=$_selectedDate&time=$_selectedStartTime&ampm=$_selectedAMPM&duration=$_selectedDuration'));

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('Facility current id: $facilityId');

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse != null) {
          final List<Map<String, dynamic>> courtData =
          jsonResponse.cast<Map<String, dynamic>>();

          // Update the court list with the fetched data
          setState(() {
            courtList = courtData;
          });
        } else {
          print('Empty or invalid JSON response.');
        }
      } else {
        print('API request failed with status code ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching court data: $error');
    }
  }

  void handleFindCourtsButtonClick() {
    // Check if all required inputs are selected
    if (_selectedDate != null && _selectedStartTime != null && _selectedAMPM != null && _selectedDuration != null) {
      // Perform AJAX request to fetch court data
      fetchCourtData();
    } else {
      // Handle case when not all inputs are selected
      print('Please select all required inputs.');
    }
  }

  void goBack(BuildContext context) {
    final cartItemsNotifier =
        Provider.of<CartItemsNotifier>(context, listen: false);
    cartItemsNotifier.clearCart();
    Navigator.pop(
        context); // Use Navigator.pop to go back to the previous screen
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
    final cartItemsNotifier = Provider.of<CartItemsNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.bgColor,
        title: Text(
          widget.facility['name'],
          style: Styles.headLineStyle2.copyWith(color: Styles.textColor),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          color: const Color(0xFF3b3b3b),
          onPressed: () async {
            bool isLoggedIn = await checkLoginStatus();

            if (widget.sourceScreen == "LoginScreenBook") {
              // User is logged in, go back
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreenWithBottomBar(),
                ),
              );
            } else {
              // User is not logged in, navigate to login screen
              goBack(context);
            }
          },

        ),
      ),
      backgroundColor: Styles.bgColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: [
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: AppLayout.getWidth(20),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppLayout.getWidth(20),
                          vertical: AppLayout.getHeight(20),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFFF4F6FD),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                color: Color(0xFF3b3b3b),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppLayout.getWidth(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: GestureDetector(
                                        onTap: () => _selectDate(context),
                                        child: SizedBox(
                                          width: AppLayout.getWidth(250),
                                          child: Text(
                                            _selectedDate == null
                                                ? "Date"
                                                : DateFormat('yyyy-MM-dd')
                                                    .format(_selectedDate!),
                                            style: Styles.textStyle,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: AppLayout.getWidth(10),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppLayout.getWidth(20),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: GestureDetector(
                                  onTap: () {
                                    _showCustomDropdownDialog(
                                        context, startTimes, _selectedStartTime,
                                        (String? value) {
                                      setState(() {
                                        _selectedStartTime = value;
                                      });
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF4F6FD),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: InputDecorator(
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 10),
                                        border: InputBorder.none,
                                      ),
                                      child: Text(_selectedStartTime ?? "Start time"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: GestureDetector(
                                  onTap: () {
                                    _showCustomDropdownDialogAmPm(
                                        context, AMPMOptions, _selectedAMPM,
                                        (String? value) {
                                      setState(() {
                                        _selectedAMPM = value;
                                      });
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF4F6FD),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: InputDecorator(
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 10),
                                        border: InputBorder.none,
                                      ),
                                      child: Text(_selectedAMPM ?? "AM/PM"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: GestureDetector(
                                  onTap: () {
                                    _showCustomDropdownDialogDuration(
                                        context, durations, _selectedDuration,
                                        (String? value) {
                                      setState(() {
                                        _selectedDuration = value;
                                      });
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF4F6FD),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: InputDecorator(
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 10),
                                        border: InputBorder.none,
                                      ),
                                      child: Text(_selectedDuration ?? "Duration"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: handleFindCourtsButtonClick,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppLayout.getWidth(20),
                            vertical: AppLayout.getWidth(10),
                          ),
                          // child: Container(
                          //   padding: EdgeInsets.symmetric(
                          //     vertical: AppLayout.getWidth(15),
                          //     horizontal: 20, // Horizontal padding (not margin)
                          //   ),
                          //   // decoration: BoxDecoration(
                          //   //   color: const Color(0xD91130CE),
                          //   //   borderRadius: BorderRadius.circular(AppLayout.getWidth(10)),
                          //   // ),
                          //   // child: Center(
                          //   //   child: Text(
                          //   //     isSearching ? "Find Courts" : "Find Courts",
                          //   //     style: Styles.textStyle.copyWith(color: Colors.white),
                          //   //   ),
                          //   // ),
                          // ),
                        ),
                      ),

                      // const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 20, bottom: 10),
                            child: Text(
                              "Select your badminton court",
                              style: Styles.headLineStyle2.copyWith(color: Styles.textColor),
                            ),
                          ),
                          if (_selectedDate != null && _selectedStartTime != null && _selectedAMPM != null && _selectedDuration != null)
                            Column(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.7,
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: courtList
                                        .map((singleCourt) => CourtList(
                                      court: singleCourt,
                                      price: widget.facility['price'],
                                      duration: selectedDuration ?? "Default Value",
                                      selectedDate: selectedDate ?? "Default Value",
                                      selectedTime: selectedTime ?? "Default Value",
                                      selectedAMPM: selectedAMPM ?? "Default Value",
                                    ))
                                        .toList() ??
                                        [],
                                  ),
                                ),
                              ],
                            )
                          else
                            Container(
                              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "Available courts for your selected date and time will be shown here",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),


                      Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height *
                                0.7, // Set your desired height here
                            child: ListView(
                              shrinkWrap: true,
                              children: courtList
                                      .map((singleCourt) => CourtList(
                                            court: singleCourt,
                                            price: widget.facility['price'],
                                            duration: selectedDuration ?? "Default Value",
                                            selectedDate: selectedDate ?? "Default Value",
                                            selectedTime: selectedTime ?? "Default Value",
                                            selectedAMPM: selectedAMPM ?? "Default Value",
                                          ))
                                      .toList() ??
                                  [],
                            ),
                          ),
                          // Add other widgets below the ListView
                        ],
                      ),



                    ],
                  ),

                ],
              ),

            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white, // Customize the background color as needed
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, -2), // Adjust the shadow as needed
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("My Cart", style: Styles.headLineStyle23.copyWith(color: Styles.textColor),), // Label "My Cart"
                    Text("Bookings | RM ${calculateTotalPrice(cartItemsNotifier.cartItems).toStringAsFixed(2)}",
                      style: Styles.textStyle.copyWith(color: Styles.textColor),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    print('Cart Items List in Booking Court Screen: ${cartItemsNotifier.cartItems}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartDetailsScreen(
                          facility:
                          widget.facility, cartItemsNotifier: cartItemsNotifier, ), // Assuming you have a CourtList screen
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Styles.secPrimaryColor, // Set the background color to secPrimaryColor
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppLayout.getWidth(10)),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: AppLayout.getWidth(20),
                      horizontal: AppLayout.getWidth(25), // Horizontal padding (not margin)
                    ),
                  ),
                  child: Text(
                    "Next",
                    style: Styles.textStyle.copyWith(color: Colors.white),
                  ),
                ),

              ],

            ),
          ),
        ],
      ),

    );

    // Excluded from the padding of the ListView
  }
}
