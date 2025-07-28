import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterView extends StatelessWidget {
  final RxInt value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final double? height;
  final double? width;
  final Color? bgColor;
  final Color? minusColor;
  final Color? addColor;

  const CounterView({
    Key? key,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
    this.height,
    this.width,
    this.bgColor, this.minusColor, this.addColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 26,
      width: width ?? 100,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onDecrement,
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: bgColor ?? Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(CupertinoIcons.minus, color: minusColor ?? Colors.black, size: 20),
            ),
          ),
          Obx(() => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '${value.value}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          )),
          GestureDetector(
            onTap: onIncrement,
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: bgColor ?? Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(CupertinoIcons.add, color:addColor ?? Colors.black, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

