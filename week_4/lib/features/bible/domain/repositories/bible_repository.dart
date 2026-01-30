import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/bible_book.dart';
import '../entities/scripture_chapter.dart';
import '../entities/verse.dart';

abstract class BibleRepository {
  Future<Either<Failure, List<BibleBook>>> getBibleBooks();

  Future<Either<Failure, ScriptureChapter>> getChapterVerses({
    required String bookName,
    required int chapterNumber,
  });

  Future<Either<Failure, List<Verse>>> searchVerses(String query);
}
