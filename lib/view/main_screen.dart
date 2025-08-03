import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nextroom8_animation/view/home_screen.dart';
import 'package:nextroom8_animation/view/premium_bottom_sheet.dart';
import '../controllers/bottom_nav_controller.dart';
import '../generated/assets.dart';
import '../utils/common/app_colors.dart';
import '../utils/common/app_text.dart';
import '../utils/common/common_scaffold.dart';

class MainScreen extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => CommonScaffold(
      body: IndexedStack(
        index: controller.selectedIndex.value,
        children: [
          HomeScreen(),
          InboxScreen(),
          FavoritesScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  icon: Assets.iconsHomeUnselected,
                  selectedIcon: Assets.iconsHomeSelected,
                  label: 'Home',
                ),
                _buildNavItem(
                  index: 1,
                  icon: Assets.iconsMessageUnselected,
                  selectedIcon: Assets.iconsMessageSelected,
                  label: 'Inbox',
                ),
                _buildNavItem(
                  index: 2,
                  icon: Assets.iconsFavouriteUnselected,
                  selectedIcon: Assets.iconsFavouriteSelected,
                  label: 'Favorites',
                ),
                _buildNavItem(
                  index: 3,
                  icon: Assets.iconsVip,
                  selectedIcon: Assets.iconsVip,
                  label: 'Premium',
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _buildNavItem({
    required int index,
    required String icon,
    required String selectedIcon,
    required String label,
  }) {
    final isSelected = controller.selectedIndex.value == index;

    return GestureDetector(
      onTap: () {
        if (index == 3) {
          showCupertinoModalBottomSheet(
            useRootNavigator: true,
            backgroundColor: Colors.white,
            overlayStyle: SystemUiOverlayStyle.light,
            context: Get.context!,
            builder: (context) => PremiumBottomSheet(),
          );
        } else {
          controller.changeTabIndex(index);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              isSelected ? selectedIcon : icon,
              height: 24,
              width: 24,
              color: isSelected ? AppColor.appColor : AppColor.greyColor,
            ),
            const SizedBox(height: 4),
            AppText(
              text: label,
              textSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? AppColor.appColor : AppColor.greyColor,
            ),
          ],
        ),
      ),
    );
  }
}

class InboxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Center(
          child: AppText(
            text: "Inbox Screen",
            textSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Center(
          child: AppText(
            text: "Favorites Screen",
            textSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}