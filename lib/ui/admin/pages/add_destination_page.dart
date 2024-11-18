import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../shared/theme.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_text_field.dart';

class AddDestinationPage extends StatefulWidget {
  const AddDestinationPage({super.key});

  @override
  State<AddDestinationPage> createState() => _AddDestinationPageState();
}

class _AddDestinationPageState extends State<AddDestinationPage> {
  // Controller for Text Form Field
  final TextEditingController destinationNameController =
      TextEditingController(text: "");
  final TextEditingController destinationLocationController =
      TextEditingController(text: "");
  final TextEditingController destinationPriceController =
      TextEditingController(text: "");
  final TextEditingController destinationRatingController =
      TextEditingController(text: "");
  final TextEditingController destinationImageController =
      TextEditingController(text: "");

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Widget formCard() {
      return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultRadius),
          color: kWhiteColor,
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextField(
                titleText: "Destination Name",
                controller: destinationNameController,
                hintText: "Borobudur",
                obscureText: false,
                inputType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please feel destination name";
                  }
                  return null;
                },
              ),
              CustomTextField(
                titleText: "Destination Location",
                controller: destinationLocationController,
                hintText: "Indonesia",
                obscureText: false,
                inputType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please feel destination location";
                  }
                  return null;
                },
              ),
              CustomTextField(
                titleText: "Destination Rating",
                controller: destinationRatingController,
                hintText: "4.5",
                obscureText: false,
                inputType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please feel destination rating";
                  }
                  return null;
                },
              ),
              CustomTextField(
                titleText: "Destination Price",
                controller: destinationPriceController,
                hintText: formatRupiah.format(1000000),
                obscureText: false,
                inputType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please feel destination price";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: "Add",
                width: 122,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    return Fluttertoast.showToast(
                      msg: "Success Update Account",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: kWhiteColor,
                      textColor: kBlackColor,
                      fontSize: 16.0,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            formCard(),
          ],
        ),
      ),
    );
  }
}
