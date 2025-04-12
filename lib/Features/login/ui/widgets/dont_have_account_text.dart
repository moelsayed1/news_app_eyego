import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_eyego/Core/theming/styles.dart';
import 'package:news_app_eyego/Features/signup/sign_up_screen.dart';



class DontHaveAccountText extends StatelessWidget {
  const DontHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Don\'t have an account?',
            style: TextStyles.font13DarkBlueRegular,
          ),
          TextSpan(
            text: ' Sign Up',
            style: TextStyles.font13YellowSemiBold,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
              Get.to(()=> SignupScreen());
              },
          ),
        ],
      ),
    );
  }
}