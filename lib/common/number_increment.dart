import 'package:flutter/material.dart';

class NumberIncrementer extends StatefulWidget {
  @override
  _NumberIncrementerState createState() => _NumberIncrementerState();
}

class _NumberIncrementerState extends State<NumberIncrementer> {
  int _currentValue = 0;

  void _increment() {
    setState(() {
      _currentValue++;
    });
  }

  void _decrement() {
    setState(() {
      if (_currentValue > 0) {
        _currentValue--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: _decrement,
        ),
        Text('$_currentValue'),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: _increment,
        ),
      ],
    );
  }
}