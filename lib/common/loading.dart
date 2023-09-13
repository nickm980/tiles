import 'package:flutter/material.dart';

class LoadingActionIcon extends StatelessWidget {
  const LoadingActionIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 15,
      width: 15,
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.grey,
          strokeWidth: 2,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
