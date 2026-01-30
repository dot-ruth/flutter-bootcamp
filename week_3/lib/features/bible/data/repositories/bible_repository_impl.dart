import 'package:bible_api_app/features/bible/data/data_sources/book_catalog_data_source.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/bible_book.dart';
import '../../domain/entities/scripture_chapter.dart';
import '../../domain/repositories/bible_repository.dart';
import '../data_sources/bible_remote_data_source.dart';

class BibleRepositoryImpl implements BibleRepository {
  final BibleRemoteDataSource remoteDataSource;
  final BookCatalogDataSource bookCatalogDataSource;

  BibleRepositoryImpl({
    required this.remoteDataSource,
    required this.bookCatalogDataSource,
  });

  @override
  Future<Either<Failure, List<BibleBook>>> getBibleBooks() async {
    try {
      final books = bookCatalogDataSource.getBooks();
      return Right(books);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ScriptureChapter>> getChapterVerses({
    required String bookName,
    required int chapterNumber,
  }) async {
    try {
      final chapter = await remoteDataSource.getChapter(
        bookName: bookName,
        chapterNumber: chapterNumber,
      );
      return Right(chapter);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
