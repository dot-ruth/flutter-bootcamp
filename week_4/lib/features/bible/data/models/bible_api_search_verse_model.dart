import '../../domain/entities/verse.dart';

class BibleApiSearchVerseModel extends Verse {
  const BibleApiSearchVerseModel({
    required super.reference,
    required super.text,
  });

  factory BibleApiSearchVerseModel.fromJson(Map<String, dynamic> json) {
    final bookName = (json['book_name'] as String?) ?? '';
    final chapter = (json['chapter'] as num?)?.toInt();
    final verse = (json['verse'] as num?)?.toInt();

    final chapterPart = chapter == null ? '' : '$chapter';
    final versePart = verse == null ? '' : '$verse';

    final reference = (bookName.isEmpty || chapterPart.isEmpty || versePart.isEmpty)
        ? (json['reference'] as String?) ?? ''
        : '$bookName $chapterPart:$versePart';

    return BibleApiSearchVerseModel(
      reference: reference,
      text: ((json['text'] as String?) ?? '').trim(),
    );
  }
}
