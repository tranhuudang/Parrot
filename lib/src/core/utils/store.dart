import 'package:flutter_version_manager/src/core/utils/path_handler.dart';

void goToStoreListing() async {
  openUrl('ms-windows-store://pdp/?productid=9NQN1PJ0FDR1');
}

void goToBugReport() async {
  openUrl('https://github.com/tranhuudang/flutter_version_manager/issues');
}

void goToGithub() async {
  openUrl('https://github.com/tranhuudang/flutter_version_manager');
}
