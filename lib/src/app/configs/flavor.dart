enum Flavor { free, pro }

bool get isFreeVersion => AppFlavor.instance.flavor == Flavor.free;
bool get isProVersion => AppFlavor.instance.flavor == Flavor.pro;
String get appName => AppFlavor.instance.appName;

class AppFlavor {
  final String appName;
  final Flavor flavor;

  AppFlavor({required this.appName, required this.flavor});

  static late AppFlavor instance;

  static void init({required Flavor flavor}) {
    instance = AppFlavor(
      appName: flavor == Flavor.free ? "Parrot" : "Parrot Pro",
      flavor: flavor,
    );
  }
}
