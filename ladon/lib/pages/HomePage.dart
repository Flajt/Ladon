import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ladon/features/automaticPasswordSaver/logic/savePasswordOnRequest.dart';
import 'package:ladon/features/credentialManagment/uiblock/AddCredentialButton.dart';
import 'package:ladon/features/passwordManager/bloc/ViewPasswordsBloc.dart';
import 'package:ladon/features/passwordManager/bloc/events/ViewPasswordEvents.dart';
import 'package:ladon/features/passwordManager/bloc/states/ViewPasswordStates.dart';
import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';
import 'package:ladon/features/passwordManager/logic/PasswordManager.dart';
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
    context.read<ViewPasswordBloc>().add(GetPasswords());
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
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Home",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("2-FA",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0)),
                    )
                  ])
            ],
          ),
        ),
        body: TabBarView(children: [
          SafeArea(
            child: BlocBuilder<ViewPasswordBloc, ViewPasswordState>(
                builder: (context, state) {
              if (state is HasPasswords && state.passwords.isNotEmpty) {
                List<ServiceBlueprint> data = state.passwords;
                data.sort((a, b) => a.label.compareTo(b.label));
                return ServiceDisplay(services: data);
              } else if (state is HasError) {
                return Center(child: Text(state.message.toString()));
              }
              return Center(
                child: SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      const Text("No entries"),
                      IconButton(
                          onPressed: () => context
                              .read<ViewPasswordBloc>()
                              .add(GetPasswords()),
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
