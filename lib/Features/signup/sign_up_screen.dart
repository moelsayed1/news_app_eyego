import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app_eyego/Core/controllers/auth_controllers.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../Core/widgets/app_text_form_field.dart';
import '../login/ui/widgets/password_validations.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final AuthController controller = Get.put(AuthController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Account',
                  style: TextStyles.font24YellowBold,
                ),
                verticalSpace(8),
                Text(
                  'Sign up now and start exploring all that our app has to offer. We\'re excited to welcome you to our community!',
                  style: TextStyles.font14GrayRegular,
                ),
                verticalSpace(36),
                GetBuilder<AuthController>(
                  builder: (controller) {
                    return controller.isLoading
                        ? Center(
                        child: LoadingAnimationWidget.discreteCircle(
                          color: Colors.white,
                          secondRingColor: Colors.blue,
                          thirdRingColor: Colors.green,
                          size: 100.r,
                        ))
                        : Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              AppTextFormField(
                                hintText: 'Email',
                                controller: controller.emailController,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      !GetUtils.isEmail(value)) {
                                    return 'Please enter a valid email';
                                  }
                                },
                              ),
                              verticalSpace(18),
                              AppTextFormField(
                                hintText: 'Password',
                                controller: controller.passwordController,
                                isObscureText:
                                controller.isPasswordObscureText,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    controller.togglePasswordVisibility();
                                  },
                                  child: Icon(
                                    controller.isPasswordObscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a valid password';
                                  }
                                },
                              ),
                              verticalSpace(18),
                              AppTextFormField(
                                hintText: 'Password Confirmation',
                                controller:
                                controller.passwordConfirmController,
                                isObscureText: controller
                                    .isPasswordConfirmationObscureText,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    controller
                                        .togglePasswordConfirmationVisibility();
                                  },
                                  child: Icon(
                                    controller
                                        .isPasswordConfirmationObscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a valid password';
                                  }
                                },
                              ),
                              verticalSpace(24),
                              PasswordValidations(
                                hasLowerCase: controller.hasLowercase,
                                hasUpperCase: controller.hasUppercase,
                                hasSpecialCharacters:
                                controller.hasSpecialCharacters,
                                hasMinLength: controller.hasMinLength,
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(40),
                        AppTextButton(
                          buttonText: "Create Account",
                          textStyle: TextStyles.font16WhiteSemiBold,
                          onPressed: () {
                            controller.validateThenDoSignup(context);
                          },
                        ),
                        verticalSpace(16),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}