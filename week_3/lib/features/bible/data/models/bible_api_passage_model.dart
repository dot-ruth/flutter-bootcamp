import '../../domain/entities/scripture_chapter.dart';

import 'bible_api_verse_model.dart';

class BibleApiPassageModel extends ScriptureChapter {
  const BibleApiPassageModel({
    required super.bookName,
    required super.chapterNumber,
    required super.reference,
    required super.verses,
  });

  factory BibleApiPassageModel.fromJson(Map<String, dynamic> json) {
    final reference = (json['reference'] as String?) ?? '';
    final versesJson = (json['verses'] as List<dynamic>? ?? const <dynamic>[]);

    String bookName = '';
    int chapterNumber = 0;
    if (versesJson.isNotEmpty && versesJson.first is Map<String, dynamic>) {
      final first = versesJson.first as Map<String, dynamic>;
      bookName = (first['book_name'] as String?) ?? '';
      chapterNumber = (first['chapter'] as num?)?.toInt() ?? 0;
    }

    return BibleApiPassageModel(
      bookName: bookName,
      chapterNumber: chapterNumber,
      reference: reference,
      verses: versesJson
          .whereType<Map<String, dynamic>>()
          .map(BibleApiVerseModel.fromJson)
          .toList(),
    );
  }
}
