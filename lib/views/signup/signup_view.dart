import 'package:mood_track/configs/assets/image_assets.dart';
import 'package:mood_track/configs/components/custom_button.dart';
import 'package:mood_track/configs/components/custom_dialog_widget.dart';
import 'package:mood_track/configs/components/custom_text_field.dart';
import 'package:mood_track/configs/theme/colors.dart';
import 'package:mood_track/configs/theme/text_theme_style.dart';
import 'package:mood_track/utils/gaps.dart';
import 'package:mood_track/utils/utils.dart';
import 'package:mood_track/view%20model/signup/signup_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: SignUpProvider(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gaps.verticalGapOf(30),
                _header(context),
                Gaps.verticalGapOf(50),
                _inputField(context),
                Gaps.verticalGapOf(20),
                _signup(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        ClipOval(
          child: Image.asset(
            ImageAssets.appLogo,
            height: 100,
            width: 100,
          ),
        ),
        Gaps.verticalGapOf(10),
        Text(
          "Create Account",
          style: AppTextStyles.poppinsHeading(),
        ),
        Text(
          "Enter your credential to Signup",
          style: AppTextStyles.interSmall(color: AppColors.black),
        ),
      ],
    );
  }

  _inputField(context) {
    return Consumer<SignUpProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextFieldWidget(
              controller: provider.usernameController,
              textInputType: TextInputType.text,
              hintTitle: 'Name',
              prefixIcon: Icons.person,
            ),
            Gaps.verticalGapOf(10),
            CustomTextFieldWidget(
              controller: provider.emailController,
              textInputType: TextInputType.emailAddress,
              hintTitle: 'Email',
              prefixIcon: Icons.email,
            ),
            Gaps.verticalGapOf(10),
            CustomTextFieldWidget(
              controller: provider.ageController,
              textInputType: TextInputType.phone,
              hintTitle: 'Age',
              prefixIcon: Icons.male,
            ),
            Gaps.verticalGapOf(10),
            CustomTextFieldWidget(
              controller: provider.passwordController,
              textInputType: TextInputType.text,
              hintTitle: 'Password',
              prefixIcon: Icons.password,
            ),
            Gaps.verticalGapOf(40),
            CustomButtonWidget(
              title: 'Sign up',
              onPress: () async {
                if (provider.isFormValid(context)) {
                  CustomDialogWidget.dialogLoading(
                      msg: 'Creating Account', context: context);

                  try {
                    final user = await provider.signUpUser(context);
                    final userId = user?.uid.toString();

                    await provider.addToDatabase(userId);
                  } catch (e) {
                    Utils.toastMessageCenter(e.toString());
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  _signup(context) {
    return Text.rich(
      TextSpan(
          text: 'Already have an account? ',
          style: AppTextStyles.interSubtitle(),
          children: <InlineSpan>[
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.pop(context),
              text: 'Login',
              style: AppTextStyles.poppinsNormal(color: AppColors.primaryColor),
            )
          ]),
    );
  }
}
