import 'package:flutter/material.dart';

import '../../entities/user.dart';
import '../../services/user_services.dart';
import '../../shared/theme.dart';
import '../widget/custom_button.dart';

class BonusPage extends StatelessWidget {
  const BonusPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserServices userServices = UserServices();
    final fetchUserInfo = userServices.getUser();

    Widget wallet(AsyncSnapshot<User?> snapshot) {
      return Container(
        margin: const EdgeInsets.only(left: 37, right: 37),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(34),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: whiteTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: light,
                          ),
                        ),
                        Text(
                          snapshot.data!.name.toString(),
                          style: whiteTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: medium,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icon_plane.png",
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Pay",
                          style: whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Balance",
                    style: whiteTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: light,
                    ),
                  ),
                  Text(
                    formatRupiah.format(snapshot.data!.wallet),
                    style: whiteTextStyle.copyWith(
                      fontSize: 26,
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget bonus() {
      return SizedBox(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Big Bonus ",
                  style: blackTextStyle.copyWith(
                    fontSize: 32,
                    fontWeight: semiBold,
                  ),
                ),
                const Icon(Icons.handshake),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "We give you early credit so that\nyou can buy a flight ticket",
              style: greyTextStyle.copyWith(
                fontSize: 14,
                fontWeight: light,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    Widget button(AsyncSnapshot<User?> snapshot) {
      return CustomButton(
        text: "Start Fly Now",
        width: 220,
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/HomePage",
            (Route<dynamic> route) => false,
          );
        },
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: FutureBuilder(
          future: fetchUserInfo,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Text("No Data");
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  wallet(snapshot),
                  bonus(),
                  button(snapshot),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
