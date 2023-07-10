import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ladon/features/passwordGeneration/bloc/states/PasswordGeneratorState.dart';

import '../features/passwordGeneration/bloc/PasswordGeneratorBloc.dart';
import '../features/passwordGeneration/bloc/events/PasswordGenerationEvents.dart';
import '../features/passwordGeneration/uiblocks/PasswordPartSelector.dart';

class PasswordGenerationPage extends StatelessWidget {
  const PasswordGenerationPage({super.key});

  @override
  Widget build(BuildContext context) {
    HasChangedPWRequirement prevState =
        HasChangedPWRequirement(8, true, true, true, true);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: SizedBox(
      width: size.width,
      height: size.height,
      child: BlocBuilder<PasswordGeneratorBloc, PasswordGenerationState>(
          builder: (context, state) {
        if (state is HasChangedPWRequirement) {
          prevState = state;
        }
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Title(
                  color: Theme.of(context).primaryColor,
                  child: const Text(
                    "Password Generation",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state is HasGeneratedPassword
                        ? state.generatedPassword
                        : "No Password Generated",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        overflow: TextOverflow.ellipsis),
                  ),
                  IconButton(
                      onPressed: () => Clipboard.setData(ClipboardData(
                          text: state is HasGeneratedPassword
                              ? state.generatedPassword
                              : "No Password Generated")),
                      icon: const Icon(
                        Icons.copy,
                        semanticLabel: "Copy Password",
                      ))
                ],
              ),
              SizedBox(
                  width: size.width * .8,
                  child: Slider(
                      label: state is HasChangedPWRequirement
                          ? state.passwordLength.toString()
                          : prevState.passwordLength.toString(),
                      max: 30,
                      min: 8,
                      divisions: 22,
                      value: state is HasChangedPWRequirement
                          ? state.passwordLength.toDouble()
                          : prevState.passwordLength.toDouble(),
                      onChanged: (newValue) => context
                          .read<PasswordGeneratorBloc>()
                          .add(ChangePasswordLength(newValue.toInt())))),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                PasswordPartSelector(
                    text: "Numbers",
                    initalValue: state is HasChangedPWRequirement
                        ? state.numbers
                        : prevState.numbers,
                    onChanged: (newValue) => context
                        .read<PasswordGeneratorBloc>()
                        .add(EnableNumbers(newValue ?? true))),
                PasswordPartSelector(
                    text: "Special Chars",
                    initalValue: state is HasChangedPWRequirement
                        ? state.specialChar
                        : prevState.specialChar,
                    onChanged: (newValue) => context
                        .read<PasswordGeneratorBloc>()
                        .add(EnableSpecialCharacters(newValue ?? true))),
                PasswordPartSelector(
                    text: "Uppercase",
                    initalValue: state is HasChangedPWRequirement
                        ? state.uppercase
                        : prevState.uppercase,
                    onChanged: (newValue) => context
                        .read<PasswordGeneratorBloc>()
                        .add(EnableUppercase(newValue ?? true)))
              ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                    onPressed: () => context
                        .read<PasswordGeneratorBloc>()
                        .add(GeneratePassword()),
                    icon: const Icon(Icons.refresh),
                    label: const Text("Generate Password"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor)),
              ),
            ]);
      }),
    )));
  }
}
