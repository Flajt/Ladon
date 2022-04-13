import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_autofill_service/flutter_autofill_service.dart';
import 'package:ladon/features/automaticPasswordSaver/logic/savePasswordOnRequest.dart';
import 'package:ladon/features/credentialManagment/uiblock/AddCredentialButton.dart';
import 'package:ladon/features/otp/logic/generateOtp.dart';
import 'package:ladon/features/otp/uiblocks/OtpTile.dart';
import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';
import 'package:ladon/features/passwordManager/logic/passwordManager.dart';
import 'package:ladon/features/passwordManager/uiblocks/ServiceDisplay.dart';
import 'package:ladon/features/serviceSettings/logic/servicePreferences.dart';
import 'package:ladon/features/welcome/logic/setup.dart';
import 'package:ladon/pages/ViewOtpsPage.dart';
import 'package:ladon/shared/notifications/uiblock/SuccessNotification.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _asyncWrapper();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    //await authAndOnboarding();
  }

  Future<void> _asyncWrapper() async {
    await authAndOnboarding();
    await handleAutoFillRequest();
  }

  Future<void> authAndOnboarding() async {
    List resp = await setup();
    if (resp[1] == true) {
      Navigator.of(context)
          .popAndPushNamed("/welcomePage", arguments: {"pwKey": resp[0]});
    }
    setState(() {});
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
          if (matchingPasswords.length == 1) {
            if (matchingPasswords[0].twoFASecret.isNotEmpty) {
              String otp = generateTotp(matchingPasswords[0].twoFASecret);
              await Clipboard.setData(ClipboardData(text: otp.toString()));
            }
          }
          await AutofillService().resultWithDatasets(matchingDatasets);
        }
        await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }

  @override
  Widget build(BuildContext context) {
    savePasswordOnRequest();
    //handleAutoFillRequest();
    ServicePreferences.setupAutoFillServiceIfNotSelected();
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                  indicatorColor: Theme.of(context).primaryColor,
                  tabs: const [
                    Text(
                      "Home",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Text("2-FA",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0))
                  ])
            ],
          ),
        ),
        body: TabBarView(children: [
          SafeArea(
              child: FutureBuilder<List<ServiceBlueprint>>(
                  future: PasswordManager().getPasswords(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return ServiceDisplay(services: snapshot.data!);
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else if (snapshot.connectionState ==
                            ConnectionState.done &&
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
          const ViewOtpsPage()
        ]),
        floatingActionButton: const AddCredentialButton(),
      ),
    );
  }
}
