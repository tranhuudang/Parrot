import 'package:flutter/material.dart';
import 'package:parrot/src/core/core.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key, required this.children, required this.title, this.leading});
  final List<Widget> children;
  final String title;
  final Widget? leading;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.theme.dividerColor,
            width: .2,
          ),
        ),
      ),
      height: 53,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leading != null) ...[
            leading!,
            16.width,
          ],
          Text(
            title,
            style: context.theme.textTheme.titleMedium,
          ),
          const Spacer(),
          ...children
        ],
      ),
    );
  }
}
