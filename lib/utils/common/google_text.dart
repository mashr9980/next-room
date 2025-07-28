import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

enum AppTextStyle { title, medium, regular, small }

class GoogleText extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? underlineColor;
  final AppTextStyle? style;
  final bool? underline;
  final bool? strikeThrough;
  final double? textSize;
  final bool? capitalise;
  final int? maxLines;
  final TextAlign? textAlign;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final double? lineHeight;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? decorationThickness;
  final TextOverflow? overflow;
  final List<Shadow>? shadows;
  final bool? softWrap;
  final VoidCallback? onPressed;

  const GoogleText({
    super.key,
    required this.text,
    this.color,
    this.style,
    this.maxLines,
    this.textAlign,
    this.underline,
    this.textSize,
    this.fontFamily,
    this.fontWeight,
    this.lineHeight,
    this.fontStyle,
    this.underlineColor,
    this.strikeThrough,
    this.capitalise,
    this.letterSpacing,
    this.shadows,
    this.overflow,
    this.decorationThickness,
    this.softWrap,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          Padding(
            padding: underline == true
                ? const EdgeInsets.only(bottom: 0.3)
                : EdgeInsets.zero,
            child: Text(
              capitalise == true ? text.toUpperCase() : text.tr,
              maxLines: maxLines,
              overflow: overflow ??
                  (maxLines != null
                      ? TextOverflow.ellipsis
                      : TextOverflow.visible),
              softWrap: softWrap ?? true,
              textAlign: textAlign,
              style : GoogleFonts.roboto(
                fontSize: textSize,
                color: color ?? AppColor.black,
                fontWeight: fontWeight,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
          if (underline == true)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: decorationThickness ?? 1,
                color: underlineColor ?? AppColor.appColor,
              ),
            ),
        ],
      ),
    );
  }

  TextStyle getStyle(double textSize, {Color? color}) {
    final weight = fontWeight ?? getWeight();

    return TextStyle(
      overflow: overflow,
      shadows: shadows,
      color: color,
      letterSpacing: letterSpacing,
      fontWeight: weight,
      fontSize: textSize,
      fontStyle: fontStyle ?? FontStyle.normal,
      height: lineHeight ?? 1.2,
      fontFamily: fontFamily,
      decorationThickness: decorationThickness ?? 0,
      decoration: strikeThrough == true
          ? TextDecoration.lineThrough
          : TextDecoration.none,
    );
  }

  double getTextSize(double width) {
    switch (style) {
      case AppTextStyle.title:
        return width * 0.08;
      case AppTextStyle.medium:
        return width * 0.06;
      case AppTextStyle.small:
        return width * 0.02;
      default:
        return width * 0.04;
    }
  }

  FontWeight getWeight() {
    switch (style) {
      case AppTextStyle.title:
        return FontWeight.w600;
      case AppTextStyle.medium:
        return FontWeight.w500;
      case AppTextStyle.regular:
        return FontWeight.w400;
      case AppTextStyle.small:
        return FontWeight.w300;
      default:
        return FontWeight.w400;
    }
  }
}
