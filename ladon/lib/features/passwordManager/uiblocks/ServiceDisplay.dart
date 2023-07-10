import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ladon/features/passwordManager/bloc/ViewPasswordsBloc.dart';
import 'package:ladon/features/passwordManager/uiblocks/ServiceTile.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../bloc/events/ViewPasswordEvents.dart';
import '../bloc/states/ViewPasswordStates.dart';

class ServiceDisplay extends StatelessWidget {
  const ServiceDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingSearchAppBar(
        alwaysOpened: true,
        automaticallyImplyBackButton: false,
        onQueryChanged: (query) =>
            context.read<ViewPasswordBloc>().add(SearchPasswords(query)),
        body: BlocBuilder<ViewPasswordBloc, ViewPasswordState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            if (state is HasPasswords && state.passwords.isNotEmpty) {
              return ListView.builder(
                  itemCount: state.passwords.length,
                  itemBuilder: ((context, index) =>
                      ServiceTile(blueprint: state.passwords[index])));
            } else {
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
            }
          },
        ));
  }
}
