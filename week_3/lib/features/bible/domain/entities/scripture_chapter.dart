import 'package:equatable/equatable.dart';

import 'scripture_verse.dart';

class ScriptureChapter extends Equatable {
  final String bookName;
  final int chapterNumber;
  final String reference;
  final List<ScriptureVerse> verses;

  const ScriptureChapter({
    required this.bookName,
    required this.chapterNumber,
    required this.reference,
    required this.verses,
  });

  @override
  List<Object?> get props => [bookName, chapterNumber, reference, verses];
}
