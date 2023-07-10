abstract class CreateServiceState {
  const CreateServiceState();
}

class CreateServiceInitial extends CreateServiceState {
  const CreateServiceInitial();
}

class HasError extends CreateServiceState {
  final String message;

  const HasError(this.message);
}

class HasCreatedService extends CreateServiceState {}

class HasDeletedService extends CreateServiceState {}
