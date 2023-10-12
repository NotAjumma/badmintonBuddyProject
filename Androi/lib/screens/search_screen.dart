import 'dart:convert';

import 'package:badmintonbuddy/screens/badminton_facility_vertical_screen.dart';
import 'package:badmintonbuddy/screens/badmiton_facility_screen.dart';
import 'package:badmintonbuddy/utils/app_info_list.dart';
import 'package:badmintonbuddy/utils/app_layout.dart';
import 'package:badmintonbuddy/utils/app_styles.dart';
import 'package:badmintonbuddy/widgets/icon_text_widget.dart';
import 'package:badmintonbuddy/widgets/date_input.dart';
import 'package:badmintonbuddy/data_service.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

final TextEditingController searchController = TextEditingController();

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();

  void onDateSelected(DateTime? selectedDate) {}
}

class _SearchScreenState extends State<SearchScreen> {
  DateTime? _selectedDate;
  List<Map<String, dynamic>> badmintonFacilityList = [];
  List<Map<String, dynamic>> filteredFacilityList = []; // Add a filtered list
  bool isSearching = false; // Flag to track whether the user is searching
  // List<Map<String, dynamic>> bookList = [];

  @override
  void initState() {
    super.initState();
    fetchBadmintonFacilities();
  }
  // void initState() {
  //   super.initState();
  //   // Fetch data when the widget is initialized
  //   fetchAndSetData();
  // }

  // Future<void> fetchAndSetData() async {
  //   try {
  //     // Fetch badminton facilities data
  //     final facilities = await fetchBadmintonFacilities();
  //     setState(() {
  //       badmintonFacilityList = facilities;
  //     });
  //
  //   } catch (error) {
  //     print('Error fetching data: $error');
  //     // Handle error as needed
  //   }
  // }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateSelected(_selectedDate);
    }
  }

  Future<void> fetchBadmintonFacilities() async {
    final response = await http.get(Uri.parse('http://192.168.137.1/BadmintonBuddyServerSide/get_data.php'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        badmintonFacilityList = jsonResponse.cast<Map<String, dynamic>>();
      });
    } else {
      throw Exception('Failed to load facilities from the server');
    }
  }

  List<Map<String, dynamic>> filterFacilities(String query) {
    return badmintonFacilityList.where((facility) {
      final String facilityName = facility['name'].toString().toLowerCase();
      final String facilityState = facility['state'].toString().toLowerCase();
      final String facilityDistrict = facility['district'].toString().toLowerCase();

      // Check if the query matches any of the fields.
      return facilityName.contains(query.toLowerCase()) ||
          facilityState.contains(query.toLowerCase()) ||
          facilityDistrict.contains(query.toLowerCase());
    }).toList();
  }

  // Function to handle "find courts" button click
  void handleFindCourtsButtonClick() {
    if (isSearching) {
      // If currently searching, toggle back to displaying the original list
      setState(() {
        isSearching = false;
        searchController.text = ''; // Clear the search text
      });
    } else {
      // If not searching, perform a new search based on the current query
      setState(() {
        isSearching = true;
        filteredFacilityList = filterFacilities(searchController.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: AppLayout.getWidth(20),
            vertical: AppLayout.getHeight(20)),
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFF4F6FD),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Icon(
                  FluentSystemIcons.ic_fluent_search_regular,
                  color: Color(0xFF3b3b3b),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppLayout.getWidth(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: AppLayout.getWidth(
                            250), // Adjust the width as needed
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Where are you looking to play?",
                            border: InputBorder.none,
                          ),
                          style: Styles.textStyle,
                          controller: searchController, // Use the TextEditingController
                          onChanged: (query) {
                            setState(() {
                              // Update the UI with filtered results based on user input.
                              badmintonFacilityList = filterFacilities(query);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Gap(AppLayout.getHeight(10)),
          Container(
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
                        padding: const EdgeInsets.all(
                            14.0), // You can adjust the padding values as needed
                        child: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: SizedBox(
                            width: AppLayout.getWidth(250),
                            child: Text(
                              _selectedDate == null
                                  ? "Select a date"
                                  : DateFormat('yyyy-MM-dd')
                                      .format(_selectedDate!),
                              style: Styles.textStyle,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          Gap(AppLayout.getHeight(10)),
          const AppIconText(
              icon: Icons.timer_rounded,
              subLabel: "Time",
              label: "Select a time"),
          Gap(AppLayout.getHeight(15)),
          GestureDetector(
            onTap: handleFindCourtsButtonClick, // Handle button click
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: AppLayout.getWidth(15),
                  horizontal: AppLayout.getWidth(15)),
              decoration: BoxDecoration(
                color: const Color(0xD91130CE),
                borderRadius: BorderRadius.circular(AppLayout.getWidth(10)),
              ),
              child: Center(
                child: Text(
                  isSearching ? "Cancel" : "Find Courts",
                  style: Styles.textStyle.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),


          Gap(AppLayout.getHeight(15)),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: badmintonFacilityList
                  .map((singleFacility) =>
                  BadmintonFacilityVerticalScreen(badmintonFacility: singleFacility))
                  .toList(),
            ),
          ),

          // FittedBox(
          //   child: Container(
          //     padding: const EdgeInsets.all(3.5),
          //     child: Row(
          //       children: [
          //         /*
          //         airline tickets
          //          */
          //         Container(
          //           width: size.width*.44,
          //           padding: EdgeInsets.symmetric(vertical: AppLayout.getHeight(7)),
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.horizontal(left: Radius.circular(AppLayout.getHeight(50)),),
          //               color: Colors.white
          //           ),
          //           child: Center(child: Text("Airline tickets")),
          //         ),
          //       /*
          //       hotels
          //       * */
          //         Container(
          //           width: size.width*.44,
          //           padding: EdgeInsets.symmetric(vertical: AppLayout.getHeight(7)),
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.horizontal(right: Radius.circular(AppLayout.getHeight(50)),),
          //               color: Colors.transparent
          //           ),
          //           child: Center(child: Text("Hotels")),
          //         ),
          //       ],
          //     ),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(AppLayout.getHeight(50),),
          //       color: const Color(0xFFF4F6FD)
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
