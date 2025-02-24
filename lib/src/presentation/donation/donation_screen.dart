import 'package:parrot/src/core/core.dart';
import 'package:parrot/src/presentation/donation/widgets/paypal_donation_widget.dart';

import '../presentation.dart';
import '../shared/ui/widgets/divider_with_text.dart';

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
            title: 'Development Fund'.i18n,
            children: const [],
          ),
          Expanded(
            child: Center(
              child: SizedBox(
                //color: Colors.red,
                width: 700,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Join the 2%'.i18n,
                                style: const TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold)),
                            4.height,
                            Text('description-donation'.i18n,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.grey)),
                          ],
                        ),
                      ),
                      8.width,
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 156,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child:
                                      Image.asset('assets/donation/bmc_qr.png')),
                            ),
                            const SizedBox(height: 20),
                            DividerWithText(text: 'or'.i18n),
                            16.height,
                            const PaypalDonationWidget(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
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
