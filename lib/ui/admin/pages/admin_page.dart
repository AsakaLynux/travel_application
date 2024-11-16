import 'package:flutter/material.dart';

import '../../../shared/theme.dart';
import '../../../widget/custom_button.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          Text(
            "Admin Page",
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
          ),
          CustomButton(
            text: "Destination",
            width: 212,
            onPressed: () {},
          ),
          CustomButton(
            text: "Account",
            width: 212,
            onPressed: () {},
          ),
          CustomButton(
            text: "Transaction",
            width: 212,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
