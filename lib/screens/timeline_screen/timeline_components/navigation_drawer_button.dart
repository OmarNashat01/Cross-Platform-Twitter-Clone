import 'package:flutter/material.dart';
class NavigationDrawerButton extends StatelessWidget {
  NavigationDrawerButton({required this.text,required this.onPressed,required this.icon});
  final void Function() onPressed;
  Widget icon;
  Widget text;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed:onPressed,
        child: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 10, left: 13, right: 20),
          child: Row(
            children: [
              icon,
              const SizedBox(
                width: 20,
              ),
              text,
            ],
          ),
        ),
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith(
                (states) => Colors.blueGrey.shade100),
      ),
    );
  }
}
