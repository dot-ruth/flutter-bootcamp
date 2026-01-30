import '../../domain/entities/scripture_verse.dart';

class BibleApiVerseModel extends ScriptureVerse {
  const BibleApiVerseModel({
    required super.verseNumber,
    required super.text,
  });

  factory BibleApiVerseModel.fromJson(Map<String, dynamic> json) {
    return BibleApiVerseModel(
      verseNumber: (json['verse'] as num).toInt(),
      text: (json['text'] as String).trim(),
    );
  }
}
