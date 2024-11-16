import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../../shared/theme.dart";
import "../../../widget/custom_button.dart";
import "../../../provider/seat_provider.dart";

class SuccessCheckoutPage extends StatelessWidget {
  const SuccessCheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: SizedBox(
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("assets/image_success.png"),
              Text(
                "Well Booked 😍",
                style: blackTextStyle.copyWith(
                  fontSize: 32,
                  fontWeight: semiBold,
                ),
              ),
              Text(
                "Are you ready to explore the new world of experiences?",
                style: greyTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: light,
                ),
                textAlign: TextAlign.center,
              ),
              CustomButton(
                text: "My Bookings",
                width: 220,
                onPressed: () {
                  Provider.of<SeatProvider>(context, listen: false)
                      .removeAllSeatNumber();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    "/HomePage",
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
