import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:mood_track/configs/assets/image_assets.dart';
import 'package:mood_track/configs/theme/colors.dart';
import 'package:mood_track/views/bottom_nav_home/nav_controller/nav_controller.dart';

buildBottomNavigationMenu(context) {
  return Consumer<NavPageController>(
    builder: (context, provider, child) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          showSelectedLabels: true,
          onTap: (index) {
            provider.changeTabIndex(index);
          },
          currentIndex: provider.tabIndex.value,
          backgroundColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.black,
          selectedItemColor: AppColors.white,
          items: [
            buildNavItem(ImageAssets.homeFilled, ImageAssets.homeIcon, 'Home'),
            buildNavItem(ImageAssets.depositFilledIcon, ImageAssets.depositIcon,
                'Weekly Report'),
            buildNavItem(ImageAssets.withdrawFilledIcon,
                ImageAssets.withdrawFilledIcon, 'Monthly Report'),
          ],
        ),
      ),
    ),
  );
}

BottomNavigationBarItem buildNavItem(
  String activeIcon,
  String inactiveIcon,
  String label,
) {
  return BottomNavigationBarItem(
    label: label,
    activeIcon: SvgPicture.asset(
      activeIcon,
      height: 30,
      width: 30,
      colorFilter: const ColorFilter.mode(
        AppColors.white,
        BlendMode.srcIn,
      ),
    ),
    icon: SvgPicture.asset(
      inactiveIcon,
      height: 30,
      width: 30,
      colorFilter: const ColorFilter.mode(
        AppColors.secondaryColor,
        BlendMode.srcIn,
      ),
    ),
  );
}
