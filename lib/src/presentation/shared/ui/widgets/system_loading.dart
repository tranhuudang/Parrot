import 'package:flutter/material.dart';

class SystemLoadingIndicator extends StatelessWidget {
  const SystemLoadingIndicator(
      {super.key, required this.isLoading, required this.child});

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          ignoring: isLoading,
          child: Opacity(
            opacity: isLoading ? .5 : 1,
            child: child,
          ),
        ),
        if (isLoading)
          const Center(
            child: SizedBox(
                height: 30, width: 30, child: CircularProgressIndicator()),
          )
      ],
    );
  }
}
