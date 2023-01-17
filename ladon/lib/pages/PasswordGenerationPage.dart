import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../features/passwordGeneration/logic/generatePassword.dart';

class PasswordGenerationPage extends StatefulWidget {
  const PasswordGenerationPage({Key? key}) : super(key: key);

  @override
  State<PasswordGenerationPage> createState() => _PasswordGenerationPageState();
}

class _PasswordGenerationPageState extends State<PasswordGenerationPage> {
  int passwordLength = 16;
  @override
  Widget build(BuildContext context) {
    String generatedPassword =
        PasswordGenerator.generatePassword(passwordLength: passwordLength);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(children: [
        Positioned(
          left: size.width * .05,
          top: size.height * .08,
          child: Title(
              color: Theme.of(context).primaryColor,
              child: const Text(
                "Password Generation",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              )),
        ),
        Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  generatedPassword,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      overflow: TextOverflow.ellipsis),
                ),
                IconButton(
                    onPressed: () => Clipboard.setData(
                        ClipboardData(text: generatedPassword)),
                    icon: const Icon(
                      Icons.copy,
                      semanticLabel: "Copy Password",
                    ))
              ],
            )),
        Positioned(
            bottom: size.height * .2,
            left: size.width * .1,
            child: SizedBox(
              width: size.width * .8,
              child: Slider(
                  label: passwordLength.toString(),
                  max: 30,
                  min: 8,
                  divisions: 22,
                  value: passwordLength.toDouble(),
                  onChanged: (newValue) =>
                      setState(() => passwordLength = newValue.toInt())),
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
                onPressed: () => setState(() => generatedPassword =
                    PasswordGenerator.generatePassword(
                        passwordLength: passwordLength)),
                icon: const Icon(Icons.refresh),
                label: const Text("Generate Password"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor)),
          ),
        )
      ]),
    )));
  }
}
