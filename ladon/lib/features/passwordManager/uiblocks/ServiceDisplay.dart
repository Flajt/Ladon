import 'package:flutter/material.dart';
import 'package:ladon/features/passwordManager/blueprints/ServiceBlueprint.dart';
import 'package:ladon/features/passwordManager/uiblocks/ServiceTile.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class ServiceDisplay extends StatefulWidget {
  const ServiceDisplay({Key? key, required this.services}) : super(key: key);
  final List<ServiceBlueprint> services;

  @override
  State<ServiceDisplay> createState() => _ServiceDisplayState();
}

class _ServiceDisplayState extends State<ServiceDisplay> {
  late List<ServiceBlueprint> blueprints;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    blueprints = widget.services;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingSearchAppBar(
        alwaysOpened: true,
        automaticallyImplyBackButton: false,
        onQueryChanged: (query) => setState(() {
              blueprints = widget.services
                  .where((element) => element.label.contains(query))
                  .toList();
            }),
        body: ListView.builder(
            itemCount: blueprints.length,
            itemBuilder: ((context, index) =>
                ServiceTile(blueprint: blueprints[index]))));
  }
}
