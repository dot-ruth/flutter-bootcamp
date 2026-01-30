import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/verse.dart';
import '../repositories/bible_repository.dart';

class SearchVersesUseCase {
  final BibleRepository repository;

  const SearchVersesUseCase(this.repository);

  Future<Either<Failure, List<Verse>>> call(String query) {
    return repository.searchVerses(query);
  }
}
