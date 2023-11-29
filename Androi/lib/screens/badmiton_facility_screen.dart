import 'package:badmintonbuddy/utils/app_layout.dart';
import 'package:badmintonbuddy/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BadmintonFacilityScreen extends StatelessWidget {
  final Map<String, dynamic> badmintonFacility;
  const BadmintonFacilityScreen({Key? key, required this.badmintonFacility}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Container(
      width: size.width * 0.6,
      // height: AppLayout.getHeight(330),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
      margin: const EdgeInsets.only(right: 17, top: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF526799),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Styles.primaryColor,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(badmintonFacility['image']),
              ),

            ),
          ),
          const Gap(10),
          Text(
            badmintonFacility['name'],
            style: Styles.headLineStyle23.copyWith(color: Colors.white),
            overflow: TextOverflow.ellipsis, // Add ellipsis for overflowing text
          ),
          const Gap(5),
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Text(
              badmintonFacility['district'],
              style: Styles.headLineStyle3.copyWith(color: Colors.white),
              overflow: TextOverflow.ellipsis, // Add ellipsis for overflowing text
            ),
          ),
          Text(
            '\RM${badmintonFacility['price']}/hour',
            style: Styles.headLineStyle2.copyWith(color: Colors.white),
            overflow: TextOverflow.ellipsis, // Add ellipsis for overflowing text
          ),
        ],
      ),
    );
  }
}


