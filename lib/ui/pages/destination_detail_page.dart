import 'package:flutter/material.dart';

import '../../entities/destination.dart';
import '../../services/destination_services.dart';
import '../../shared/theme.dart';
import '../widget/custom_button.dart';
import '../widget/custom_photo_frame.dart';
import 'choose_seat_page.dart';

class DestinationDetailPage extends StatelessWidget {
  const DestinationDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final destinationId = ModalRoute.of(context)!.settings.arguments as int;
    DestinationServices destinationServices = DestinationServices();
    final destination = destinationServices.getDestination(destinationId);
    Widget destinationBackground(AsyncSnapshot<Destination?> snapshot) {
      Widget destinationTitle(AsyncSnapshot<Destination?> snapshot) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data!.name,
                      style: whiteTextStyle.copyWith(
                          fontSize: 24, fontWeight: semiBold),
                    ),
                    Text(
                      snapshot.data!.location,
                      style: whiteTextStyle.copyWith(
                          fontSize: 16, fontWeight: light),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/icon_star.png", width: 24, height: 24),
                    const SizedBox(width: 5),
                    Text(
                      snapshot.data!.rating.toString(),
                      style: whiteTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }

      return Container(
        height: 450,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 40, bottom: 40),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              snapshot.data!.imageUrl,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/image_emblem.png",
              height: 24,
            ),
            destinationTitle(snapshot),
          ],
        ),
      );
    }

    Widget destinationBook(AsyncSnapshot<Destination?> snapshot) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formatRupiah.format(snapshot.data!.price),
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Per orang",
                  style: greyTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: light,
                  ),
                )
              ],
            ),
            CustomButton(
              text: "Book Now",
              width: 170,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChooseSeatPage(),
                    settings: RouteSettings(arguments: snapshot.data!.id),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    Widget destinationAbout() {
      Widget about() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About",
              style:
                  blackTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
            ),
            const SizedBox(height: 6),
            Text(
              "Berada di jalur jalan provinsi yang menghubungkan Denpasar Singaraja serta letaknya yang dekat dengan Kebun Raya Eka Karya menjadikan tempat Bali.",
              style: blackTextStyle.copyWith(fontSize: 14, fontWeight: regular),
              softWrap: true,
              textAlign: TextAlign.justify,
            ),
          ],
        );
      }

      Widget photos() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Photos",
              style:
                  blackTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return const CustomPhotoFrame();
                },
              ),
            )
          ],
        );
      }

      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 310,
          margin: const EdgeInsets.only(left: 24, right: 24, bottom: 140),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: Column(
            children: [
              about(),
              const SizedBox(height: 20),
              photos(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: FutureBuilder(
        future: destination,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Text("No Data");
          } else {
            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    destinationBackground(snapshot),
                    destinationBook(snapshot),
                  ],
                ),
                destinationAbout(),
              ],
            );
          }
        },
      ),
    );
  }
}
