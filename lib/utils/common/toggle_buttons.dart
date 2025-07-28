import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PillToggleButton extends StatelessWidget {
  final List<String> options;
  final RxInt selectedIndex;
  final Function(int index) onSelected;

  const PillToggleButton({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(options.length,
                (index) {
          final isSelected = selectedIndex.value == index;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue.shade100 : Colors.transparent,
                border: Border.all(
                  color: isSelected ?Colors.blue.shade100 : Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                options[index],
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 12
                ),
              ),
            ),
          );
        }),
      );
    });
  }
}
