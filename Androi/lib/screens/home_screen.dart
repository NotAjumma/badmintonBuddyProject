import 'dart:convert';

import 'package:badmintonbuddy/screens/badmiton_facility_screen.dart';
import 'package:badmintonbuddy/screens/booking_view.dart';
import 'package:badmintonbuddy/screens/search_result_screen.dart';
import 'package:badmintonbuddy/utils/app_info_list.dart';
import 'package:badmintonbuddy/utils/app_layout.dart';
import 'package:badmintonbuddy/utils/app_styles.dart';
import 'package:badmintonbuddy/widgets/icon_text_widget.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:badmintonbuddy/data_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../utils/app_api_list.dart';

final TextEditingController searchController = TextEditingController();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();

  void onDateSelected(DateTime? selectedDate) {}
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? _selectedDate;
  List<Map<String, dynamic>> badmintonFacilityList = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    fetchBadmintonFacilities();
  }

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
    final response = await http.get(Uri.parse(
        APIsBook.getDataFacilityUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        badmintonFacilityList = jsonResponse.cast<Map<String, dynamic>>();
      });
    } else {
      throw Exception('Failed to load facilities from the server');
    }
  }

  // List<Map<String, dynamic>> filterFacilities(String query) {
  //   return badmintonFacilityList.where((facility) {
  //     final String facilityName = facility['name'].toString().toLowerCase();
  //     final String facilityState = facility['state'].toString().toLowerCase();
  //     final String facilityDistrict =
  //     facility['district'].toString().toLowerCase();
  //
  //     return facilityName.contains(query.toLowerCase()) ||
  //         facilityState.contains(query.toLowerCase()) ||
  //         facilityDistrict.contains(query.toLowerCase());
  //   }).toList();
  // }

  // HomeScreen
  Future<void> handleFindCourtsButtonClick() async {
    setState(() {
      isSearching = true;
    });

    try {
      final response = await http.get(Uri.parse(
          '${APIsBook.searchFacilityUrl}?query=${searchController.text}'));

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final List<Map<String, dynamic>> searchResults =
        jsonResponse.cast<Map<String, dynamic>>();

        // Pass the search query along with the results to SearchResultScreen
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SearchResultScreen(
              searchResults: searchResults,
              clearFilterCallback: () {
                // Callback to clear the filter
                setState(() {
                  isSearching = false;
                  searchController.text = '';
                  searchResults.clear(); // Clear the filtered list
                });
              },
              searchQuery: searchController.text, // Pass the search query
            ),
          ),
        );
      } else {
        print('API request failed with status code ${response.statusCode}');
      }
    } catch (error) {
      print('Error searching for facilities: $error');
    }
  }

  String greetUserByTime() {
    final now = DateTime.now();
    final currentTime = now.hour;

    if (currentTime >= 5 && currentTime < 12) {
      return "Good morning";
    } else if (currentTime >= 12 && currentTime < 17) {
      return "Good afternoon";
    } else {
      return "Good evening";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          greetUserByTime(),
                          style: Styles.headLineStyle3,
                        ),

                        const Gap(5),
                        Text(
                          "Book Courts",
                          style: Styles.headLineStyle1,
                        )
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: AssetImage(
                                  "assets/images/badminton_buddy_logo.png"))),
                    )
                  ],
                ),
                const Gap(25),
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
                              width: AppLayout.getWidth(250),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: "Where are you looking to play?",
                                  border: InputBorder.none,
                                ),
                                style: Styles.textStyle,
                                controller: searchController,
                                // onChanged: (query) {
                                //   setState(() {
                                //     badmintonFacilityList =
                                //         filterFacilities(query);
                                //   });
                                // },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Gap(AppLayout.getHeight(10)),

                GestureDetector(
                  onTap: handleFindCourtsButtonClick,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: AppLayout.getWidth(15),
                        horizontal: AppLayout.getWidth(15)),
                    decoration: BoxDecoration(
                      color: const Color(0xD91130CE),
                      borderRadius:
                      BorderRadius.circular(AppLayout.getWidth(10)),
                    ),
                    child: Center(
                      child: Text(
                        isSearching ? "Find Facility" : "Find Facility",
                        style: Styles.textStyle.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Upcoming Courts",
                      style: Styles.headLineStyle2,
                    ),
                    InkWell(
                      onTap: () {
                        print("You are tapped");
                      },
                      child: Text(
                        "View all",
                        style: Styles.textStyle
                            .copyWith(color: Styles.primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: bookList
                  .map((singleBook) => BookingView(book: singleBook))
                  .toList() ??
                  [],
            ),
          ),
          const Gap(15),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: AppLayout.getWidth(15),
              horizontal: AppLayout.getWidth(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Famous Facility",
                  style: Styles.headLineStyle2,
                ),
                InkWell(
                  onTap: () {
                    print("You are tapped");
                  },
                  child: Text(
                    "View all",
                    style: Styles.textStyle.copyWith(color: Styles.primaryColor),
                  ),
                ),
              ],
            ),
          ),


          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: badmintonFacilityList
                    .map((singleFacility) =>
                    BadmintonFacilityScreen(badmintonFacility: singleFacility))
                    .toList(),
              ),
            ),
          ),
          const Gap(15),
        ],
      ),
    );
  }
}
