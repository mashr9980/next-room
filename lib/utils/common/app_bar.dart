import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../generated/assets.dart';
import 'app_colors.dart';
import 'app_text.dart';

AppBar commonAppBar({
  String? title,
  Widget? titleWidget,
  required bool isLeading,
  double? toolbarHeight,
  double? textSize,
  FontWeight? fontWeight,
  SystemUiOverlayStyle? systemOverlayStyle,
  Color? backgroundColor,
  Color? iconColor,
  Color? surfaceTintColor,
  Color? shadowColor,
  double? leadingWidth,
  ShapeBorder? shape,
  bool? centerTitle,
  double? elevation,
  Widget? leading,
  void Function()? onPressed,
  void Function()? onTap,
  List<Widget>? actions,
}) {
  return AppBar(

    shadowColor: shadowColor ?? Colors.transparent,
    shape:
        shape ??
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
        ),
    title: GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child:
            titleWidget ??
            AppText(
              text: title ?? "",
              textSize: textSize ?? 16,
              color: Colors.black,
              fontWeight: fontWeight ?? FontWeight.w600,
              fontFamily: 'Poppins',
            ),
      ),
    ),
    elevation: elevation ?? 0.0,
    toolbarHeight: toolbarHeight ?? 70,
    systemOverlayStyle:
        systemOverlayStyle ??
        SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
        ),
    leadingWidth: leadingWidth ?? 65,
    leading:
        isLeading
            ? leading ??
                GestureDetector(
                  onTap: () => onPressed != null ? onPressed() : Get.back(),
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Image.asset(Assets.iconsBtnBack),
                  ),
                )
            : Container(),
    automaticallyImplyLeading: false,
    centerTitle: centerTitle ?? false,
    backgroundColor: backgroundColor ?? AppColor.white,
    surfaceTintColor: surfaceTintColor ?? Colors.transparent,
    actions: actions,
  );
}
