import '../../domain/entities/verse.dart';

class BibleSuperSearchVerseModel extends Verse {
  const BibleSuperSearchVerseModel({
    required super.reference,
    required super.text,
  });

  factory BibleSuperSearchVerseModel.fromMinimalJson(
    Map<String, dynamic> json, {
    required String bookName,
  }) {
    final chapter = (json['chapter'] as String?) ?? (json['chapter'] as num?)?.toInt().toString() ?? '';
    final verse = (json['verse'] as String?) ?? (json['verse'] as num?)?.toInt().toString() ?? '';

    final reference = (chapter.isEmpty || verse.isEmpty) ? bookName : '$bookName $chapter:$verse';

    return BibleSuperSearchVerseModel(
      reference: reference,
      text: ((json['text'] as String?) ?? '').trim(),
    );
  }
}
