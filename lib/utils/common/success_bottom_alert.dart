import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_button.dart';
import 'app_colors.dart';
import 'app_string.dart';
import 'app_text.dart';

class SuccessBottomAlert extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final String? textButton;
  final double? btnWidth;
  final double? imageHeight;
  final double? imageWidth;
  final double? btnRadius;
  final String imagePath;
  final AlignmentGeometry? position;
  final VoidCallback onButtonPressed;
  final bool showYesButton;
  final bool showImage;
  final bool showMessage;
  final bool showRowButton;
  final bool showTextButton;

  // Constructor to pass in dynamic values
  const SuccessBottomAlert({
    super.key,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.imagePath,
    required this.onButtonPressed,
    this.position,
    this.showImage = true,
    this.showYesButton = true,
    this.showRowButton = true,
    this.showTextButton = true,
    this.showMessage = true,
    this.btnWidth,
    this.btnRadius,
    this.textButton, this.imageHeight,
    this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: position ?? Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30), // Apply rounded corners here
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Material(
            color: Colors.white,
            child: Column(
              mainAxisSize:
                  MainAxisSize
                      .min, // Prevents the column from taking too much space
              children: [
                if (showImage)
                Image.asset(
                  imagePath, // Use the dynamic image path
                  height: imageHeight ?? 80,
                  width:imageWidth ?? 80,
                ),
                const SizedBox(height: 12),
                AppText(
                  text: title, // Dynamic title
                  textSize: 20,
                  color: AppColor.greenColor,
                  fontWeight: FontWeight.w700,
                  // fontFamily: Assets.fontsPoppinsSemiBold,
                ),
                const SizedBox(height: 15),
                if (showMessage)
                  AppText(
                    text: message, // Dynamic message
                    textSize: 14,
                    textAlign: TextAlign.center,
                    color: AppColor.textGrey,
                    fontWeight: FontWeight.w400,
                    //   fontFamily: Assets.fontsPoppinsMedium,
                  ),
                const SizedBox(height: 20),
                if (showYesButton)
                  AppButton(
                    borderRadius: btnRadius ?? 25,
                    text: buttonText,
                    width: btnWidth,
                    onTap: onButtonPressed, // Use the provided callback
                  ),

                if (showTextButton)
                  Column(
                    children: [
                      SizedBox(height: 10),
                      AppButton(
                        text: textButton ?? "Cancel",
                        borderColor: Colors.grey.shade300,
                        color: AppColor.lightSkyBlue,
                        textColor: Colors.black,
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                if (showRowButton)
                  Row(
                    spacing: 20,
                    children: [
                      Expanded(
                        child: AppButton(
                          borderRadius: 15,
                          text: "yes",
                          width: btnWidth,
                          onTap: onButtonPressed, // Use the provided callback
                        ),
                      ),
                      Expanded(
                        child: AppButton(
                          borderRadius: 15,
                          text: "no",
                          color: AppColor.calenderBg,
                          borderColor: AppColor.calenderBg,
                          textColor: Colors.black,
                          width: btnWidth,
                          onTap: () {
                            Get.back();
                          }, // Use the provided callback
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
