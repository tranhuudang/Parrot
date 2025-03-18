import 'package:marina_labs_common/marina_labs_common.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:parrot/src/app/app.dart';
import '../presentation.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            leading: const Icon(FluentIcons.handshake_16_regular),
            title: 'Development Fund'.i18n,
            children: const [],
          ),
          const Expanded(
            child: DakSolutionsDonationBody(
              donationArea: DonationArea.international,
              microsoftUrl: OnlineDirectory.parrotProMicrosoftLink,
              paypalUrl: OnlineDirectory.paypalLink,
              isShowBuyAMeCoffeeQr: true,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTitle extends StatelessWidget {
  final String title;
  final IconData iconData;

  const CustomTitle({
    super.key,
    required this.title,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        16.width,
        Icon(iconData),
        16.width,
        Text(title),
      ],
    );
  }
}
