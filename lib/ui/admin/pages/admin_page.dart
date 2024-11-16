import 'package:flutter/material.dart';

import '../../../shared/theme.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          Text("Admin Page"),
        ],
      ),
    );
  }
}
