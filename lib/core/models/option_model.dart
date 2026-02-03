import 'package:flutter/material.dart';

typedef TitleBuilder = String Function(BuildContext context);

class OptionModel {
  final TitleBuilder titleBuilder;
  final String fragment;
  final NavigationType navigationType;
  final List<OptionModel> options;

  OptionModel({required this.titleBuilder, required this.fragment, this.navigationType = NavigationType.route, this.options = const []});

  String getTitle(BuildContext context) => titleBuilder(context);
}

enum NavigationType { route, scroll }
