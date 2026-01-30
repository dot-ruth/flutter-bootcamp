import 'package:equatable/equatable.dart';

class ScriptureVerse extends Equatable {
  final int verseNumber;
  final String text;

  const ScriptureVerse({
    required this.verseNumber,
    required this.text,
  });

  @override
  List<Object?> get props => [verseNumber, text];
}
