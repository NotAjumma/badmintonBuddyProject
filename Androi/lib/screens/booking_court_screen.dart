import 'dart:convert';

import 'package:badmintonbuddy/screens/badminton_facility_vertical_screen.dart';
import 'package:badmintonbuddy/screens/badmiton_facility_screen.dart';
import 'package:badmintonbuddy/screens/court_list.dart';
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


class BookingCourtScreen extends StatefulWidget {
  final Map<String, dynamic> facility;

  const BookingCourtScreen({Key? key, required this.facility})
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
    '1 hour',
    '1.5 hours',
    '2 hours',
    '2.5 hours',
    '3 hours',
    '3.5 hours',
    '4 hours',
    '4.5 hours',
    '5 hours',
    '5.5 hours',
    '6 hours'
  ];

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

  void _showCustomDropdownDialog(
      BuildContext context, List<String> items, String? initialValue, Function(String?) onSelected) {
    String? selectedValue = initialValue;
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
                    selectedValue = items[index];
                    onSelected(selectedValue);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }


  void _showCustomDropdownDialogAmPm(
      BuildContext context, List<String> items, String? initialValue, Function(String?) onSelected) {
    String? selectedValue = initialValue;
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
                    setState(() {
                      _selectedAMPM = items[index]; // Update the selectedAMPM
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
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
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Styles.bgColor,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppLayout.getWidth(20),
            ),
          ),
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
                                    : DateFormat('yyyy-MM-dd').format(_selectedDate!),
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
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppLayout.getWidth(10),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppLayout.getWidth(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () {
                        _showCustomDropdownDialog(
                            context, startTimes, _selectedStartTime, (String? value) {
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
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
                            context, AMPMOptions, _selectedAMPM, (String? value) {
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
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
                        _showCustomDropdownDialog(
                            context, durations, _selectedDuration, (String? value) {
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
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.only(left: 20, bottom: 10),

            child: Text(
              "Select your badminton court",
              style: Styles.headLineStyle2.copyWith(color: Styles.textColor)
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: bookList
                  .map((singleBook) => CourtList(book: singleBook))
                  .toList() ??
                  [],
            ),
          ),
        ],
      ),


    );

      // Excluded from the padding of the ListView


    }
}

