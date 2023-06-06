import 'package:flutter/material.dart';

import '../../data/themes.dart';

class ButtonOferts extends StatelessWidget {
  final Function() onPressed;
  const ButtonOferts({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          width: 64,
          height: 64,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: kGrey200,
              width: 1,
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Más',
                style: TextStyle(fontSize: 12),
              ),
              Icon(
                Icons.arrow_forward,
                size: 15,
                color: kSecondary,
              ),
            ],
          )),
    );
  }
}
