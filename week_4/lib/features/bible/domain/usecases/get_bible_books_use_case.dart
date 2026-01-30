import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/bible_book.dart';
import '../repositories/bible_repository.dart';

class GetBibleBooksUseCase {
  final BibleRepository repository;

  const GetBibleBooksUseCase(this.repository);

  Future<Either<Failure, List<BibleBook>>> call() {
    return repository.getBibleBooks();
  }
}
