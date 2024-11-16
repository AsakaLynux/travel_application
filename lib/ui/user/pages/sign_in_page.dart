import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../entities/user.dart';
import '../../../services/shared_services.dart';
import '../../../services/user_services.dart';
import '../../../shared/theme.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool obscure = true;
  SharedServices sharedServices = SharedServices();
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void _visible() {
    setState(() {
      if (obscure) {
        obscure = false;
      } else {
        obscure = true;
      }
    });
  }

  Future<User?> _signIn() async {
    UserServices userServices = UserServices();
    userServices.showUser();
    final validateUser = await userServices.signInUser(
        emailController.text, passwordController.text);
    return validateUser;
  }

  @override
  Widget build(BuildContext context) {
    Widget formSignIn() {
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
                      _visible();
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
              CustomButton(
                margin: const EdgeInsets.only(top: 30),
                text: "Sign In",
                width: 287,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final User? signInResult = await _signIn();
                    if (signInResult != null) {
                      sharedServices.cacheUserInfo(signInResult.id);
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(context, "/BonusPage");
                      }
                    } else {
                      return Fluttertoast.showToast(
                        msg: "Wrong email or password",
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
                formSignIn(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
