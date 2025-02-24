import 'package:dotted_border/dotted_border.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:parrot/src/core/core.dart';


class RoundedDottedDropdownButton<T> extends StatelessWidget {
  const RoundedDottedDropdownButton(
      {super.key,
        required this.value,
        required this.onChanged,
        required this.items,
         this.hint});

  final T? value;
  final Function(T?) onChanged;
  final List<DropdownMenuItem<T>> items;
  final Widget? hint;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
        dashPattern: const [3, 2],
        borderType: BorderType.RRect,
        radius: const Radius.circular(16),
        color: context.theme.colorScheme.secondaryContainer,
        strokeWidth: 1,
        child: DropdownButton<T>(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            //focusColor: Colors.transparent,
            icon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                8.width,
                const Icon(
                  FluentIcons.chevron_down_48_regular,
                  size: 18,
                ),
              ],
            ),
            underline: const SizedBox(),
            borderRadius: BorderRadius.circular(15),
            value: value,
            hint: hint ?? const Text(''),
            items: items,
            onChanged: onChanged));
  }
}

