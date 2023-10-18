import 'package:badmintonbuddy/screens/booking_court_screen.dart';
import 'package:badmintonbuddy/screens/court_list.dart';
import 'package:badmintonbuddy/screens/facility_details.dart';
import 'package:badmintonbuddy/utils/app_layout.dart';
import 'package:badmintonbuddy/utils/app_styles.dart';
import 'package:badmintonbuddy/widgets/cart_items_notifier.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

// SearchResultScreen
class SearchResultScreen extends StatelessWidget {
  final List<Map<String, dynamic>> searchResults;
  final String searchQuery; // Search query
  final VoidCallback clearFilterCallback; // Callback to clear the filter

  const SearchResultScreen({
    Key? key,
    required this.searchResults,
    required this.searchQuery, // Pass the search query
    required this.clearFilterCallback,
  }) : super(key: key);

  void goBack(BuildContext context) {
    final cartItemsNotifier = Provider.of<CartItemsNotifier>(context, listen: false);
    cartItemsNotifier.clearCart();
    Navigator.pop(context); // Use Navigator.pop to go back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.secPrimaryColor,
        title: Text(
          "Select a Badminton Facility",
          style: Styles.headLineStyle2.copyWith(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          color: (Colors.white),
          onPressed: () {
            goBack(context);
          },
        ),
      ),
      backgroundColor: Styles.bgColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align text to the start and end of the row
              children: [
                Text(
                  '${searchResults.length} Facilities found',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Price per hour',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final result = searchResults[index];
                final badmintonFacility = searchResults[index];

                return GestureDetector(
                  onTap: () {
                    // Navigate to the FacilityDetails screen when the item is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FacilityDetails(
                          facility:
                              badmintonFacility, // Pass the facility data to the details screen
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: size.width,
                    // height: AppLayout.getHeight(350),
                    // padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                    // margin: const EdgeInsets.only(top: 0),

                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Styles.secPrimaryColor, // Border color
                        width: 1, // Border width

                      ),
                      borderRadius: BorderRadius.circular(
                          AppLayout.getWidth(10)),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(

                          width: size.width,
                          height: AppLayout.getHeight(350),
                          padding: EdgeInsets.symmetric(
                              horizontal: AppLayout.getWidth(15),
                              vertical: AppLayout.getWidth(17)),
                          margin: const EdgeInsets.only(top: 0),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: AppLayout.getHeight(170),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Styles
                                      .primaryColor, // Styles.primaryColor is assumed to be defined elsewhere
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(badmintonFacility['image']),
                                  ),
                                ),
                              ),
                              const Gap(
                                  10), // Add space between name and price/hour
                              const SizedBox(height: 10),
                              // Add space between name and price/hour
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    badmintonFacility['name'],
                                    style: Styles.headLineStyle23
                                        .copyWith(color: Styles.textColor),
                                  ),
                                  Text(
                                    '\RM${badmintonFacility['price']}',
                                    style: Styles.headLineStyle2
                                        .copyWith(color: Styles.textColor),
                                  ),
                                ],
                              ),

                              const Gap(5),
                              Text(
                                '${badmintonFacility['district']}, ${badmintonFacility['state']}',
                                style: Styles.headLineStyle3
                                    .copyWith(color: Styles.textColor),
                              ),

                              const Gap(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 50, // Fixed height
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Navigate to the Facility Details screen
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FacilityDetails(
                                                      facility:
                                                          badmintonFacility),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Styles
                                              .bgColor, // Background color for "Centre Details"
                                          onPrimary: Styles
                                              .secPrimaryColor, // Text color for "Centre Details"
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                AppLayout.getWidth(10)),
                                            side: BorderSide(
                                              color: Styles
                                                  .secPrimaryColor, // Border color for "Centre Details"
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          "Centre Details",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: AppLayout.getWidth(
                                          10)), // Spacing between buttons
                                  Expanded(
                                    child: Container(
                                      height: 50, // Fixed height
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Navigate to the Court List screen
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => BookingCourtScreen(
                                                facility:
                                                badmintonFacility,), // Assuming you have a CourtList screen
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Styles
                                              .secPrimaryColor, // Background color for "Book Now"
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                AppLayout.getWidth(10)),
                                          ),
                                        ),
                                        child: Text(
                                          "Book Now",
                                          style: Styles.headLineStyle3.copyWith(
                                              color: Colors
                                                  .white), // Text style for "Book Now"
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )

                              // const SizedBox(height: 5),
                              // Text(
                              //   badmintonFacility[
                              //       'address'], // Display facility name from the badmintonFacility map
                              //   style: Styles.headLineStyle5
                              //       .copyWith(color: Styles.textColor),
                              // ),
                              // const SizedBox(height: 8),
                              // Text(
                              //   '\RM${badmintonFacility['price']}/hour', // Display price from the badmintonFacility map
                              //   style: Styles.headLineStyle2
                              //       .copyWith(color: Styles.textColor),
                              // )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
