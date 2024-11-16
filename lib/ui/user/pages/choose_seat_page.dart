import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/seat_provider.dart';
import '../../../services/destination_services.dart';
import '../../../shared/theme.dart';
import '../widget/custom_button.dart';
import '../widget/custom_choose_seat.dart';

class ChooseSeatPage extends StatelessWidget {
  const ChooseSeatPage({super.key});

  @override
  Widget build(BuildContext context) {
    DestinationServices destinationServices = DestinationServices();

    final destinationId = ModalRoute.of(context)!.settings.arguments as int;
    final destination = destinationServices.getDestination(destinationId);
    int randomSeatId() {
      List<int> seatIdList = [0, 1, 2];
      final random = Random();
      int randomIndex = random.nextInt(seatIdList.length);
      int randomSeatId = seatIdList[randomIndex];
      return randomSeatId;
    }

    Widget seatLegend() {
      Widget legend(String imageUrl, String text) {
        return SizedBox(
          child: Row(
            children: [
              Image.asset(imageUrl, width: 16),
              const SizedBox(width: 6),
              Text(
                text,
                style:
                    blackTextStyle.copyWith(fontSize: 14, fontWeight: regular),
              ),
            ],
          ),
        );
      }

      return SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            legend("assets/icon_available.png", "Available"),
            legend("assets/icon_selected.png", "Selected"),
            legend("assets/icon_unavailable.png", "Unavailable"),
          ],
        ),
      );
    }

    Widget chooseSeat() {
      Widget seatColumn(String seat) {
        return SizedBox(
          width: 48,
          child: Center(
            child: Text(
              seat,
              style: greyTextStyle.copyWith(
                fontSize: 16,
                fontWeight: regular,
              ),
            ),
          ),
        );
      }

      Widget row1() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            seatColumn("A"),
            seatColumn("B"),
            seatColumn(" "),
            seatColumn("C"),
            seatColumn("D"),
          ],
        );
      }

      Widget row2() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomChooseSeat(seatId: randomSeatId(), seat: "A1"),
            CustomChooseSeat(seatId: randomSeatId(), seat: "B1"),
            seatColumn("1"),
            CustomChooseSeat(seatId: randomSeatId(), seat: "C1"),
            CustomChooseSeat(seatId: randomSeatId(), seat: "D1"),
          ],
        );
      }

      Widget row3() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomChooseSeat(seatId: randomSeatId(), seat: "A2"),
            CustomChooseSeat(seatId: randomSeatId(), seat: "B2"),
            seatColumn("2"),
            CustomChooseSeat(seatId: randomSeatId(), seat: "C2"),
            CustomChooseSeat(seatId: randomSeatId(), seat: "D2"),
          ],
        );
      }

      Widget row4() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomChooseSeat(seatId: randomSeatId(), seat: "A3"),
            CustomChooseSeat(seatId: randomSeatId(), seat: "B3"),
            seatColumn("3"),
            CustomChooseSeat(seatId: randomSeatId(), seat: "C3"),
            CustomChooseSeat(seatId: randomSeatId(), seat: "D3"),
          ],
        );
      }

      Widget row5() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomChooseSeat(seatId: randomSeatId(), seat: "A4"),
            CustomChooseSeat(seatId: randomSeatId(), seat: "B4"),
            seatColumn("4"),
            CustomChooseSeat(seatId: randomSeatId(), seat: "C4"),
            CustomChooseSeat(seatId: randomSeatId(), seat: "D4"),
          ],
        );
      }

      Widget row6() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomChooseSeat(seatId: randomSeatId(), seat: "A5"),
            CustomChooseSeat(seatId: randomSeatId(), seat: "B5"),
            seatColumn("5"),
            CustomChooseSeat(seatId: randomSeatId(), seat: "C5"),
            CustomChooseSeat(seatId: randomSeatId(), seat: "D5"),
          ],
        );
      }

      return Container(
        height: 500,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            row1(),
            row2(),
            row3(),
            row4(),
            row5(),
            row6(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Your seat",
                  style: greyTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: light,
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Consumer<SeatProvider>(
                      builder: (context, value, child) {
                        return Text(
                          value.seatNumber.join(", "),
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                          overflow: TextOverflow.clip,
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: greyTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: light,
                  ),
                ),
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
                          return Text(
                            formatRupiah.format(
                                snapshot.data!.price * value.seatNumber.length),
                            style: purpleTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          );
                        },
                      );
                    }
                  },
                )
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Select Your Favorite Seat",
                  style: blackTextStyle.copyWith(
                      fontSize: 24, fontWeight: semiBold),
                ),
                seatLegend(),
                chooseSeat(),
                CustomButton(
                  text: "Continue to Checkout",
                  width: 327,
                  onPressed: () {
                    Navigator.pushNamed(context, "/CheckOutPage",
                        arguments: destinationId);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
