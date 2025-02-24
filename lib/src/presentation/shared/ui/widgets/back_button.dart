import 'package:flutter/material.dart';
import 'package:parrot/src/core/router/route_configurations_desktop.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const CustomBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () {
        goBranch(0);
      } ,
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: Icon(
            Icons.chevron_left,
            size: 28,
          )),
          SizedBox(
              height: 36,
              child: VerticalDivider(
                width: 0,
              ))
        ],
      ),
    );
  }
}
