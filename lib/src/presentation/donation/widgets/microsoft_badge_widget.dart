import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parrot/src/core/core.dart';

class MicrosoftBadgeWidget extends StatefulWidget {
  const MicrosoftBadgeWidget({super.key});

  @override
  State<MicrosoftBadgeWidget> createState() => _MicrosoftBadgeWidgetState();
}

class _MicrosoftBadgeWidgetState extends State<MicrosoftBadgeWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          openUrl(OnlineDirectory.parrotProMicrosoftLink);
        },
        child: Container(
            width: 156,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child:  SvgPicture.asset(
              LocalDirectory.microsoftStoreBadge,
            )));
  }
}
