import 'package:parrot/src/core/utils/path_handler.dart';

void goToStoreListing() async {
  openUrl('ms-windows-store://pdp/?productid=9NQN1PJ0FDR1');
}

void goToBugReport() async {
  openUrl('https://github.com/tranhuudang/parrot/issues');
}

void goToGithub() async {
  openUrl('https://github.com/tranhuudang/parrot');
}
