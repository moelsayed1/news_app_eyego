import 'package:flutter/material.dart';

import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:news_app_eyego/Core/controllers/auth_controllers.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_text_form_field.dart';

class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({
    super.key,
    required this.controller,
  });
  final AuthController controller;

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  bool isObscureText = true;

  bool hasLowercase = false;

  bool hasUppercase = false;

  bool hasSpecialCharacters = false;

  bool hasNumber = false;

  bool hasMinLength = false;

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      // key: context.read<LoginCubit>().formKey,
      child: Column(
        children: [
          AppTextFormField(
            hintText: 'Email',
            controller: widget.controller.emailController,
            validator: (value) {
              if (value == null || value.isEmpty || !GetUtils.isEmail(value)) {
                return 'Please enter a valid email';
              }
            },
            // controller: context.read<LoginCubit>().emailController,
          ),
          verticalSpace(18),
          AppTextFormField(
            // controller: context.read<LoginCubit>().passwordController,
            hintText: 'Password',
            controller: widget.controller.passwordController,
            isObscureText: isObscureText,
            suffixIcon: GestureDetector(
              onTap: () {
                isObscureText = !isObscureText;
                widget.controller.update();
              },
              child: Icon(
                isObscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid password';
              }
            },
          ),
          verticalSpace(24),
        ],
      ),
    );
  }
}
