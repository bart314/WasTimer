import 'dart:ui';

class TimerModel {
  final String type;
  final int duration;
  final Color ringColor;
  final Color fillColor;
  final Color backgroundColor;

  TimerModel({
    required this.type,
    required this.duration,
    required this.ringColor,
    required this.fillColor,
    required this.backgroundColor,
  });
}
