import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/scripture_chapter.dart';
import '../repositories/bible_repository.dart';

class GetChapterVersesUseCase {
  final BibleRepository repository;

  const GetChapterVersesUseCase(this.repository);

  Future<Either<Failure, ScriptureChapter>> call({
    required String bookName,
    required int chapterNumber,
  }) {
    return repository.getChapterVerses(
      bookName: bookName,
      chapterNumber: chapterNumber,
    );
  }
}
