import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../entities/transaction.dart';
import '../../../services/destination_services.dart';
import '../../../services/transaction_services.dart';
import '../../../shared/theme.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_destination_tile.dart';

class TransactionDetailPage extends StatelessWidget {
  const TransactionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    DestinationServices destinationServices = DestinationServices();
    TransactionServices transactionServices = TransactionServices();

    final transactionId = ModalRoute.of(context)!.settings.arguments as int;
    final fetchTransaction = transactionServices.getTransaction(transactionId);

    Widget bookingDetails(AsyncSnapshot<Transaction?> snapshot) {
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

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Booking Details",
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            transactionDetails(
              "Traveler",
              "${snapshot.data!.amountOfTraveler} Person",
              blackTextStyle,
            ),
            transactionDetails(
              "Seat",
              snapshot.data!.selectedSeat,
              blackTextStyle,
            ),
            transactionDetails(
              "Insurance",
              snapshot.data!.insurance ? "Yes" : "No",
              snapshot.data!.insurance ? greenTextStyle : redTextStyle,
            ),
            transactionDetails(
              "Refundable",
              snapshot.data!.refundable ? "Yes" : "No",
              snapshot.data!.refundable ? greenTextStyle : redTextStyle,
            ),
            transactionDetails(
              "VAT",
              "${snapshot.data!.vat * 100}%",
              blackTextStyle,
            ),
            transactionDetails(
              "Grand Total",
              formatRupiah.format(snapshot.data!.grandTotal),
              purpleTextStyle,
            ),
            transactionDetails(
              "Status",
              snapshot.data!.status,
              blackTextStyle,
            ),
          ],
        ),
      );
    }

    Widget paymentDetails(AsyncSnapshot<Transaction?> snapshot) {
      Widget paymentMethod() {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              snapshot.data!.paymentNMethod,
              style: whiteTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
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

    Widget transactionButton(AsyncSnapshot<Transaction?> snapshot) {
      Widget button(bool deleteTransaction) {
        String text;
        return CustomButton(
          text: deleteTransaction ? text = "Delete" : text = "Cancel",
          width: 327,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Are you sure $text transaction?"),
                actions: [
                  CustomButton(
                    text: "Yes",
                    width: 70,
                    onPressed: () async {
                      bool transaction = await transactionServices
                          .cancelTransaction(snapshot.data!.id);
                      if (deleteTransaction) {
                        transaction = await transactionServices
                            .deleteTransaction(snapshot.data!.id);
                      }
                      if (transaction) {
                        if (context.mounted) {
                          Navigator.pushNamed(context, "/HomePage");
                        }
                        return Fluttertoast.showToast(
                          msg: "Transaction $text Success",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: kWhiteColor,
                          textColor: kBlackColor,
                          fontSize: 16.0,
                        );
                      } else {
                        return Fluttertoast.showToast(
                          msg: "Transaction $text Failed",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: kWhiteColor,
                          textColor: kBlackColor,
                          fontSize: 16.0,
                        );
                      }
                    },
                  ),
                  CustomButton(
                    text: "No",
                    width: 70,
                    backGroundColor: kRedColor,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            );
          },
        );
      }

      if (snapshot.data!.status == "Canceled") {
        return button(true);
      }
      return button(false);
    }

    Widget destinationtile(AsyncSnapshot<Transaction?> snapshot) {
      final fetchDestination = destinationServices
          .getDestination(snapshot.data!.destination.value!.id);
      return FutureBuilder(
        future: fetchDestination,
        builder: (context, destination) {
          if (destination.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (destination.hasError) {
            return Text("${destination.error}");
          } else if (!destination.hasData || destination.data == null) {
            return const Text("No Data");
          } else {
            return CustomDestinationTile(
              imageData: destination.data!.imageData,
              name: destination.data!.name,
              location: destination.data!.location,
              rating: destination.data!.rating,
              destinationId: destination.data!.id,
            );
          }
        },
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
        child: FutureBuilder(
          future: fetchTransaction,
          builder: (context, transaction) {
            if (transaction.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (transaction.hasError) {
              return Text("${transaction.error}");
            } else if (!transaction.hasData || transaction.data == null) {
              return const Text("No Data");
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  destinationtile(transaction),
                  bookingDetails(transaction),
                  paymentDetails(transaction),
                  transactionButton(transaction),
                  termAndConditions(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
