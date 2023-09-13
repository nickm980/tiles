import 'package:flutter/material.dart';

class Grid {
  final int width;
  final int height;
  final Map<String, int> colors;
  static List<Color> availableColors = const [
    Colors.white,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.black,
    Colors.blue,
    Colors.pink,
  ];

  Grid({required this.width, required this.height, required this.colors});

  nearbyColors(int x, int y) {
    return colors;
  }

  int colorAt(int x, int y) {
    return colors["$x,$y"] ?? 0;
  }

  static convertColor(int value) {
    return availableColors.elementAt(value);
  }

  static convertColorToInt(Color value) {
    return availableColors.indexOf(value);
  }

  factory Grid.fromJson(Map<String, dynamic> json) {
    return Grid(height: 1, width: 1, colors: json['image']);
  }

  void setPixel(int x, int y, Color color) {
    colors["$x,$y"] = Grid.convertColorToInt(color);
  }
}
