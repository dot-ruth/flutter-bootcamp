import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/verse.dart';
import '../../domain/usecases/search_verses_use_case.dart';
import 'bible_providers.dart';

typedef SearchEither = Either<Failure, List<Verse>>;

class VerseSearchState {
  final bool isLoading;
  final List<Verse> results;
  final String? errorMessage;
  final String query;

  const VerseSearchState({
    required this.isLoading,
    required this.results,
    required this.errorMessage,
    required this.query,
  });

  factory VerseSearchState.initial() {
    return const VerseSearchState(
      isLoading: false,
      results: <Verse>[],
      errorMessage: null,
      query: '',
    );
  }

  VerseSearchState copyWith({
    bool? isLoading,
    List<Verse>? results,
    String? errorMessage,
    String? query,
  }) {
    return VerseSearchState(
      isLoading: isLoading ?? this.isLoading,
      results: results ?? this.results,
      errorMessage: errorMessage,
      query: query ?? this.query,
    );
  }
}

class VerseSearchNotifier extends StateNotifier<VerseSearchState> {
  final SearchVersesUseCase _useCase;

  final PublishSubject<String> _querySubject = PublishSubject<String>();
  StreamSubscription<String>? _subscription;

  VerseSearchNotifier(this._useCase) : super(VerseSearchState.initial()) {
    _subscription = _querySubject
        .distinct()
        .debounceTime(const Duration(milliseconds: 450))
        .listen(search);
  }

  void onQueryChanged(String query) {
    state = state.copyWith(query: query, errorMessage: null);
    _querySubject.add(query);
  }

  Future<void> search(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      state = VerseSearchState.initial().copyWith(query: '');
      return;
    }

    if (trimmed.length < 2) {
      state = state.copyWith(isLoading: false, results: <Verse>[], errorMessage: null);
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    final SearchEither result = await _useCase(trimmed);
    result.fold(
      (l) => state = state.copyWith(isLoading: false, results: <Verse>[], errorMessage: l.message),
      (r) => state = state.copyWith(isLoading: false, results: r, errorMessage: null),
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _querySubject.close();
    super.dispose();
  }
}

final verseSearchProvider = StateNotifierProvider<VerseSearchNotifier, VerseSearchState>((ref) {
  return VerseSearchNotifier(ref.read(searchVersesUseCaseProvider));
});
