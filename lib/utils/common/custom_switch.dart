import 'package:flutter/material.dart';

import 'app_colors.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double width;
  final double height;

  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.width = 46.0,
    this.height = 29.0,
  }) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  late bool _isSwitched;

  @override
  void initState() {
    super.initState();
    _isSwitched = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSwitched = !_isSwitched;
        });
        widget.onChanged(_isSwitched);
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.height / 2),
          color:   _isSwitched ? AppColor.darkGreenColor : Colors.grey.shade300
        ),
        child: Padding(
          padding: const EdgeInsets.all(2), // Space for the thumb to move
          child: AnimatedAlign(
            alignment: _isSwitched ? Alignment.centerRight : Alignment.centerLeft,
            duration: const Duration(milliseconds: 50),
            curve: Curves.easeInOut,
            child: Container(
              width: widget.height - 3,
              height: widget.height - 3,
              decoration: BoxDecoration(
                color:  Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
