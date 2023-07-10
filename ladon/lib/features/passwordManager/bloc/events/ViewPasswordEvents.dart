import 'package:flutter/material.dart';

abstract class ViewPasswordEvent {}

class GetPasswords extends ViewPasswordEvent {}

class RefreshPasswords extends ViewPasswordEvent {}

class SearchPasswords extends ViewPasswordEvent {
  final String query;
  SearchPasswords(this.query);
}

//TODO: Check for a better way
class Setup extends ViewPasswordEvent {}
