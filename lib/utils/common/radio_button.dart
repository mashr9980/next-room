import 'package:flutter/material.dart';

class CommonRadioButton extends StatefulWidget {
  final String? title;
  final int? value;
  final int? groupValue;
  final Function(int?)? onChanged;
  final Color? activeColor;
  final Color? borderColor;
  final Color? titleColor;
  final double? titleSize;
  final FontWeight? titleWeight;
  final EdgeInsets? padding;

  const CommonRadioButton({
    super.key,
    this.title,
    this.value,
    this.groupValue,
    this.onChanged,
    this.activeColor,
    this.borderColor,
    this.titleColor,
    this.titleSize,
    this.titleWeight,
    this.padding,
  });

  @override
  State<CommonRadioButton> createState() => _CommonRadioButtonState();
}

class _CommonRadioButtonState extends State<CommonRadioButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged?.call(widget.value);
      },
      child: Container(
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 5, vertical: 0),

        child: Row(
          children: [
            Radio<int>(
              value: widget.value ?? 0,
              groupValue: widget.groupValue,
              onChanged: widget.onChanged,
              activeColor: widget.activeColor ?? Colors.black,
            ),
            Text(
              widget.title ?? '',
              style: TextStyle(
                fontSize: widget.titleSize ?? 16,
                color: widget.titleColor ?? Colors.black,
                fontWeight: widget.titleWeight ?? FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
