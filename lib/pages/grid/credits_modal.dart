import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreditsModal extends StatelessWidget {
  const CreditsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Buy more credits"),
            SizedBox(height: 10),
            SpinBox(
              step: 20,
              min: 20,
              max: 1000,
              spacing: 0,
              value: 20,
              onChanged: (value) => print(value),
            ),
            OutlinedButton.icon(
                onPressed: () {
                  //pay for more
                },
                icon: Icon(FontAwesomeIcons.coins),
                label: Text("Buy More")),
            SizedBox(height: 10),
            Text("Or wait 24 hours for more tokens")
          ],
        ));
  }
}
