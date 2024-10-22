import 'package:flutter/material.dart';
import 'package:mood_track/configs/components/custom_button.dart';
import 'package:mood_track/configs/components/custom_dialog_widget.dart';
import 'package:mood_track/configs/components/custom_text_field.dart';
import 'package:mood_track/configs/theme/colors.dart';
import 'package:mood_track/configs/theme/text_theme_style.dart';
import 'package:mood_track/model/mood_emoji.dart';
import 'package:mood_track/utils/dimensions.dart';
import 'package:mood_track/utils/gaps.dart';
import 'package:mood_track/utils/utils.dart';
import 'package:mood_track/view%20model/home/home_view_model.dart';
import 'package:provider/provider.dart';

class MoodEntryView extends StatelessWidget {
  const MoodEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'Your Feeling Today',
          style: AppTextStyles.poppinsMedium(color: AppColors.secondaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Consumer<HomeProvider>(
            builder: (context, value, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Gaps.verticalGapOf(20),
                Text(
                  'How are you feeling today?',
                  style: AppTextStyles.poppinsNormal(),
                ),
                Gaps.verticalGapOf(20),
                GridView.builder(
                  itemCount: value.listEmoji.length,
                  shrinkWrap: true,
                  primary: false,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) => _buildEmojiList(
                      context, value.listEmoji[index], value, index),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 20,
                    childAspectRatio: 3 / 2,
                  ),
                ),
                Gaps.verticalGapOf(20),
                CustomTextFieldWidget(
                  controller: value.reasonController,
                  textInputType: TextInputType.multiline,
                  maxLines: 4,
                  hintTitle: 'Reason for your mood',
                ),
                Gaps.verticalGapOf(20),
                CustomButtonWidget(
                  title: 'Submit',
                  onPress: () async {
                    CustomDialogWidget.dialogLoading(
                        msg: 'Adding Your Current Mood', context: context);
                    await value
                        .addUserCurrentMood()
                        .whenComplete(() => Navigator.pop(context))
                        .then((a) {
                      Utils.toastMessage('Added Successfully');
                      value.resetReasonController();
                    });
                  },
                  width: double.infinity,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmojiList(
      BuildContext context, MoodEmoji listEmoji, HomeProvider value, index) {
    bool isSelected = value.selectedMood
        .toLowerCase()
        .contains(listEmoji.moodTitle.toLowerCase());
    return GestureDetector(
      onTap: () {
        value.setSelectedMood(listEmoji.moodTitle, index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.appBarColor,
          border: Border.all(
              color:
                  isSelected ? AppColors.primaryColor : AppColors.appBarColor),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              listEmoji.moodEmoji,
              style: AppTextStyles.poppinsMedium(),
            ),
            Text(
              listEmoji.moodTitle,
              style: AppTextStyles.poppinsNormal(),
            ),
          ],
        ),
      ),
    );
  }
}
