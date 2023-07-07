import 'package:flutter/material.dart';
import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';
import 'package:ladon/features/passwordManager/logic/PasswordManager.dart';
import 'package:ladon/features/passwordManager/uiblocks/DeleteServicebutton.dart';
import 'package:ladon/features/passwordManager/uiblocks/ServiceColumn.dart';

class PasswordEditingPage extends StatefulWidget {
  const PasswordEditingPage({Key? key}) : super(key: key);

  @override
  State<PasswordEditingPage> createState() => _PasswordEditingPageState();
}

class _PasswordEditingPageState extends State<PasswordEditingPage> {
  late final TextEditingController labelController;
  late final TextEditingController appNameController;
  late final TextEditingController urlController;
  late final TextEditingController passwordController;
  late final TextEditingController usernameController;
  late final ServiceBlueprint blueprint;

  @override
  void initState() {
    super.initState();
    labelController = TextEditingController();
    appNameController = TextEditingController();
    urlController = TextEditingController();
    passwordController = TextEditingController();
    usernameController = TextEditingController();
  }

  @override
  void dispose() {
    labelController.dispose();
    appNameController.dispose();
    urlController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    blueprint = data["blueprint"];
    prefillControllers(blueprint);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SafeArea(
            child: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(children: [
            Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: size.height * .1),
                  child: Title(
                      color: Colors.black,
                      child: Text(blueprint.label,
                          style: Theme.of(context).textTheme.headline3!)),
                )),
            Align(
                alignment: Alignment.center,
                child: Container(
                    padding: const EdgeInsets.all(12.0),
                    width: size.width * .8,
                    height: size.height * .5,
                    child: ServiceColumn(
                        labelController: labelController,
                        usernameController: usernameController,
                        passwordController: passwordController,
                        appNameController: appNameController,
                        urlController: urlController)))
          ]),
        )),
      ),
      floatingActionButton: DeleteServiceButton(
          serviceBlueprint: blueprint, passwordManager: PasswordManager()),
    );
  }

  void prefillControllers(ServiceBlueprint blueprint) {
    labelController.value = TextEditingValue(text: blueprint.label);
    passwordController.value = TextEditingValue(text: blueprint.password);
    usernameController.value = TextEditingValue(text: blueprint.email);
    appNameController.value = TextEditingValue(text: blueprint.app ?? "");
    urlController.value = TextEditingValue(text: blueprint.domain ?? "");
  }
}
