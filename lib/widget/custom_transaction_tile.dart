import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../shared/theme.dart';

class CustomTransactionTile extends StatelessWidget {
  final List<int> imageData;
  final String name;
  final String location;
  final int person;
  final double grandTotal;
  final String status;
  const CustomTransactionTile({
    super.key,
    required this.imageData,
    required this.name,
    required this.location,
    required this.person,
    required this.grandTotal,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      width: 327,
      // height: 110,
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
                  width: 100,
                  height: 100,
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
                    Text(
                      location,
                      style: greyTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: light,
                      ),
                    ),
                    Text(
                      "Traveler: $person Person",
                      style: greyTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: light,
                      ),
                      // overflow: TextOverflow.clip,
                    ),
                    Text(
                      "GrandTotal: ${formatRupiah.format(
                        grandTotal,
                      )}",
                      style: greyTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: light,
                      ),
                    ),
                    Text(
                      "Status: $status",
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
