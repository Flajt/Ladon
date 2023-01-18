import 'package:flutter/material.dart';
import 'package:ladon/features/automaticPasswordSaver/logic/savePasswordOnRequest.dart';
import 'package:ladon/features/credentialManagment/uiblock/AddCredentialButton.dart';
import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';
import 'package:ladon/features/passwordManager/logic/passwordManager.dart';
import 'package:ladon/features/passwordManager/uiblocks/ServiceDisplay.dart';
import 'package:ladon/features/welcome/logic/setup.dart';
import 'package:ladon/pages/ViewOtpsPage.dart';

import '../features/passwordManager/logic/handleAutofillRequests.dart';

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

  @override
  Widget build(BuildContext context) {
    Future<List<ServiceBlueprint>> getPasswords =
        PasswordManager().getPasswords();
    savePasswordOnRequest();
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
                future: getPasswords,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    List<ServiceBlueprint> data = snapshot.data!;
                    data.sort((a, b) => a.label.compareTo(b.label));
                    return ServiceDisplay(services: data);
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data == []) {
                    return const Center(child: Text("No data"));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Center(
                    child: SizedBox(
                      height: 100,
                      child: Column(
                        children: [
                          const Text("No entries"),
                          IconButton(
                              onPressed: () => setState(() {}),
                              icon: const Icon(Icons.refresh))
                        ],
                      ),
                    ),
                  );
                }),
          ),
          const ViewOtpsPage()
        ]),
        floatingActionButton: const AddCredentialButton(),
      ),
    );
  }
}
