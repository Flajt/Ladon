import 'package:flutter/material.dart';
import 'package:flutter_donation_buttons/donationButtons/buyMeACoffeeButton.dart';
import 'package:flutter_donation_buttons/donationButtons/ko-fiButton.dart';

class SupportDialog extends StatelessWidget {
  const SupportDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Support"),
            BuyMeACoffeeButton(buyMeACoffeeName: "flajt"),
            KofiButton(kofiName: "flajt", kofiColor: KofiColor.Orange)
          ],
        ),
      ),
    );
  }
}
