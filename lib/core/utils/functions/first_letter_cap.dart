String formatText(String text) {
  String cleanedName = text.replaceAll(RegExp(r'\s+'), ' ').trim();
  List<String> words = cleanedName.split(' ');
  List<String> capitalizedWords = words.map((word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).toList();
  return capitalizedWords.join(' ');
}