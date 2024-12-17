import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../services/user_services.dart';
import '../../../shared/theme.dart';
import '../../../widget/custom_button.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserServices userServices = UserServices();
    Future dialog(
      Function() yesOnPressed,
    ) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Are you sure?"),
          actions: [
            CustomButton(
              text: "Yes",
              width: 70,
              onPressed: yesOnPressed,
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
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Admin Page",
              style:
                  blackTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
            ),
            CustomButton(
              text: "Destination",
              width: 212,
              onPressed: () {
                Navigator.pushNamed(context, "/DestinationPage");
              },
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
            CustomButton(
              text: "Delete",
              width: 122,
              onPressed: () async {
                dialog(
                  () async {
                    final deleteUserInfo = await userServices.deleteUser();
                    if (deleteUserInfo) {
                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/",
                          (Route<dynamic> route) => false,
                        );
                      }
                      return Fluttertoast.showToast(
                        msg: "Success Delete Account",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: kWhiteColor,
                        textColor: kBlackColor,
                        fontSize: 16.0,
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
