import 'package:bloc/bloc.dart';
import 'package:ladon/features/passwordManager/bloc/states/ViewPasswordStates.dart';
import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';
import 'package:ladon/features/passwordManager/interfaces/PasswordManagerInterface.dart';

import '../../welcome/logic/setup.dart';
import '../logic/PasswordManager.dart';
import 'events/ViewPasswordEvents.dart';

class ViewPasswordBloc extends Bloc<ViewPasswordEvent, ViewPasswordState> {
  final PasswordManagerInterface _passwordManager = PasswordManager();
  List<ServiceBlueprint> blueprints = [];
  ViewPasswordBloc() : super(InitialViewPasswordState()) {
    on((event, emit) async {
      if (event is GetPasswords) {
        List<ServiceBlueprint> services = await _passwordManager.getPasswords();
        services.sort((a, b) => a.label.compareTo(b.label));
        blueprints = services;
        emit(HasPasswords(services));
      } else if (state is RefreshPasswords) {
        List<ServiceBlueprint> services = await _passwordManager.getPasswords();
        services.sort((a, b) => a.label.compareTo(b.label));
        blueprints = services;
        emit(HasPasswords(services));
      } else if (event is SearchPasswords) {
        List<ServiceBlueprint> matchingBlueprints = blueprints
            .where((element) =>
                element.label.toLowerCase().contains(event.query.toLowerCase()))
            .toList();
        emit(HasPasswords(matchingBlueprints));
      } else if (event is Setup) {
        List resp = await setup();
        if (resp[1] == true) {
          emit(RedirectToWelcome(resp.first));
        } else {
          add(GetPasswords());
        }
      }
    });
  }
}
