import 'package:flutter/material.dart';

class ControlProjectButton extends StatelessWidget {
  const ControlProjectButton({
    super.key,
    required this.enabled,
    this.onPressed,
    required this.icon,
    this.backgroundColor,
  });

  final bool enabled;
  final VoidCallback? onPressed;
  final Widget icon;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !enabled,
      child: Opacity(
        opacity: enabled ? 1 : .3,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onPressed ?? () {},
          child: Container(
            padding:
            const EdgeInsets.only(left: 7, right: 9, bottom: 8, top: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: backgroundColor ?? const Color(0xFF66BB6A)),
            child: icon,
          ),
        ),
      ),
    );
  }
}
