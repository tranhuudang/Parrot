import 'package:flutter/material.dart';
import 'package:flutter_version_manager/src/core/core.dart';

class PaypalDonationWidget extends StatefulWidget {
  const PaypalDonationWidget({super.key});

  @override
  State<PaypalDonationWidget> createState() => _PaypalDonationWidgetState();
}

class _PaypalDonationWidgetState extends State<PaypalDonationWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          openUrl(OnlineDirectory.paypalLink);
        },
        child: Container(
            width: 156,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Image.asset(
              'assets/donation/paypal-donate-button.png',
            )));
  }
}
