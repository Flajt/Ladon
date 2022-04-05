import 'package:flutter/material.dart';
import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';
import 'package:ladon/features/passwordManager/logic/passwordManager.dart';

class OtpPage extends StatelessWidget {
  OtpPage({Key? key}) : super(key: key);
  final passwordFuture = PasswordManager().getPasswords();
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<ServiceBlueprint>> tiles = [];
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Save OTP",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor)),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width * .6,
                          child: TextFormField(
                            decoration:
                                const InputDecoration(labelText: "OTP Secret"),
                          ),
                        ),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.qr_code))
                      ],
                    ),
                    FutureBuilder<List<ServiceBlueprint>>(
                        future: passwordFuture,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<ServiceBlueprint> blueprints = snapshot.data!;
                            for (ServiceBlueprint element in blueprints) {
                              tiles.add(DropdownMenuItem(
                                  value: element,
                                  child: SizedBox(
                                    child: Text(element.label),
                                  )));
                            }
                            return DropdownButton<ServiceBlueprint>(
                                hint: const Text("Service for 2FA/OTP"),
                                borderRadius: BorderRadius.circular(8.0),
                                items: tiles,
                                onChanged: (item) {});
                          }
                          return const CircularProgressIndicator();
                        }),
                    ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          "Save 2FA",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            minimumSize: const Size(150, 50)))
                  ],
                ),
              )
            ],
          ),
        )));
  }
}
