import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parrot/bloc_provider_scope.dart';
import 'package:window_manager/window_manager.dart';
import 'package:parrot/src/core/core.dart';
import 'package:parrot/src/presentation/presentation.dart';
import 'package:windows_status_bar/windows_status_bar.dart';
import 'app.dart';
part 'initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppFlavor.init(flavor: Flavor.pro);
  await _Initializer.start();
  runApp(
    const BlocProviderScope(
      child: ProviderScope(child: App()),
    ),
  );
}
