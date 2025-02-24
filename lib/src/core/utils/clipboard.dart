import 'package:flutter/services.dart';
import 'package:flutter_version_manager/src/core/core.dart';
import 'package:flutter_version_manager/src/presentation/presentation.dart';

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
