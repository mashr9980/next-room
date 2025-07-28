import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Gradient? gradient;
  final Function onTap;
  final double? width;
  final double? borderWidth;
  final double? borderRadius;
  final double? scale;
  final Color? textColor;
  final Color? buttonColor;
  final Color? borderColor;
  final double? textSize;
  final double? elevation;
  final double? height;
  final bool? capitalise;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? margin;
  final String? icon1;
  final Color? color;
  final String? icon2;
  final String? fontFamily;
  final double? heightIcon1;
  final double? widthIcon1;
  final double? heightIcon2;
  final double? widthIcon2;
  final EdgeInsetsGeometry? padding;
  final bool enableBorder;
  final bool isMask; // New optional parameter

  const AppButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.textColor,
    this.borderColor,
    this.textSize,
    this.fontWeight,
    this.height,
    this.capitalise,
    this.borderRadius,
    this.borderWidth,
    this.elevation,
    this.margin,
    this.gradient,
    this.buttonColor,
    this.icon1,
    this.icon2,
    this.fontFamily,
    this.color,
    this.scale,
    this.padding,
    this.heightIcon1,
    this.widthIcon1,
    this.heightIcon2,
    this.widthIcon2,
    this.enableBorder = false,
    this.isMask = false, // Default value is false
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = isMask
        ?  AppColor.appColorLight2
        : (enableBorder ? Colors.white : (color ?? AppColor.appColor));

    Color txtColor = enableBorder ? AppColor.appColor : (textColor ?? AppColor.white);
    Color brdColor = isMask
        ?  Colors.transparent
        : (enableBorder ? Colors.white : (color ?? AppColor.appColor));


    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        width: width ?? double.infinity,
        height: height ?? 50,
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 30),
          border: Border.all(color: brdColor, width: borderWidth ?? 1.0),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon1 != null)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    icon1!,
                    height: heightIcon1 ?? 20,
                    width: widthIcon1 ?? 20,
                    scale: scale ?? 1.0,
                    color: Colors.white,
                  ),
                ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Text(
                    text.tr,
                    style: GoogleFonts.roboto(
                      fontSize: textSize ?? 14.0,
                      color: txtColor,
                      fontWeight: fontWeight ?? FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
              if (icon2 != null)
                Image.asset(
                  icon2!,
                  height: heightIcon2 ?? 20,
                  width: widthIcon2 ?? 20,
                  color: Colors.white,
                ),
            ],
          ).paddingOnly(bottom: 1.0),
        ),
      ),
    );
  }
}
