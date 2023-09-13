import 'package:flutter/material.dart';

class ColorPallette extends StatelessWidget {
  final List<Color> colors;
  final Function(Color color) onColorChange;
  final Color currentColor;

  const ColorPallette(
      {super.key,
      required this.colors,
      required this.onColorChange,
      required this.currentColor});

  _setActiveColor(Color color) {
    onColorChange(color);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> options = colors
        .map((color) => ColorSelection(
            color: color,
            active: currentColor == color,
            onPress: _setActiveColor))
        .toList();

    return Wrap(
      spacing: 10,
      runSpacing: 0,
      crossAxisAlignment: WrapCrossAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [...options],
    );
  }
}

class ColorSelection extends StatelessWidget {
  final Color color;
  final bool active;
  final Function(Color color) onPress;

  const ColorSelection(
      {super.key,
      required this.color,
      required this.active,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            side: active
                ? MaterialStateProperty.all(
                    const BorderSide(color: Colors.black, width: 3))
                : MaterialStateProperty.all(
                    const BorderSide(color: Colors.grey, width: 1)),
            elevation: MaterialStateProperty.all(0),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            backgroundColor: MaterialStateProperty.all(color)),
        onPressed: () {
          onPress(color);
        },
        child: SizedBox(
          width: 20,
          height: 10,
          child: Container(),
        ));
  }
}
