import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/app_info_list.dart';
import '../utils/app_layout.dart';
import '../utils/app_styles.dart';
import 'court_list.dart';

class FacilityDetails extends StatelessWidget {
  final Map<String, dynamic> facility;

  const FacilityDetails({Key? key, required this.facility}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.bgColor, // Change the AppBar background color
        title: Text(
          facility['name'] ,
          style: Styles.headLineStyle2
            .copyWith(color: Styles.textColor),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          color: const Color(0xFF3b3b3b),// Use an X button instead of the back arrow
          onPressed: () {
            Navigator.of(context).pop(); // Close the FacilityDetails screen
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: AppLayout.getHeight(180),
            decoration: BoxDecoration(
              color: Styles.primaryColor,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("images/${facility['image']}"),
              ),
            ),
          ),
          const Gap(10), // Add padding below the image
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16), // Padding for other content
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   facility['name'],
                //   style: Styles.headLineStyle3.copyWith(color: Styles.textColor),
                // ),
                const SizedBox(height: 10),
                Text(
                  facility['district'],
                  style: Styles.headLineStyle4.copyWith(color: Styles.textColor),
                ),
                const SizedBox(height: 10),
                Text(
                  facility['address'],
                  style: Styles.headLineStyle5.copyWith(color: Styles.textColor),
                ),
                const SizedBox(height: 10),
                Text(
                  '\RM${facility['price']}/hour',
                  style: Styles.headLineStyle4.copyWith(color: Styles.textColor),
                ),
                const SizedBox(height: 15),

              ],
            ),
          ),
          /*SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: bookList
                  .map((singleBook) => CourtList(book: singleBook))
                  .toList() ??
                  [],
            ),
          ),*/

        ],
      ),



    );
  }
}
