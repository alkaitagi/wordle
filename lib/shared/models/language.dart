class Language {
  const Language({
    required this.name,
    this.flag,
    required this.words,
    required this.layout,
  });

  final String name;
  final String? flag;
  final List<String> words;
  final List<String> layout;
}
