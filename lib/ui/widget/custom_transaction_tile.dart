import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class CustomTransactionTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String location;
  final String seat;
  final int grandTotal;
  const CustomTransactionTile({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.seat,
    required this.grandTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
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
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(imageUrl),
                      )),
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
                    Row(
                      children: [
                        Text(
                          location,
                          style: greyTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: light,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Seat: $seat",
                          style: greyTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: light,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "GrandTotal: $grandTotal",
                      style: greyTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: light,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
