import 'package:badmintonbuddy/utils/app_layout.dart';
import 'package:badmintonbuddy/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BadmintonFacilityVerticalScreen extends StatelessWidget {
  final Map<String, dynamic> badmintonFacility;
  const BadmintonFacilityVerticalScreen({
    Key? key,
    required this.badmintonFacility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Container(
      width: size.width, // Full-width container
      height: 305,
      padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(5)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 20,
            spreadRadius: 5,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            width: size.width, // Full-width image
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Styles.primaryColor,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("images/${badmintonFacility['image']}"),
              ),
            ),
          ),
          const Gap(10),
          Text(
            badmintonFacility['name'],
            style: Styles.headLineStyle23.copyWith(color: Styles.textColor),
          ),
          const Gap(5),
          Text(
            badmintonFacility['district'],
            style: Styles.headLineStyle3.copyWith(color: Styles.textColor),
          ),
          const Gap(8),
          Text(
            '\RM${badmintonFacility['price']}/hour',
            style: Styles.headLineStyle2.copyWith(color: Styles.textColor),
          ),
        ],
      ),
    );
  }
}
