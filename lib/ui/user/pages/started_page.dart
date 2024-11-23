import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../shared/theme.dart';
import '../../../widget/custom_button.dart';

class StartedPage extends StatefulWidget {
  const StartedPage({super.key});

  @override
  State<StartedPage> createState() => _StartedPageState();
}

class _StartedPageState extends State<StartedPage> {
  bool _showAuthButton = false;
  bool _visible = false;
  void _handleGetStartedClick() {
    setState(() {
      if (_showAuthButton) {
        _showAuthButton = false;
        _visible = false;
      } else {
        _showAuthButton = true;
        _visible = true;
      }
      if (kDebugMode) {
        print("showAuthButton: $_showAuthButton");
        print("visible: $_visible");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget showAuthButton() {
      return AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                text: "Sign In",
                width: 110,
                onPressed: () {
                  Navigator.pushNamed(context, "/SignInPage");
                },
              ),
              CustomButton(
                text: "Sign Up",
                width: 110,
                onPressed: () {
                  Navigator.pushNamed(context, "/SignUpPage");
                },
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            "assets/image_get_started.png",
            fit: BoxFit.fill,
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Fly Like a Bird",
                    style: whiteTextStyle.copyWith(
                      fontSize: 32,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Explore new world with us and let\nyourself get an amazing experiences",
                    style: whiteTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: light,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  CustomButton(
                    text: _showAuthButton ? "Back" : "Get Started",
                    width: 220,
                    margin: const EdgeInsets.only(
                      bottom: 40,
                      top: 50,
                    ),
                    onPressed: () {
                      _handleGetStartedClick();
                    },
                  ),
                  showAuthButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
