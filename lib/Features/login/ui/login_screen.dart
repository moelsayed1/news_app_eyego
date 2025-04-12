import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app_eyego/Core/controllers/auth_controllers.dart';
import 'package:news_app_eyego/Features/login/ui/widgets/google_sign_in_btn.dart';
import '../../../Core/theming/styles.dart';
import '../../../Core/widgets/app_text_button.dart';
import '../../../core/helpers/spacing.dart';
import 'widgets/dont_have_account_text.dart';
import 'widgets/email_and_password.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
            child: GetBuilder<AuthController>(
              builder: (controller) {
                return !controller.isLoading
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back',
                      style: TextStyles.font24YellowBold,
                    ),
                    verticalSpace(8),
                    Text(
                      'We\'re excited to have you back, can\'t wait to see what you\'ve been up to since you last logged in.',
                      style: TextStyles.font14GrayRegular,
                    ),
                    verticalSpace(36),
                    Column(
                      children: [
                        EmailAndPassword(
                          controller: controller,
                        ),
                        verticalSpace(24),
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            'Forgot Password?',
                            style: TextStyles.font13YellowRegular,
                          ),
                        ),
                        verticalSpace(24),
                        AppTextButton(
                          buttonText: "Login",
                          textStyle: TextStyles.font16WhiteSemiBold,
                          onPressed: () {
                            controller.validateThenDoLogin(context);
                          },
                        ),
                        verticalSpace(10),
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            'or Sign In With Google',
                            style: TextStyles.font13YellowRegular,
                            textDirection: TextDirection.ltr,
                          ),
                        ),
                        verticalSpace(10),
                        Column(
                          children: [
                            googleSignInButton(
                              text: 'Sign in with Google ',
                              icon: Ionicons.logo_google,
                              color: Colors.white,
                              isIconAsset: false,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.red,
                                  Colors.blue, // Google's blue
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderColor: HexColor("03A0D7"),
                              textColor: Colors.white,
                              onTap: () async {
                                try {
                                  await controller.googleLogin();
                                } catch (e) {
                                  debugPrint(e.toString());
                                }
                              },
                            ),
                          ],
                        ),
                        verticalSpace(50),
                        const DontHaveAccountText(),
                      ],
                    ),
                  ],
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: LoadingAnimationWidget.discreteCircle(
                        color: Colors.orange,
                        secondRingColor: Colors.blue,
                        thirdRingColor: Colors.green,
                        size: 100.r,
                      ),
                    )
                  ],
                );
              },
            )),
      ),
    );
  }
}
