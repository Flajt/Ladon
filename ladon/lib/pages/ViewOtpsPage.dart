import 'package:flutter/material.dart';
import 'package:ladon/features/otp/blueprints/OtpBlueprint.dart';
import 'package:ladon/features/otp/uiblocks/OtpTile.dart';
import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';
import 'package:ladon/features/passwordManager/logic/PasswordManager.dart';

class ViewOtpsPage extends StatelessWidget {
  const ViewOtpsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder<List<ServiceBlueprint>>(
              future: PasswordManager().getPasswords(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        if (snapshot.data![index].twoFASecret.isNotEmpty) {
                          return OtpTile(
                              otpBlueprint: OtpBlueprint.fromServiceBlueprint(
                                  snapshot.data![index]));
                        } else {
                          return Container();
                        }
                      });
                }
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              })),
    );
  }
}
