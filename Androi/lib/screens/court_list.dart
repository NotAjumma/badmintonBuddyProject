import 'package:badmintonbuddy/utils/app_layout.dart';
import 'package:badmintonbuddy/utils/app_styles.dart';
import 'package:badmintonbuddy/widgets/cart_items_notifier.dart';
import 'package:badmintonbuddy/widgets/my_cart_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CourtList extends StatefulWidget {
  List<CartItem> cartItems = [];

  final Map<String, dynamic> court;
  final String price;
  final String duration;
  final String selectedDate;
  final String selectedTime;
  final String selectedAMPM;
  final double calculatedPrice; // Declare the calculated price property

  CourtList({
    Key? key,
    required this.court,
    required this.price,
    required this.duration,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedAMPM,
  }) :
        calculatedPrice = double.parse(price) * double.parse(duration),
        super(key: key);
  @override
  _CourtListState createState() => _CourtListState();
}

class CartItem {
  final String id;
  final String name;
  final String date;
  final String time;
  final String ampm;
  final String duration; // You can change the data type as needed
  final double price;

  CartItem(this.id, this.name, this.date, this.time, this.ampm, this.duration, this.price);

  @override
  String toString() {
    return 'CartItem ID: $id, Name: $name, Date: $date, Time: $time, AMPM: $ampm, Duration: $duration, Price: $price';
  }
}


class _CourtListState extends State<CourtList> {
  bool isAddedToCart = false;
  // double calculatedPrice = double.parse(price) * double.parse(duration); // Calculate the price
  @override
  void dispose() {
    final cartItemsNotifier = Provider.of<CartItemsNotifier>(context, listen: false);
    cartItemsNotifier.clearCart();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final cartItemsNotifier = Provider.of<CartItemsNotifier>(context);
    final size = AppLayout.getSize(context);

    return SizedBox(
      width: size.width * 0.90,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isAddedToCart ? Styles.secPrimaryColor : Styles.textColor, // Update border color
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.court['name'],
                              style: Styles.headLineStyle3.copyWith(color: Styles.textColor),
                            ),
                            Text(
                              'Total Price: \RM${widget.calculatedPrice.toStringAsFixed(2)}', // Convert the double to a formatted string
                              style: Styles.headLineStyle3.copyWith(color: Styles.textColor),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            final courtId = widget.court['courtID'];
                            final courtName = widget.court['name'];
                            final calculatedPrice = widget.calculatedPrice;
                            final selectedDate = widget.selectedDate;
                            final selectedTime = widget.selectedTime;
                            final selectedAMPM = widget.selectedAMPM;
                            final selectedDuration = widget.duration;


                            if (!isAddedToCart) {
                              final newItem = CartItem(
                                courtId,
                                courtName,
                                selectedDate, // Replace with the actual date
                                selectedTime, // Replace with the actual time
                                selectedAMPM, // Replace with the actual AMPM
                                selectedDuration, // Replace with the actual duration
                                calculatedPrice, // Replace with the actual price
                              );


                              cartItemsNotifier.addToCart(newItem);
                              print('Added to Cart: ${newItem.name}'); // Print the added item
                            } else {
                              cartItemsNotifier.removeFromCart(widget.court['courtID']);
                              print('Removed from Cart: $courtName'); // Print the removed item
                            }

                            isAddedToCart = !isAddedToCart;

                            // Print the updated cart items list
                            print('Cart Items List: ${cartItemsNotifier.cartItems}');
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: isAddedToCart ? Colors.white : Styles.secPrimaryColor,
                          minimumSize: const Size(double.infinity, 0),
                          padding: EdgeInsets.symmetric(
                            vertical: AppLayout.getWidth(15),
                            horizontal: AppLayout.getWidth(15),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppLayout.getWidth(10)),
                            side: BorderSide(
                              color: isAddedToCart ? Styles.secPrimaryColor : Colors.transparent,
                            ),
                          ),
                        ),
                        child: Text(
                          isAddedToCart ? 'Added to Cart' : 'Add to Cart',
                          style: Styles.textStyle.copyWith(
                            color: isAddedToCart ? Styles.secPrimaryColor : Colors.white,
                          ),
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
    );
  }
}
