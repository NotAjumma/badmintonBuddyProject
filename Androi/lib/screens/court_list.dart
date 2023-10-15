import 'package:badmintonbuddy/utils/app_layout.dart';
import 'package:badmintonbuddy/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourtList extends StatelessWidget {
  final Map<String, dynamic> court;
  final String price; // Add a price property
  const CourtList({Key? key, required this.court, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return SizedBox(
      width: size.width*0.90,
      height: 170,
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF526799),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(21),
                    topRight: Radius.circular(21),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          court['name'],
                          style: Styles.headLineStyle3
                              .copyWith(color: Colors.white),
                        ),
                        // Text(
                        //   court['price'],
                        //   style: Styles.headLineStyle3
                        //       .copyWith(color: Colors.white),
                        // ),

                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     SizedBox(
                    //       width: 100,
                    //       child: Text(
                    //         'Date',
                    //         style: Styles.headLineStyle4
                    //             .copyWith(color: Colors.white),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 100,
                    //       child: Center(
                    //         child: Text(
                    //           court['facilityName'],
                    //           style: Styles.headLineStyle5.copyWith(color: Colors.white),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 100,
                    //       child: Text(
                    //         'Total',
                    //         textAlign: TextAlign.end,
                    //         style: Styles.headLineStyle4
                    //             .copyWith(color: Colors.white),
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                )),
            Container(
              decoration: BoxDecoration(
                color: Styles.orangeColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(21),
                  bottomRight: Radius.circular(21),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\RM$price/hour',
                            style: Styles.headLineStyle2.copyWith(color:Colors.white),
                          )
                          // Text(
                          //   "Start",
                          //   style: Styles.headLineStyle4
                          //       .copyWith(color: Colors.white),
                          // ),
                        ],
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       court['duration'],
                      //       style: Styles.headLineStyle3
                      //           .copyWith(color: Colors.white),
                      //     ),
                      //     // Text(
                      //     //   "",
                      //     //   style: Styles.headLineStyle4
                      //     //       .copyWith(color: Colors.white),
                      //     // ),
                      //   ],
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Text(
                          //   court['endTime'],
                          //   style: Styles.headLineStyle3
                          //       .copyWith(color: Colors.white),
                          // ),
                          Text(
                            "Add to cart",
                            style: Styles.headLineStyle4
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
          //Show blue part of booking
        ),
      ),
    );
  }
}
