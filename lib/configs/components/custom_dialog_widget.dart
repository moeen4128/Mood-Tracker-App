import 'package:flutter/material.dart';
import 'package:mood_track/configs/theme/colors.dart';
import 'package:mood_track/configs/theme/text_theme_style.dart';

class CustomDialogWidget {
  static Future<void> dialogLoading(
      {required String msg, required BuildContext context}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            contentPadding: const EdgeInsets.all(16),
            surfaceTintColor: Colors.black.withOpacity(0.5),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
                const SizedBox(height: 20),
                Text(msg, style: AppTextStyles.poppinsNormal())
              ],
            ));
      },
    );
  }

  Future<void> announceDialogue({
    required BuildContext context,
    required String message,
    required String title,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          surfaceTintColor: AppColors.white,
          title: Text(
            title,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontFamily: 'Inter',
              fontSize: 20,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          backgroundColor: AppColors.white,
          content: Text(message, style: AppTextStyles.interBody()),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'OK',
                      style: TextStyle(color: AppColors.white),
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  static Future<bool> confirmDialogue({
    required BuildContext context,
    required String message,
    required String title,
    required Function() onConfirm,
  }) {
    final theme = Theme.of(context);

    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          title: Text(title,
              textAlign: TextAlign.left, style: AppTextStyles.poppinsMedium()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: Text(
            message,
            style: AppTextStyles.interBody(),
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: theme.dialogBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: onConfirm,
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }
}
