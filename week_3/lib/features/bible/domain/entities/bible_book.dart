import 'package:equatable/equatable.dart';

class BibleBook extends Equatable {
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

  @override
  List<Object?> get props => [id, name, chapterCount, testament];
}
