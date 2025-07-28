import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text.dart';

class MyCustomDropdown extends StatefulWidget {
  final List<String> items;
  final ValueChanged<String>? onItemSelected;
  final String? initialValue;
  final String hint;
  final double? height;
  final double? textSize;

  const MyCustomDropdown({
    super.key,
    required this.items,
    this.onItemSelected,
    this.initialValue,
    this.hint = 'Select',
    this.height,
    this.textSize,
  });

  @override
  State<MyCustomDropdown> createState() => _MyCustomDropdownState();
}

class _MyCustomDropdownState extends State<MyCustomDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool isDropdownOpen = false;
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.initialValue;
  }

  void toggleDropdown() {
    if (isDropdownOpen) {
      closeDropdown();
    } else {
      openDropdown();
    }
  }

  void openDropdown() {
    final overlay = Overlay.of(context);
    _overlayEntry = _buildOverlayEntry();
    overlay.insert(_overlayEntry!);
    setState(() => isDropdownOpen = true);
  }

  void closeDropdown() {
    _overlayEntry?.remove();
    setState(() => isDropdownOpen = false);
  }

  OverlayEntry _buildOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    final dropdownItems = widget.items; // No reordering

    return OverlayEntry(
      builder:
          (context) => GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: closeDropdown,
            child: Stack(
              children: [
                Positioned(
                  width: size.width,
                  left: offset.dx,
                  top: offset.dy + size.height + 4,
                  child: CompositedTransformFollower(
                    link: _layerLink,
                    showWhenUnlinked: false,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: widget.height ?? 240,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 2,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: dropdownItems.length,
                            separatorBuilder:
                                (_, __) => Divider(
                                  height: 1,
                                  color: Colors.grey.shade400,
                                ),
                            itemBuilder: (context, index) {
                              final item = dropdownItems[index];
                              final isSelected = item == selectedItem;
                              return GestureDetector(
                                onTap: () {
                                  setState(() => selectedItem = item);
                                  widget.onItemSelected?.call(item);
                                  closeDropdown();
                                },
                                child: Container(
                                  color: AppColor.lightSkyBlue,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      if (isSelected) ...[
                                        const Icon(
                                          Icons.check,
                                          size: 18,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(width: 8),
                                      ] else
                                        const SizedBox(width: 26),
                                      Expanded(
                                        child: AppText(
                                          text: item,
                                          textSize: widget.textSize ?? 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final showHint = selectedItem == null || selectedItem!.isEmpty;
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: toggleDropdown,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColor.lightSkyBlue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  showHint ? widget.hint : selectedItem!,
                  style: TextStyle(
                    fontSize: widget.textSize ?? 16,
                    color: showHint ? Colors.grey : Colors.black,
                  ),
                ),
              ),
              Icon(
                isDropdownOpen
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
