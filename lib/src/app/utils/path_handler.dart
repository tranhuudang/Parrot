import 'package:parrot/src/app/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

openUrl(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}

void openDirectory(String path) {
  try {
    Process.run('explorer', [path]);
  } catch (e) {
    DebugLog.error('Could not open directory $path');
  }
}
