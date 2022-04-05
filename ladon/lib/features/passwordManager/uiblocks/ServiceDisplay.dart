import 'package:flutter/material.dart';
import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';
import 'package:ladon/features/passwordManager/uiblocks/ServiceTile.dart';

class ServiceDisplay extends StatelessWidget {
  const ServiceDisplay({Key? key, required this.services}) : super(key: key);
  final List<ServiceBlueprint> services;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) =>
            ServiceTile(blueprint: services[index]));
  }
}
