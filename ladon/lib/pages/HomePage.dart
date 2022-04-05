import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_autofill_service/flutter_autofill_service.dart';
import 'package:ladon/features/automaticPasswordSaver/logic/savePasswordOnRequest.dart';
import 'package:ladon/features/credentialManagment/uiblock/AddCredentialButton.dart';
import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';
import 'package:ladon/features/passwordManager/logic/passwordManager.dart';
import 'package:ladon/features/passwordManager/uiblocks/ServiceDisplay.dart';
import 'package:ladon/features/serviceSettings/logic/servicePreferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    handleAutoFillRequest();
  }

  Future<void> handleAutoFillRequest() async {
    PasswordManager passwordManager = PasswordManager();
    bool fillauto = await AutofillService().fillRequestedAutomatic;
    bool fillself = await AutofillService().fillRequestedInteractive;

    if (fillself || fillauto) {
      AutofillMetadata? metadata =
          await AutofillService().getAutofillMetadata();
      String? webDomain = metadata!.webDomains.isNotEmpty
          ? metadata.webDomains.first.scheme! +
              "://" +
              metadata.webDomains.first.domain
          : null;
      String? appName =
          metadata.packageNames.isNotEmpty ? metadata.packageNames.first : null;
      List<ServiceBlueprint> matchingPasswords =
          await passwordManager.searchPassword(webDomain, appName);
      if (matchingPasswords.isNotEmpty) {
        List<PwDataset> matchingDatasets = [];
        for (ServiceBlueprint element in matchingPasswords) {
          matchingDatasets.add(PwDataset(
              label: element.label,
              username: element.email,
              password: element.password));
        }
        if (matchingDatasets.isNotEmpty) {
          await AutofillService().resultWithDatasets(matchingDatasets);
        }
        await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    savePasswordOnRequest();
    //handleAutoFillRequest();
    ServicePreferences.setupAutoFillServiceIfNotSelected();
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder<List<ServiceBlueprint>>(
              future: PasswordManager().getPasswords(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ServiceDisplay(services: snapshot.data!);
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data == []) {
                  return const Center(child: Text("No data"));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const Center(
                  child: Text("No entries"),
                );
              })),
      floatingActionButton: const AddCredentialButton(),
    );
  }
}
