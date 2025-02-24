import 'package:parrot/src/core/configs/configs.dart';
import 'package:parrot/src/core/constants/constants.dart';
import 'package:parrot/src/core/utils/path_handler.dart';

void goToStoreListing() async {
  if (isProVersion) {
    openUrl(OnlineDirectory.parrotProMicrosoftLink);
  } else {
    openUrl('ms-windows-store://pdp/?productid=9NQN1PJ0FDR1');
  }
}

void goToBugReport() async {
  openUrl('https://github.com/tranhuudang/parrot/issues');
}

void goToGithub() async {
  openUrl('https://github.com/tranhuudang');
}
