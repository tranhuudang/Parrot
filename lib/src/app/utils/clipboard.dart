import 'package:flutter/services.dart';
import 'package:parrot/src/core/core.dart';
import 'package:parrot/src/presentation/presentation.dart';

copyToClipboard(BuildContext context, {required String text}) {
  Clipboard.setData(
    ClipboardData(text: text),
  );
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Copied to clipboard'.i18n),
    ),
  );
}
