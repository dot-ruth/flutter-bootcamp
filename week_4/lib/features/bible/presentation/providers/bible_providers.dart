import 'package:bible_api_app/features/bible/data/data_sources/book_catalog_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data_sources/bible_remote_data_source.dart';
import '../../data/repositories/bible_repository_impl.dart';
import '../../domain/repositories/bible_repository.dart';
import '../../domain/usecases/get_bible_books_use_case.dart';
import '../../domain/usecases/get_chapter_verses_use_case.dart';
import '../../domain/usecases/search_verses_use_case.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final bibleRemoteDataSourceProvider = Provider<BibleRemoteDataSource>((ref) {
  return BibleRemoteDataSourceImpl(ref.read(dioProvider));
});

final bookCatalogDataSourceProvider = Provider<BookCatalogDataSource>((ref) {
  return BookCatalogDataSourceImpl();
});

final bibleRepositoryProvider = Provider<BibleRepository>((ref) {
  return BibleRepositoryImpl(
    remoteDataSource: ref.read(bibleRemoteDataSourceProvider),
    bookCatalogDataSource: ref.read(bookCatalogDataSourceProvider),
  );
});

final getBibleBooksUseCaseProvider = Provider<GetBibleBooksUseCase>((ref) {
  return GetBibleBooksUseCase(ref.read(bibleRepositoryProvider));
});

final getChapterVersesUseCaseProvider = Provider<GetChapterVersesUseCase>((ref) {
  return GetChapterVersesUseCase(ref.read(bibleRepositoryProvider));
});

final searchVersesUseCaseProvider = Provider<SearchVersesUseCase>((ref) {
  return SearchVersesUseCase(ref.read(bibleRepositoryProvider));
});
