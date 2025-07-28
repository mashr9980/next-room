import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool?>? onChanged;
  final bool isMasked; // New property
  final Color checkedColor;
  final Color uncheckedColor;
  final Color checkmarkColor;
  final Color? tittleColor;

  final String? tittle;
  final double? tittleSize;
  final double? height;
  final double? width;
  final double? iconSize;

  const CustomCheckbox({
    super.key,
    required this.isChecked,
    required this.onChanged,
    this.isMasked = false, // Default to false
    this.checkedColor = Colors.purple,
    this.uncheckedColor = Colors.white,
    this.checkmarkColor = Colors.white,
    this.height,
    this.width,
    this.iconSize,
    this.tittle,
    this.tittleColor,
    this.tittleSize,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveCheckedColor = isMasked
        ? Colors.blue[100]!
        : AppColor.appColor;

    return InkWell(
      onTap: () => onChanged?.call(!isChecked), // Toggle the checkbox state
      child: Row(
        children: [
          Container(
            width: width ?? 15,
            height: height ?? 15,
            decoration: BoxDecoration(
              color: isChecked ? effectiveCheckedColor : uncheckedColor,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(
                color: isChecked ? effectiveCheckedColor : AppColor.greyColor,
                width: 2,
              ),
            ),
            child: Center(
              child: isChecked
                  ? Icon(
                Icons.check_rounded,
                size: iconSize ?? 12,
                color: checkmarkColor,
              )
                  : null,
            ),
          ),
          const SizedBox(width: 10),
          AppText(
            text: tittle ?? "",
            textSize: tittleSize ?? 14,
            fontWeight: FontWeight.w400,
            color: tittleColor ?? AppColor.textGrey,
          ),
        ],
      ),
    );
  }
}
