class OptionModel {
  final String title;
  final String fragment;
  final List<OptionModel> options;

  OptionModel({required this.title, required this.fragment, this.options = const []});
}
