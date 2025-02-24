import 'package:flutter/material.dart';

class DisabledWidget extends StatelessWidget {
  const DisabledWidget(
      {super.key, required this.isDisabled, required this.child});

  final bool isDisabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isDisabled,
      child: Opacity(
        opacity: isDisabled ? .5 : 1,
        child: child,
      ),
    );
  }
}
