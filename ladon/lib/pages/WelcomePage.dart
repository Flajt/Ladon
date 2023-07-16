import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:ladon/shared/notifications/uiblock/SuccessNotification.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context)!.settings.arguments as Map;
    String pwKey = args["pwKey"];
    return Scaffold(
        body: SafeArea(
      child: IntroductionScreen(
        done: const Text("Let's start"),
        showNextButton: true,
        showSkipButton: false,
        showDoneButton: true,
        next: const Text("Next"),
        onDone: () => Navigator.of(context).popAndPushNamed("/"),
        pages: [
          PageViewModel(
              title: "Welcome to Ladon",
              image: Center(child: Image.asset("assets/signboard.png")),
              body: "Thank you for choosing Ladon as a Password Manager."),
          PageViewModel(
              image: Center(child: Image.asset("assets/tax-free.png")),
              title: "Free 4 Ever",
              body:
                  "Unlimited Passwords, 2FA, exports and backups are free for ever. If you want to, you can tip me in the settings page, however this is purely optional."),
          PageViewModel(
              image: Center(child: Image.asset("assets/github.png")),
              title: "Open Source",
              body:
                  "This app is opensource, so you can checkout the source code on Github and contribute if you want."),
          PageViewModel(
              image: Center(child: Image.asset("assets/digital-key.png")),
              title: "Master Key",
              bodyWidget: Column(
                children: [
                  const Text(
                      "Before we start, please save/write down this key, this is your master key!"),
                  const Text(
                      "It's used to encrypt the database with your passwords, so please don't loose it"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .8,
                        child: Text(
                          pwKey,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: pwKey));
                            SuccessNotification(
                                    context: context, message: "Key copied")
                                .show(context);
                          },
                          icon: const Icon(Icons.copy))
                    ],
                  )
                ],
              ))
        ],
      ),
    ));
  }
}
