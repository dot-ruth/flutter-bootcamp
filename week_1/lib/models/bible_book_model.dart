class BibleBook {
  final int id;
  final String name;
  final int chapterCount;
  final String testament;

  const BibleBook({
    required this.id,
    required this.name,
    required this.chapterCount,
    required this.testament,
  });
}

class Verse {
  final int chapterNumber;
  final int verseNumber;
  final String text;

  const Verse({
    required this.chapterNumber,
    required this.verseNumber,
    required this.text,
  });
}
