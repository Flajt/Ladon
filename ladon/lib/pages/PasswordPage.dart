import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';
import 'package:ladon/features/passwordManager/logic/passwordManager.dart';
import 'package:ladon/features/passwordManager/uiblocks/ServiceColumn.dart';
import 'package:ladon/shared/notifications/uiblock/SuccessNotification.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final PasswordManager _passwordManager = PasswordManager();
  late final TextEditingController urlController;
  late final TextEditingController appNameController;
  late final TextEditingController passwordController;
  late final TextEditingController labelController;
  late final TextEditingController usernameController;
  @override
  void initState() {
    super.initState();
    urlController = TextEditingController();
    appNameController = TextEditingController();
    passwordController = TextEditingController();
    labelController = TextEditingController();
    usernameController = TextEditingController();
  }

  @override
  void dispose() {
    labelController.dispose();
    usernameController.dispose();
    urlController.dispose();
    appNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: size.height * .1),
                  child: Text(
                    "Service Credentials",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Card(
                  child: Container(
                      width: size.width * .9,
                      height: size.height * .5,
                      padding: const EdgeInsets.all(8.0),
                      child: ServiceColumn(
                        appNameController: appNameController,
                        labelController: labelController,
                        usernameController: usernameController,
                        passwordController: passwordController,
                        urlController: urlController,
                      )),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
