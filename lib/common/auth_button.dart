import 'package:app2/common/loading.dart';
import 'package:flutter/material.dart';

class AuthBaseButton extends StatelessWidget {
  final bool loading;
  final String text;
  final IconData iconData;
  final VoidCallback onPressed;

  const AuthBaseButton(
      {super.key,
      bool? loading,
      required this.text,
      required this.iconData,
      required this.onPressed})
      : loading = loading ?? false;

  @override
  Widget build(BuildContext context) {
    Widget label = loading ? const LoadingActionIcon() : Text(text);

    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(iconData),
      label: label,
    );
  }
}
