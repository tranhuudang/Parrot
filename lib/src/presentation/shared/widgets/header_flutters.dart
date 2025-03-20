
import 'package:flutter/material.dart';
import 'package:parrot/src/app/app.dart';

class HeaderFlutters extends StatelessWidget {
  const HeaderFlutters({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Opacity(
          opacity: .01,
          child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                LocalDirectory.flutterLogo,
                height: 30,
                width: 30,
              )),
        ),
        Opacity(
          opacity: .05,
          child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                LocalDirectory.flutterLogo,
                height: 50,
                width: 50,
              )),
        ),
        Opacity(
          opacity: .1,
          child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                LocalDirectory.flutterLogo,
                height: 80,
                width: 80,
              )),
        ),
        Opacity(
          opacity: .2,
          child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(LocalDirectory.flutterLogo)),
        ),
      ],
    );
  }
}
