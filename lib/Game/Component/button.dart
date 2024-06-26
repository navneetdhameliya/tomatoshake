import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../const/colors.dart';

class ButtonWidget extends ConsumerWidget {
  const ButtonWidget(
      {super.key, this.text, this.icon, required this.onPressed});

  final String? text;
  final IconData? icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (icon != null) {

      return Container(
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(8.0)),
        child: IconButton(
            color: Colors.white,
            onPressed: onPressed,
            icon: Icon(
              icon,
              size: 24.0,
            )),
      );
    }

    return ElevatedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.all(16.0)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black54)),
        onPressed: onPressed,
        child: Text(
          text!,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,decoration: TextDecoration.none),
        ));
  }
}
