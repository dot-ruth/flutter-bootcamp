import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/bible_book.dart';
import '../../domain/usecases/get_bible_books_use_case.dart';
import 'bible_providers.dart';

typedef BibleBooksEither = Either<Failure, List<BibleBook>>;

class BibleBooksState {
  final bool isLoading;
  final List<BibleBook> books;
  final String? errorMessage;

  const BibleBooksState({
    required this.isLoading,
    required this.books,
    required this.errorMessage,
  });

  factory BibleBooksState.initial() {
    return const BibleBooksState(
      isLoading: false,
      books: <BibleBook>[],
      errorMessage: null,
    );
  }

  BibleBooksState copyWith({
    bool? isLoading,
    List<BibleBook>? books,
    String? errorMessage,
  }) {
    return BibleBooksState(
      isLoading: isLoading ?? this.isLoading,
      books: books ?? this.books,
      errorMessage: errorMessage,
    );
  }
}

class BibleBooksNotifier extends StateNotifier<BibleBooksState> {
  final GetBibleBooksUseCase _useCase;

  BibleBooksNotifier(this._useCase) : super(BibleBooksState.initial()) {
    load();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final BibleBooksEither result = await _useCase();
    result.fold(
      (l) => state = state.copyWith(isLoading: false, errorMessage: l.message),
      (r) => state = state.copyWith(isLoading: false, books: r, errorMessage: null),
    );
  }
}

final bibleBooksProvider = StateNotifierProvider<BibleBooksNotifier, BibleBooksState>((ref) {
  return BibleBooksNotifier(ref.read(getBibleBooksUseCaseProvider));
});
