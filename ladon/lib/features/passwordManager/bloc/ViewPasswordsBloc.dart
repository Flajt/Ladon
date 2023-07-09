import 'package:bloc/bloc.dart';
import 'package:ladon/features/passwordManager/bloc/states/ViewPasswordStates.dart';
import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';
import 'package:ladon/features/passwordManager/interfaces/PasswordManagerInterface.dart';

import '../logic/PasswordManager.dart';
import 'events/ViewPasswordEvents.dart';

class ViewPasswordBloc extends Bloc<ViewPasswordEvent, ViewPasswordState> {
  final PasswordManagerInterface _passwordManager = PasswordManager();
  ViewPasswordBloc() : super(InitialViewPasswordState()) {
    on((event, emit) async {
      if (event is GetPasswords) {
        List<ServiceBlueprint> services = await _passwordManager.getPasswords();
        emit(HasPasswords(services));
      } else if (state is RefreshPasswords) {
        List<ServiceBlueprint> services = await _passwordManager.getPasswords();
        emit(HasPasswords(services));
      }
    });
  }
}
