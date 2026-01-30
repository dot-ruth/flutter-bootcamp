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
  final String? bookName;

  const Verse({
    required this.chapterNumber,
    required this.verseNumber,
    required this.text,
    this.bookName,
  });

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      chapterNumber: (json['chapter'] as num).toInt(),
      verseNumber: (json['verse'] as num).toInt(),
      text: (json['text'] as String).trim(),
      bookName: json['book_name'] as String?,
    );
  }
}

class BiblePassage {
  final String reference;
  final String text;
  final String translationId;
  final String translationName;
  final String translationNote;
  final List<Verse> verses;

  const BiblePassage({
    required this.reference,
    required this.text,
    required this.translationId,
    required this.translationName,
    required this.translationNote,
    required this.verses,
  });

  factory BiblePassage.fromJson(Map<String, dynamic> json) {
    final versesJson = (json['verses'] as List<dynamic>? ?? const <dynamic>[]);

    return BiblePassage(
      reference: (json['reference'] as String?) ?? '',
      text: (json['text'] as String?) ?? '',
      translationId: (json['translation_id'] as String?) ?? '',
      translationName: (json['translation_name'] as String?) ?? '',
      translationNote: (json['translation_note'] as String?) ?? '',
      verses: versesJson
          .whereType<Map<String, dynamic>>()
          .map(Verse.fromJson)
          .toList(),
    );
  }
}
