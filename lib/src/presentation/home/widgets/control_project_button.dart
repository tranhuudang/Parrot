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
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: enabled ? 1 : .3,
        child: Material(
          color: backgroundColor ?? const Color(0xFF66BB6A),
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onPressed ?? () {},
            child: SizedBox(
              width: 35,
              height: 35,
              //padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}
