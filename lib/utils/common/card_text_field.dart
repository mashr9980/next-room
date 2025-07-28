import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nextroom8_animation/utils/common/text_field_formats.dart';

import 'app_colors.dart';

class CardNumberField extends StatefulWidget {
  const CardNumberField({super.key});

  @override
  State<CardNumberField> createState() => _CardNumberFieldState();
}

class _CardNumberFieldState extends State<CardNumberField> {
  final RxBool isExpanded = false.obs;
  final RxString cardNumber = ''.obs;
  final FocusNode focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (focusNode.hasFocus) {
      isExpanded.value = true;
    } else {
      // Only collapse if field is empty
      if (controller.text.isEmpty) {
        isExpanded.value = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (!isExpanded.value) {
            isExpanded.value = true;
          }
          focusNode.requestFocus();
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColor.lightSkyBlue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: isExpanded.value
              ? Row(
            children: [
              Expanded(
                child: CupertinoTheme(
                  data: const CupertinoThemeData(),
                  child: Theme(
                    data: ThemeData(
                      textSelectionTheme: TextSelectionThemeData(
                        selectionColor: Colors.blue.shade100,
                        cursorColor: Colors.black,
                      ),
                    ),
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      cursorColor: Colors.black,
                      cursorHeight: 15,
                      enableInteractiveSelection: true,
                      selectionControls: CupertinoTextSelectionControls(),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(16),
                        CardNumberFormatter(),
                      ],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Card number',
                              style: TextStyle(color: AppColor.textGrey),
                            ),
                            Icon(
                              CupertinoIcons.lock_fill,
                              color: AppColor.textGrey,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                          ],
                        ),
                      ),
                      onChanged: (value) {
                        cardNumber.value = value;
                      },
                    ),
                  ),
                ),
              ),
              Image.network(
                'https://img.icons8.com/color/48/000000/mastercard-logo.png',
                height: 20,
                width: 20,
              ),
            ],
          )
              : Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              controller.text.isEmpty
                  ? 'Enter card number'
                  : controller.text,
              style: TextStyle(
                color: controller.text.isEmpty
                    ? Colors.grey
                    : Colors.black,
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    focusNode.removeListener(_handleFocusChange);
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }
}