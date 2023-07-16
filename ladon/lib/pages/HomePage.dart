import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ladon/features/automaticPasswordSaver/logic/savePasswordOnRequest.dart';
import 'package:ladon/features/credentialManagment/uiblock/AddCredentialButton.dart';
import 'package:ladon/features/passwordManager/bloc/ViewPasswordsBloc.dart';
import 'package:ladon/features/passwordManager/bloc/events/ViewPasswordEvents.dart';
import 'package:ladon/features/passwordManager/bloc/states/ViewPasswordStates.dart';
import 'package:ladon/features/passwordManager/uiblocks/ServiceDisplay.dart';
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
    context.read<ViewPasswordBloc>().add(Setup());
  }

  Future<void> _asyncWrapper() async {
    await handleAutoFillRequest();
  }

  @override
  Widget build(BuildContext context) {
    savePasswordOnRequest();
    return BlocListener<ViewPasswordBloc, ViewPasswordState>(
      listener: (context, state) {
        if (state is RedirectToWelcome) {
          Navigator.of(context)
              .popAndPushNamed("/welcomePage", arguments: {"pwKey": state.key});
        }
      },
      child: DefaultTabController(
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
          body: const TabBarView(
              children: [SafeArea(child: ServiceDisplay()), ViewOtpsPage()]),
          floatingActionButton: const AddCredentialButton(),
        ),
      ),
    );
  }
}
