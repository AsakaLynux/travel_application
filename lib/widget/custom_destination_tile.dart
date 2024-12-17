import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/destination_services.dart';
import "../shared/theme.dart";

class CustomDestinationTile extends StatelessWidget {
  final List<int> imageData;
  final String name;
  final String location;
  final double rating;
  final bool admin;
  final int destinationId;
  const CustomDestinationTile({
    super.key,
    required this.imageData,
    required this.name,
    required this.location,
    required this.rating,
    required this.destinationId,
    this.admin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      width: 327,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: kWhiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Image.memory(
                    Uint8List.fromList(imageData),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      location,
                      style: greyTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: light,
                      ),
                    )
                  ],
                ),
                admin
                    ? GestureDetector(
                        onTap: () async {
                          DestinationServices destinationServices =
                              DestinationServices();
                          bool deleteDestination = await destinationServices
                              .deleteDestination(destinationId);
                          if (deleteDestination) {
                            Fluttertoast.showToast(
                              msg: "Success Delete Destination",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: kWhiteColor,
                              textColor: kBlackColor,
                              fontSize: 16.0,
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg: "Failed Delete Destination",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: kWhiteColor,
                              textColor: kBlackColor,
                              fontSize: 16.0,
                            );
                          }
                        },
                        child: const Icon(Icons.delete_outline),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/icon_star.png", width: 24, height: 24),
                const SizedBox(width: 5),
                Text(
                  rating.toString(),
                  style: blackTextStyle.copyWith(
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
}
