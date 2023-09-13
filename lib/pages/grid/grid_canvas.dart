import 'package:app2/models/coordinates.dart';
import 'package:app2/models/grid.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';

class GridCanvas extends StatefulWidget {
  final Color currentColor;
  final Grid grid;
  final Function(Coordinates coords) onCursorChange;

  const GridCanvas(
      {super.key,
      required this.grid,
      required this.currentColor,
      required this.onCursorChange});

  @override
  State<GridCanvas> createState() => _GridCanvasState();
}

class _GridCanvasState extends State<GridCanvas> {
  double x = 0;
  double y = 0;
  final int cellSize = 1;
  Coordinates coords = Coordinates(x: 1, y: 0);
  double _scale = 1.0;
  double _previousScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onScaleStart: (details) {
          _previousScale = _scale;
        },
        onScaleUpdate: (details) {
          setState(() {
            _scale = _previousScale * details.scale;
          });
        },
        onScaleEnd: (details) {
          _previousScale = 1.0;
        },
        onTapUp: (details) {
          final x = (details.localPosition.dx / cellSize).floor();
          final y = (details.localPosition.dy / cellSize).floor();
          print('Clicked on cell at ($x, $y)');
          widget.onCursorChange(Coordinates(x: x, y: y));
          setState(() {
            coords = Coordinates(x: x, y: y);
          });
        },
        child: RepaintBoundary(
          child: CustomPaint(
            size: Size.square(MediaQuery.of(context).size.width),
            painter: GridPainter(
                panOffset: 0,
                currentColor: widget.currentColor,
                defaultCellSize: 20,
                scale: _scale,
                grid: widget.grid,
                coords: coords),
          ),
        ));
  }
}

class GridPainter extends CustomPainter {
  final random = math.Random();
  final double defaultCellSize;
  final double scale;
  final Grid grid;
  //0 is centered
  final Color currentColor;
  final Coordinates coords;
  final selectedBorderColor = Colors.black;
  final int panOffset;

  GridPainter(
      {required this.defaultCellSize,
      required this.scale,
      required this.panOffset,
      required this.grid,
      required this.currentColor,
      required this.coords});

  int clamp(int value) {
    return value ~/ (defaultCellSize * scale);
  }

  paintCursor(int x, int y, Canvas canvas, double cellSize) {
    //draw the border around the selected pixel
    final rect = Rect.fromPoints(
      Offset(x * cellSize, y * cellSize),
      Offset((x + 1) * cellSize, (y + 1) * cellSize),
    );

    final paint = Paint()..color = selectedBorderColor;
    canvas.drawRect(rect.inflate(2), paint);

    //Draw the inside color
    drawRect(canvas, x, y, cellSize, currentColor);
  }

  drawRect(Canvas canvas, int x, int y, double size, Color color) {
    final rect = Rect.fromPoints(
      Offset(x * size, y * size),
      Offset((x + 1) * size, (y + 1) * size),
    );

    final paint = Paint()..color = color;
    canvas.drawRect(rect, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    print("repainting...");

    double scaledCellSize = defaultCellSize * scale;
    double maxCellCount = size.width / scaledCellSize;
    int currentCellX = clamp(coords.x);
    int currentCellY = clamp(coords.y);

    for (int x = 0; x < maxCellCount; x++) {
      for (int y = 0; y < maxCellCount; y++) {
        Color color = Grid.convertColor(grid.colorAt(x, y));

        drawRect(canvas, x, y, scaledCellSize, color);
      }
    }

    paintCursor(currentCellX, currentCellY, canvas, scaledCellSize);
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) {
    return oldDelegate.currentColor != currentColor ||
        identical(oldDelegate.grid, grid) ||
        oldDelegate.coords != coords;
  }
}
