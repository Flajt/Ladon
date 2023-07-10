import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';

abstract class CreateServiceEvent {
  const CreateServiceEvent();
}

class CreateService extends CreateServiceEvent {
  final ServiceBlueprint serviceBlueprint;
  const CreateService(this.serviceBlueprint);

  @override
  List<Object> get props => [serviceBlueprint];
}

class DeleteService extends CreateServiceEvent {
  final ServiceBlueprint serviceBlueprint;
  const DeleteService(this.serviceBlueprint);

  @override
  List<Object> get props => [serviceBlueprint];
}
