import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class CommonTextField extends StatefulWidget {
  final String? title;
  final String? floatingLabelText; // New: Label inside border (like screenshot)
  final bool showFloatingLabel; // New: Toggle floating label
  final FontWeight? titleFontWeight;
  final double? titleSpacing;
  final Color? titleColor;
  final Color? borderColor;
  final Color? focusBorderColor;
  final double? titleSize;
  final String? hintText;
  final String? counterText;
  final bool? obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? isDense;
  final Color? hintTextColor;
  final Color? textColor;
  final Color? bgColor;
  final Color? cursorColor;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool? readOnly;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool? enabled;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization? textCapitalization;
  final InputBorder? inputBorder;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsets? scrollPadding;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final TextAlignVertical? textAlignVertical;
  final double? elevation;
  final double? fontSize;
  final double? hintSize;
  final String? fontFamily;
  final String? hintFontFamily;
  final FontWeight? fontWeight;
  final FontWeight? hintWeight;
  final TextAlign? textAlign;
  final double? cursorHeight;
  final bool? borderSide;
  final bool? enableInteractiveSelection;

  const CommonTextField({
    super.key,
    this.inputFormatters,
    this.hintText,
    this.obscureText,
    this.borderColor,
    this.prefixIcon,
    this.suffixIcon,
    this.hintTextColor,
    this.textColor,
    this.maxLines,
    this.minLines,
    this.readOnly,
    this.textInputAction,
    this.keyboardType,
    this.enabled,
    this.controller,
    this.onChanged,
    this.onTap,
    this.textCapitalization,
    this.maxLength,
    this.counterText,
    this.title,
    this.titleSpacing,
    this.titleColor,
    this.titleSize,
    this.focusBorderColor,
    this.cursorColor,
    this.validator,
    this.inputBorder,
    this.contentPadding,
    this.prefixIconConstraints,
    this.borderRadius,
    this.margin,
    this.padding,
    this.bgColor,
    this.textAlignVertical,
    this.elevation,
    this.fontSize,
    this.hintSize,
    this.fontWeight,
    this.hintWeight,
    this.suffixIconConstraints,
    this.focusedBorder,
    this.enabledBorder,
    this.textAlign,
    this.cursorHeight,
    this.scrollPadding,
    this.isDense,
    this.borderSide,
    this.fontFamily,
    this.hintFontFamily,
    this.titleFontWeight,
    this.floatingLabelText,
    this.showFloatingLabel = false,
    this.enableInteractiveSelection, // Default to false
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.showFloatingLabel && (widget.title ?? "").isNotEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: widget.titleSpacing ?? 5),
            child: Text(
              widget.title!,
              style: GoogleFonts.roboto(
                fontSize: widget.titleSize ?? 13,
                color: widget.titleColor ?? AppColor.black,
                fontWeight: widget.titleFontWeight ?? FontWeight.w500,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        CupertinoTheme(
          data: CupertinoThemeData(),
          child: Theme(
            data: ThemeData(
              textSelectionTheme: TextSelectionThemeData(
                selectionColor: Colors.blue.shade100,
                cursorColor: Colors.black,
              ),
            ),
            child: TextFormField(
              focusNode: _focusNode,
              controller: widget.controller,
              maxLines: widget.maxLines ?? 1, // This is the key fix
              minLines: widget.minLines,
              cursorHeight: 18,
              enableInteractiveSelection: widget.enableInteractiveSelection ?? true,
              selectionControls: CupertinoTextSelectionControls(),
              decoration: InputDecoration(
                counterText: '',
                labelText:
                    widget.showFloatingLabel ? widget.floatingLabelText : null,
                labelStyle: TextStyle(
                  color:
                      _focusNode.hasFocus
                          ? widget.focusBorderColor ?? Colors.black
                          : widget.borderColor ?? Color(0xff666666),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: widget.hintTextColor ?? Colors.grey,
                  fontSize: widget.hintSize ?? 14,
                  fontWeight: widget.hintWeight ?? FontWeight.w500,
                ),
                filled: true,
                fillColor: widget.bgColor ?? AppColor.white,
                contentPadding:
                    widget.contentPadding ??
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 12,
                  ),
                  borderSide: BorderSide(
                    color: widget.borderColor ?? AppColor.borderLineColor,
                    width: 1.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 12,
                  ),
                  borderSide: BorderSide(
                    color: widget.borderColor ?? AppColor.borderLineColor,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 12,
                  ),
                  borderSide: BorderSide(
                    color: widget.focusBorderColor ?? AppColor.borderLineColor,
                    width: 1.5,
                  ),
                ),
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon,
                isDense: widget.isDense,
              ),
              style: GoogleFonts.roboto(
                fontSize: widget.fontSize ?? 16,
                color: widget.textColor ?? AppColor.textBlack,
                fontWeight: widget.fontWeight ?? FontWeight.w400,
                fontStyle: FontStyle.normal,
              ),
              obscureText: widget.obscureText ?? false,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              onChanged: widget.onChanged,
              onTap: widget.onTap,
              validator: widget.validator,
              readOnly: widget.readOnly ?? false,
              enabled: widget.enabled,
              inputFormatters: widget.inputFormatters,
              textCapitalization:
                  widget.textCapitalization ?? TextCapitalization.none,
              maxLength: widget.maxLength,
            ),
          ),
        ),
      ],
    );
  }
}
