import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../services/user_services.dart';
import '../../../shared/theme.dart';
import '../widget/custom_button.dart';
import '../widget/custom_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool obscure = true;
  bool confirmObscure = true;
  final TextEditingController nameController = TextEditingController(text: "");
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");
  final TextEditingController confirmPasswordController =
      TextEditingController(text: "");
  final TextEditingController hobbyController = TextEditingController(text: "");
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void _visiblePassword() {
    setState(() {
      if (obscure) {
        obscure = false;
      } else {
        obscure = true;
      }
    });
  }

  void _visibleConfirmPassword() {
    setState(() {
      if (confirmObscure) {
        confirmObscure = false;
      } else {
        confirmObscure = true;
      }
    });
  }

  Future<bool> _signUp() async {
    UserServices userServices = UserServices();
    userServices.showUser();
    final signUpConfirmation = await userServices.signUpUser(
        emailController.text,
        nameController.text,
        passwordController.text,
        hobbyController.text);
    return signUpConfirmation;
  }

  @override
  Widget build(BuildContext context) {
    Widget formCard() {
      return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
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
                titleText: "Username",
                controller: nameController,
                hintText: "AsakaLynux",
                obscureText: false,
                inputType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your username";
                  }
                  return null;
                },
              ),
              CustomTextField(
                  titleText: "Email Address",
                  controller: emailController,
                  hintText: "abcd@email.com",
                  obscureText: false,
                  inputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email";
                    } else if (!value.contains("@")) {
                      return "Please enter with email format";
                    }
                    return null;
                  }),
              CustomTextField(
                  titleText: "Password",
                  controller: passwordController,
                  obscureText: obscure,
                  inputType: TextInputType.text,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _visiblePassword();
                    },
                    child: Icon(obscure
                        ? Icons.lock_outline
                        : Icons.lock_open_outlined),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    }
                    return null;
                  }),
              CustomTextField(
                  titleText: "Confirm Password",
                  controller: confirmPasswordController,
                  obscureText: confirmObscure,
                  inputType: TextInputType.text,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _visibleConfirmPassword();
                    },
                    child: Icon(confirmObscure
                        ? Icons.lock_outline
                        : Icons.lock_open_outlined),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    } else if (value != passwordController.text) {
                      return "Password not same";
                    }
                    return null;
                  }),
              CustomTextField(
                  titleText: "Hobby",
                  controller: hobbyController,
                  hintText: "Basket",
                  obscureText: false,
                  inputType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your hobby";
                    }
                    return null;
                  }),
              CustomButton(
                margin: const EdgeInsets.only(top: 30),
                text: "Sign Up",
                width: 287,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final bool signUpResult = await _signUp();
                    if (signUpResult == true) {
                      if (context.mounted) {
                        Navigator.pushNamed(context, "/SignInPage");
                      }
                    } else {
                      return Fluttertoast.showToast(
                        msg: "Email already exist!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: kWhiteColor,
                        textColor: kBlackColor,
                        fontSize: 16.0,
                      );
                    }
                  }
                },
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      /*resizeToAvoidBottomInset: true,*/
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Join us and get\nyour next journey",
                  style: purpleTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(height: 30),
                formCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
