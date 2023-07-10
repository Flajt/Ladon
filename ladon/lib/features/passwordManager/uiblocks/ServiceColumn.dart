import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:ladon/features/passwordManager/bloc/CreateServiceBloc.dart';

import '../../../shared/notifications/uiblock/SuccessNotification.dart';
import '../bloc/events/CreateServiceEvents.dart';
import '../blueprints/ServiceBlueprint.dart';
import '../logic/PasswordManager.dart';

class ServiceColumn extends StatelessWidget {
  final TextEditingController labelController;

  final TextEditingController usernameController;

  final TextEditingController passwordController;

  final TextEditingController appNameController;

  final TextEditingController urlController;

  const ServiceColumn(
      {Key? key,
      required this.labelController,
      required this.usernameController,
      required this.passwordController,
      required this.appNameController,
      required this.urlController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passwordManger = PasswordManager();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextFormField(
          keyboardType: TextInputType.text,
          controller: labelController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator:
              ValidationBuilder().minLength(2).maxLength(20).required().build(),
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Label"),
              hintText: "E.g. Google"),
        ),
        TextFormField(
            validator: ValidationBuilder().minLength(2).maxLength(20).build(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.emailAddress,
            controller: usernameController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), label: Text("Username"))),
        TextFormField(
            keyboardType: TextInputType.visiblePassword,
            validator: ValidationBuilder()
                .minLength(8)
                .maxLength(64)
                .required()
                .build(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: true,
            controller: passwordController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), label: Text("Password"))),
        TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: appNameController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("App name"),
                hintText: "E.g. com.example.test")),
        TextFormField(
            validator: ValidationBuilder().url().build(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.url,
            controller: urlController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Website url"),
                hintText: "E.g. https://test.com")),
        ElevatedButton(
          onPressed: () async {
            ServiceBlueprint blueprint = _handleSubmssion(
                usernameController,
                passwordController,
                labelController,
                appNameController,
                urlController,
                passwordManger);
            context.read<CreateServiceBloc>().add(CreateService(blueprint));
            SuccessNotification(
              message: "Added Password Sucessfully",
              context: context,
            ).show(context);
            await Future.delayed(const Duration(seconds: 2));
            Navigator.of(context).popAndPushNamed("/");
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 65, 255, 65)),
          child: const Text("Submit"),
        )
      ],
    );
  }

  ServiceBlueprint _handleSubmssion(
      TextEditingController email,
      TextEditingController password,
      TextEditingController label,
      TextEditingController appname,
      TextEditingController url,
      PasswordManager passwordManager) {
    return ServiceBlueprint(
        password.text.trim(),
        email.text.trim(),
        label.text.trim(),
        "",
        url.text.isNotEmpty ? "${url.text.trim()}/favicon.ico" : null,
        url.text.trim().isNotEmpty ? url.text.trim() : null,
        appname.text.trim().isNotEmpty ? appname.text.trim() : null);
  }
}
