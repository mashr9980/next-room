import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'app_colors.dart';
import 'app_text.dart';
import 'db_helper.dart';

class HistogramSliderSyncfusion extends StatefulWidget {
  final List<double> data;
  final ValueChanged<RangeValues>? onRangeChanged;

  const HistogramSliderSyncfusion({
    super.key,
    required this.data,
    this.onRangeChanged,
  });

  @override
  State<HistogramSliderSyncfusion> createState() =>
      _HistogramSliderSyncfusionState();
}

class _HistogramSliderSyncfusionState extends State<HistogramSliderSyncfusion> {
  double _startFraction = 0.1;
  double _endFraction = 0.6;
  double? _dragStartX;
  bool _isDraggingStart = false;
  bool _isDraggingEnd = false;

  double get _minValue => (DbHelper().getUserType() ?? 0) == 0 ? 75.0 : 18.0;
  double get _maxValue => (DbHelper().getUserType() ?? 0) == 0 ? 5000.0 : 75.0;

  RangeValues get _currentRange => RangeValues(
    _minValue + (_maxValue - _minValue) * _startFraction,
    _minValue + (_maxValue - _minValue) * _endFraction,
  );

  void _handleDragStart(DragStartDetails details, bool isStart) {
    _dragStartX = details.localPosition.dx;
    _isDraggingStart = isStart;
    _isDraggingEnd = !isStart;
  }

  void _handleDragUpdate(DragUpdateDetails details, double totalWidth) {
    if (_dragStartX == null) return;
    final currentX = details.localPosition.dx;
    final deltaX = currentX - _dragStartX!;
    final minPixelGap = 60.0;

    final startPixel = _startFraction * totalWidth;
    final endPixel = _endFraction * totalWidth;

    double newStart = startPixel;
    double newEnd = endPixel;

    if (_isDraggingStart) {
      newStart = (startPixel + deltaX).clamp(0.0, endPixel - minPixelGap);
    } else if (_isDraggingEnd) {
      newEnd = (endPixel + deltaX).clamp(startPixel + minPixelGap, totalWidth);
    }

    setState(() {
      _startFraction = newStart / totalWidth;
      _endFraction = newEnd / totalWidth;
      _dragStartX = currentX;
    });

    widget.onRangeChanged?.call(_currentRange);
  }

  void _handleDragEnd(_) {
    _dragStartX = null;
    _isDraggingStart = false;
    _isDraggingEnd = false;
  }

  @override
  Widget build(BuildContext context) {
    const handleSize = 28.0;

    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColor.lightSkyBlue,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        if ((DbHelper().getUserType() ?? 0) == 0) ...[
                          AppText(
                            text: '\$',
                            textSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.textGrey,
                          ),
                          SizedBox(width: 3),
                        ],
                        AppText(
                          text: 'Min:',
                          textSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.textGrey,
                        ),
                        SizedBox(width: 8),
                        if ((DbHelper().getUserType() ?? 0) == 0)
                          AppText(
                            text: '\$',
                            textSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        AppText(
                          text: _currentRange.start.toStringAsFixed(0),
                          textSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.black,
                  width: 20,
                  height: 1,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        if ((DbHelper().getUserType() ?? 0) == 0) ...[
                          AppText(
                            text: '\$',
                            textSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.textGrey,
                          ),
                          SizedBox(width: 3),
                        ],
                        AppText(
                          text: 'Max:',
                          textSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.textGrey,
                        ),
                        SizedBox(width: 8),
                        if ((DbHelper().getUserType() ?? 0) == 0)
                          AppText(
                            text: '\$',
                            textSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        AppText(
                          text: _currentRange.end.toStringAsFixed(0),
                          textSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: LayoutBuilder(builder: (context, constraints) {
              final totalWidth = constraints.maxWidth;
              final startX = _startFraction * totalWidth;
              final endX = _endFraction * totalWidth;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 10),
                      child: SfCartesianChart(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        plotAreaBorderWidth: 0,
                        primaryXAxis: const CategoryAxis(isVisible: false),
                        primaryYAxis: const NumericAxis(isVisible: false),
                        series: [
                          ColumnSeries<HistogramData, String>(
                            dataSource: widget.data
                                .asMap()
                                .entries
                                .map((e) => HistogramData(
                              e.key.toString(),
                              e.value,
                              e.key,
                            ))
                                .toList(),
                            xValueMapper: (d, _) => d.index,
                            yValueMapper: (d, _) => d.value,
                            pointColorMapper: (d, _) {
                              final indexFraction =
                                  d.originalIndex / (widget.data.length - 1);
                              return (indexFraction >= _startFraction &&
                                  indexFraction <= _endFraction)
                                  ? const Color(0xff195bff)
                                  : Colors.grey[300];
                            },
                            borderRadius: const BorderRadius.all(Radius.circular(2)),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Dotted line
                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 0,
                    child: DottedLineWithHighlight(
                      startFraction: _startFraction,
                      endFraction: _endFraction,
                    ),
                  ),

                  // Left handle
                  Positioned(
                    left: startX - handleSize / 2,
                    bottom: -8,
                    child: GestureDetector(
                      onHorizontalDragStart: (d) => _handleDragStart(d, true),
                      onHorizontalDragUpdate: (d) =>
                          _handleDragUpdate(d, totalWidth),
                      onHorizontalDragEnd: _handleDragEnd,
                      child: _buildHandle(),
                    ),
                  ),

                  // Right handle
                  Positioned(
                    left: endX - handleSize / 2,
                    bottom: -8,
                    child: GestureDetector(
                      onHorizontalDragStart: (d) => _handleDragStart(d, false),
                      onHorizontalDragUpdate: (d) =>
                          _handleDragUpdate(d, totalWidth),
                      onHorizontalDragEnd: _handleDragEnd,
                      child: _buildHandle(),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xff195bff), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Center(
        child: Icon(Icons.code, size: 15, color: Colors.black),
      ),
    );
  }
}

class DottedLineWithHighlight extends StatelessWidget {
  final double startFraction;
  final double endFraction;
  final Color defaultColor;
  final Color highlightColor;

  const DottedLineWithHighlight({
    super.key,
    required this.startFraction,
    required this.endFraction,
    this.defaultColor = const Color(0xFFD3D3D3),
    this.highlightColor = const Color(0xFF195BFF),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      child: LayoutBuilder(
        builder: (context, constraints) {
          const dotWidth = 1.5;
          const spacing = 2.0;
          final totalDots = (constraints.maxWidth / (dotWidth + spacing)).floor();

          final startDot = (startFraction * totalDots).floor();
          final endDot = (endFraction * totalDots).ceil();

          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(totalDots, (i) {
              final isActive = i >= startDot && i <= endDot;
              return Container(
                width: dotWidth,
                height: 4,
                margin: const EdgeInsets.only(right: spacing),
                decoration: BoxDecoration(
                  color: isActive ? highlightColor : defaultColor,
                  borderRadius: BorderRadius.circular(1),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

class HistogramData {
  final String index;
  final double value;
  final int originalIndex;

  HistogramData(this.index, this.value, this.originalIndex);
}
