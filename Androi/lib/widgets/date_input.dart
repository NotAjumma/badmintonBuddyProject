import 'package:badmintonbuddy/utils/app_layout.dart';
import 'package:badmintonbuddy/utils/app_styles.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateInput extends StatefulWidget {
  final ValueChanged<DateTime?> onDateSelected;

  const DateInput({Key? key, required this.onDateSelected}) : super(key: key);

  @override
  _DateInputState createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  DateTime? _selectedDate;

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

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF4F6FD),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                Padding(
                  padding: const EdgeInsets.all(14.0), // You can adjust the padding values as needed
                    child: GestureDetector(
                      onTap: () => _selectDate(context),
                      child: SizedBox(
                        width: AppLayout.getWidth(250), // Adjust the width as needed
                        child: Text(
                          _selectedDate == null
                              ? "Select a date"
                              : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                          style: Styles.textStyle,
                        ),
                      ),
                    )

                )

              ],
            ),
          )
        ],
      ),
    );
    //   Container(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(10),
    //     color: const Color(0xFFF4F6FD),
    //   ),
    //
    // padding: EdgeInsets.symmetric(horizontal: 12),
    //   child: Row(
    //     children: [
    //       const Icon(
    //         Icons.calendar_today,
    //         color: Color(0xFF3b3b3b),
    //       ),
    //       Padding(
    //         padding: EdgeInsets.symmetric(horizontal: 10),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             GestureDetector(
    //               onTap: () => _selectDate(context),
    //               child: SizedBox(
    //                 width: size.width, // Adjust the width as needed
    //                 child: Text(
    //                   _selectedDate == null
    //                       ? "Select a date"
    //                       : DateFormat('yyyy-MM-dd').format(_selectedDate!),
    //                   style: Styles.textStyle,
    //                 ),
    //               ),
    //             ),
    //
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
