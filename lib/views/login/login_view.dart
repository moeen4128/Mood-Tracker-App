import 'package:mood_track/configs/assets/image_assets.dart';
import 'package:mood_track/configs/components/custom_button.dart';
import 'package:mood_track/configs/components/custom_dialog_widget.dart';
import 'package:mood_track/configs/components/custom_text_field.dart';
import 'package:mood_track/configs/routes/routes_name.dart';
import 'package:mood_track/configs/theme/colors.dart';
import 'package:mood_track/configs/theme/text_theme_style.dart';
import 'package:mood_track/utils/gaps.dart';
import 'package:mood_track/utils/utils.dart';
import 'package:mood_track/view%20model/login/login_viewmodel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: LoginViewProvider(),
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
          "Welcome Back",
          style: AppTextStyles.poppinsHeading(),
        ),
        Text(
          "Enter your credential to login",
          style: AppTextStyles.interSmall(color: AppColors.black),
        ),
      ],
    );
  }

  _inputField(context) {
    return Consumer<LoginViewProvider>(
      builder: (context, provider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextFieldWidget(
            controller: provider.emailController,
            textInputType: TextInputType.emailAddress,
            hintTitle: 'Email',
            prefixIcon: Icons.person,
          ),
          Gaps.verticalGapOf(10),
          CustomTextFieldWidget(
            controller: provider.passwordController,
            textInputType: TextInputType.text,
            hintTitle: 'Password',
            prefixIcon: Icons.password,
          ),
          _forgotPassword(context),
          Gaps.verticalGapOf(40),
          CustomButtonWidget(
            title: 'Login',
            onPress: () async {
              if (provider.isFormValid(context)) {
                CustomDialogWidget.dialogLoading(
                    msg: 'Signing..', context: context);

                try {
                  await provider.signInUser(context);
                } catch (e) {
                  Utils.toastMessageCenter(e.toString());
                }
              }
            },
          )
        ],
      ),
    );
  }

  _forgotPassword(context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          "Forgot password?",
          style: AppTextStyles.interSubtitle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _signup(context) {
    return Text.rich(
      TextSpan(
          text: 'Don\'t have an account? ',
          style: AppTextStyles.interSubtitle(),
          children: <InlineSpan>[
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap =
                    () => Navigator.pushNamed(context, RouteName.signupRoute),
              text: 'SignUp',
              style: AppTextStyles.poppinsNormal(color: AppColors.primaryColor),
            )
          ]),
    );
  }
}
