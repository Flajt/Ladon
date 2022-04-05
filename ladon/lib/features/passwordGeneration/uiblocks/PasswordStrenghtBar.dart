import 'package:flutter/material.dart';

/// Displays password strength
class PasswordStrengthBar extends StatelessWidget {
  const PasswordStrengthBar(
      {Key? key, required this.passwordStrength, this.width = 100})
      : super(key: key);
  final double passwordStrength;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 10,
      child: Container(
        color: passwordStrength < 0.3
            ? Colors.red
            : passwordStrength > 0.3 && passwordStrength < 0.6
                ? Colors.yellow
                : Colors.green,
      ),
    );
  }
}
