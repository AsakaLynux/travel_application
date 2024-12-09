import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:provider/provider.dart";

import "../../../services/transaction_services.dart";
import "../../../model/payment_method_model.dart";
import "../../../provider/seat_provider.dart";
import "../../../services/destination_services.dart";
import "../../../services/user_services.dart";
import "../../../shared/theme.dart";
import "../../../widget/custom_button.dart";
import "../../../widget/custom_destination_tile.dart";

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  PaymentMethod? selectedPayment;
  DestinationServices destinationServices = DestinationServices();
  TransactionServices transactionServices = TransactionServices();
  UserServices userServices = UserServices();

  late int amountOfTraveler;
  late String selectedSeat;
  late bool insurance;
  late bool refundable;
  late double vat;
  late int price;
  late double grandTotal;

  @override
  Widget build(BuildContext context) {
    final destinationId = ModalRoute.of(context)!.settings.arguments as int;
    final destination = destinationServices.getDestination(destinationId);

    Widget checkoutCard() {
      Widget bookingDetails() {
        Widget transactionDetails(
          String detail,
          String value,
          TextStyle style,
        ) {
          return Container(
            margin: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icon_check.png",
                        width: 14,
                        height: 14,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        detail,
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  value,
                  style: style.copyWith(
                    fontSize: 14,
                    fontWeight: regular,
                  ),
                )
              ],
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Booking Details",
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            Consumer<SeatProvider>(
              builder: (context, value, child) {
                amountOfTraveler = value.seatNumber.length;
                insurance = true;
                refundable = false;
                vat = 0.45;

                selectedSeat = value.seatNumber.join(", ");
                return Column(
                  children: [
                    transactionDetails(
                      "Traveler",
                      "${value.seatNumber.length.toString()} Orang",
                      blackTextStyle,
                    ),
                    transactionDetails(
                      "Seat",
                      value.seatNumber.join(", "),
                      blackTextStyle,
                    ),
                  ],
                );
              },
            ),
            // Consumer<SeatProvider>(
            //   builder: (context, value, child) {
            //     return transactionDetails(
            //       "Seat",
            //       value.seatNumber.join(", "),
            //       blackTextStyle,
            //     );
            //   },
            // ),
            transactionDetails("Insurance", "YES", greenTextStyle),
            transactionDetails("Refundable", "NO", redTextStyle),
            transactionDetails("VAT", "45%", blackTextStyle),
            FutureBuilder(
              future: destination,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Text("No Data");
                } else {
                  return Consumer<SeatProvider>(
                    builder: (context, value, child) {
                      price = snapshot.data!.price * value.seatNumber.length;
                      double vat = price * 0.45;
                      grandTotal = (price + vat);
                      return Column(
                        children: [
                          transactionDetails(
                            "Price",
                            formatRupiah.format(
                              snapshot.data!.price * value.seatNumber.length,
                            ),
                            blackTextStyle,
                          ),
                          transactionDetails(
                            "Grand Total",
                            formatRupiah.format(grandTotal),
                            purpleTextStyle,
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        );
      }

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          children: [
            FutureBuilder(
              future: destination,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Text("No Data");
                } else {
                  return CustomDestinationTile(
                    imageData: snapshot.data!.imageData,
                    name: snapshot.data!.name,
                    location: snapshot.data!.location,
                    rating: snapshot.data!.rating,
                    destinationId: snapshot.data!.id,
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            bookingDetails(),
          ],
        ),
      );
    }

    Widget paymentDetails() {
      Widget paymentMethod() {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 20),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: DropdownButton<PaymentMethod>(
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
            dropdownColor: kPrimaryColor,
            borderRadius: BorderRadius.circular(defaultRadius),
            value: selectedPayment,
            hint: Text(
              "Select Payment Method",
              style: whiteTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            onChanged: (PaymentMethod? newValue) {
              setState(() {
                selectedPayment = newValue!;
              });
            },
            items: listPayment.map(
              (PaymentMethod item) {
                return DropdownMenuItem<PaymentMethod>(
                  value: item,
                  child: Text(item.name),
                );
              },
            ).toList(),
          ),
        );
      }

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment Methods",
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(height: 16),
            paymentMethod(),
          ],
        ),
      );
    }

    Widget termAndConditions() {
      return SizedBox(
        child: Text(
          "Terms and Conditions",
          style: greyTextStyle.copyWith(
            fontSize: 16,
            fontWeight: light,
            decoration: TextDecoration.underline,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            checkoutCard(),
            paymentDetails(),
            CustomButton(
              text: "Pay Now",
              width: 327,
              onPressed: () async {
                final userData = await userServices.getUser();
                final transaction = await transactionServices.addTransaction(
                    amountOfTraveler,
                    selectedSeat,
                    insurance,
                    refundable,
                    vat,
                    price,
                    grandTotal,
                    destinationId,
                    selectedPayment!.name);
                if (userData != null && userData.wallet < grandTotal) {
                  if (transaction) {
                    if (context.mounted) {
                      Navigator.pushNamed(context, "/SuccessCheckOutPage");
                    }
                    return Fluttertoast.showToast(
                      msg: "Transaction Success",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: kWhiteColor,
                      textColor: kBlackColor,
                      fontSize: 16.0,
                    );
                  } else {
                    return Fluttertoast.showToast(
                      msg: "Transaction Failed",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: kWhiteColor,
                      textColor: kBlackColor,
                      fontSize: 16.0,
                    );
                  }
                } else {
                  return Fluttertoast.showToast(
                    msg: "You don't have enough money",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: kWhiteColor,
                    textColor: kBlackColor,
                    fontSize: 16.0,
                  );
                }
              },
            ),
            termAndConditions(),
          ],
        ),
      ),
    );
  }
}
