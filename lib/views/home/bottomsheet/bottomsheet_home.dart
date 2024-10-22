import 'package:mood_track/configs/components/custom_dialog_widget.dart';
import 'package:mood_track/configs/routes/routes_name.dart';
import 'package:mood_track/configs/theme/colors.dart';
import 'package:mood_track/configs/theme/text_theme_style.dart';
import 'package:mood_track/data/firebase_services/firebase_auth.dart';
import 'package:mood_track/utils/dimensions.dart';
import 'package:mood_track/utils/gaps.dart';
import 'package:flutter/material.dart';

class BottomSheetHome extends StatelessWidget {
  const BottomSheetHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            )),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 3,
                  color: AppColors.hintText,
                  width: 60,
                ),
              ),
              Gaps.verticalGapOf(30),
              Text(
                'Setting',
                style: AppTextStyles.poppinsTitle(),
              ),
              Gaps.verticalGapOf(20),
              _listTileWidget(
                  'Logout',
                  Icons.logout,
                  () => CustomDialogWidget.confirmDialogue(
                        context: context,
                        message: 'Do you want to logout?',
                        title: 'Confirmation Dialogue',
                        onConfirm: () {
                          AuthService().signOut();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouteName.loginRoute,
                            (route) => false,
                          );
                        },
                      )),
            ],
          ),
        ),
      ),
    );
  }
}

_listTileWidget(String title, IconData leadingIcon, Function() onPress) {
  return ListTile(
    onTap: onPress,
    leading: Icon(
      leadingIcon,
    ),
    title: Text(
      title,
      style: AppTextStyles.poppinsMedium(),
    ),
  );
}
