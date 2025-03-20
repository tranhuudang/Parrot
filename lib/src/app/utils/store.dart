import 'package:marina_labs_common/marina_labs_common.dart';
import 'package:parrot/src/app/configs/configs.dart';
import 'package:parrot/src/app/constants/constants.dart';

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
