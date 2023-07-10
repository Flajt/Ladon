import 'package:bloc/bloc.dart';
import 'package:ladon/features/passwordManager/bloc/events/CreateServiceEvents.dart';
import 'package:ladon/features/passwordManager/bloc/states/CreateServiceStates.dart';
import 'package:ladon/features/passwordManager/interfaces/PasswordManagerInterface.dart';
import 'package:ladon/features/passwordManager/logic/PasswordManager.dart';

class CreateServiceBloc extends Bloc<CreateServiceEvent, CreateServiceState> {
  CreateServiceBloc() : super(const CreateServiceInitial()) {
    PasswordManagerInterface pwManager = PasswordManager();
    on<DeleteService>((event, emit) async {
      try {
        await pwManager.deletePassword(event.serviceBlueprint);
        emit(HasDeletedService());
      } catch (e) {
        emit(HasError(e.toString()));
      }
    });
    on<CreateService>((event, emit) async {
      try {
        await pwManager.savePassword(event.serviceBlueprint);
        emit(HasCreatedService());
      } catch (e) {
        emit(HasError(e.toString()));
      }
    });
  }
}
