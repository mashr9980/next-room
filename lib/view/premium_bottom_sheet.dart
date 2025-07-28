import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../generated/assets.dart';
import '../utils/common/app_button.dart';
import '../utils/common/app_colors.dart';
import '../utils/common/app_text.dart';

class PremiumBottomSheet extends StatefulWidget {
  const PremiumBottomSheet({super.key});

  @override
  State<PremiumBottomSheet> createState() => _PremiumBottomSheetState();
}

class _PremiumBottomSheetState extends State<PremiumBottomSheet> {
  final controller = Get.put(HomeController());
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: double.infinity, // 90% of screen height
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: const AppText(
                      text: "Cancel",
                      textSize: 14,
                      color: Colors.black,
                      lineHeight: 0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  AppText(
                    text: "Premium",
                    textSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(width: 50),
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(height: 1, color: Colors.grey),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          Assets.imagesPermium,
                          height: 70,
                          width: 80,
                        ),
                      ),
                      SizedBox(height: 10),
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.premiumFeatures.length,
                        separatorBuilder:
                            (context, index) => SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          return whatIncludedInPlan(
                            controller.premiumFeatures[index],
                          );
                        },
                      ),
                      SizedBox(height: 30),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.premiumOptions.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                controller.premiumSelectedIndex = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(0, 1),
                                          blurRadius: 1,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.center,
                                        colors:
                                            controller.premiumSelectedIndex ==
                                                    index
                                                ? [
                                                  Color(0xfffbfbff),
                                                  Color(0xffedf3ff),
                                                ]
                                                : [
                                                  Colors.white,
                                                  Colors.white,
                                                ], // Single color when not selected
                                      ),
                                      border: Border.all(
                                        color:
                                            controller.premiumSelectedIndex ==
                                                    index
                                                ? AppColor.appColor
                                                : Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppText(
                                                  text:
                                                      controller
                                                          .premiumOptions[index]
                                                          .duration,
                                                  textSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                SizedBox(height: 4),
                                                Row(
                                                  spacing: 3,
                                                  children: [
                                                    AppText(
                                                      text:
                                                          controller
                                                              .premiumOptions[index]
                                                              .pricePerDay,
                                                      textSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColor.appColor,
                                                    ),
                                                    AppText(
                                                      text: "/per day",
                                                      color: AppColor.textGrey,
                                                      textSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            AppText(
                                              text:
                                                  controller
                                                      .premiumOptions[index]
                                                      .totalPrice,
                                              textSize: 22,
                                              fontWeight: FontWeight.w700,
                                              color: AppColor.appColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (controller
                                      .premiumOptions[index]
                                      .isRecommended)
                                    Positioned(
                                      top: -10,
                                      right: 20,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                        child: AppText(
                                          text: "Recommended",
                                          textSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              child: AppButton(
                text: "Continue",
                onTap: () {
                  Get.back();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: AppText(
                text:
                    "Subscription will automatically be renewed.\n"
                        "Cancel anytime.",
                textAlign: TextAlign.center,
                textSize: 12.5,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 5),
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: "Terms of Use",
                    textSize: 14,
                    color: AppColor.appColor,
                    fontWeight: FontWeight.w400,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: 1,
                    height: 15,
                    color: AppColor.textGrey,
                  ),
                  AppText(
                    text: "Privacy Policy",
                    textSize: 14,
                    color: AppColor.appColor,
                    fontWeight: FontWeight.w400,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: 1,
                    height: 15,
                    color: AppColor.textGrey,
                  ),
                  AppText(
                    text: "Restore Purchase",
                    textSize: 14,
                    color: AppColor.appColor,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget whatIncludedInPlan(String text) {
    return Row(
      spacing: 10,
      children: [
        Image.asset(Assets.iconsCheckCircle, height: 20, width: 20),
        Expanded(
          child: AppText(text: text, textSize: 14, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
