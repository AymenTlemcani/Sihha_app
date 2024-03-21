import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  final Function() OnTapFunction;
  const MyBackButton({
    super.key,
    required this.OnTapFunction,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: OnTapFunction,
        icon: const Icon(
          // LineAwesomeIcons.angle_left,
          Icons.arrow_back_ios_new_rounded,
          color: Colors.black,
          size: 20,
        )

        // Icon(LineAwesomeIcons.angle_left)

        );
  }
}
