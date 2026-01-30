import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/scripture_chapter.dart';
import '../../domain/usecases/get_chapter_verses_use_case.dart';
import 'bible_providers.dart';

typedef ChapterEither = Either<Failure, ScriptureChapter>;

class ChapterState {
  final bool isLoading;
  final ScriptureChapter? chapter;
  final String? errorMessage;

  const ChapterState({
    required this.isLoading,
    required this.chapter,
    required this.errorMessage,
  });

  factory ChapterState.initial() {
    return const ChapterState(
      isLoading: false,
      chapter: null,
      errorMessage: null,
    );
  }

  ChapterState copyWith({
    bool? isLoading,
    ScriptureChapter? chapter,
    String? errorMessage,
  }) {
    return ChapterState(
      isLoading: isLoading ?? this.isLoading,
      chapter: chapter ?? this.chapter,
      errorMessage: errorMessage,
    );
  }
}

class ChapterArgs extends Equatable{
  final String bookName;
  final int chapterNumber;

  const ChapterArgs({
    required this.bookName,
    required this.chapterNumber,
  });

  @override
  List<Object> get props => [bookName, chapterNumber];
}

class ChapterNotifier extends StateNotifier<ChapterState> {
  final GetChapterVersesUseCase _useCase;
  final ChapterArgs args;

  ChapterNotifier(this._useCase, this.args) : super(ChapterState.initial()) {
    load();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final ChapterEither result = await _useCase(
      bookName: args.bookName,
      chapterNumber: args.chapterNumber,
    );

    result.fold(
      (l) => state = state.copyWith(isLoading: false, errorMessage: l.message),
      (r) => state = state.copyWith(isLoading: false, chapter: r, errorMessage: null),
    );
  }
}

final chapterProvider = StateNotifierProvider.family<ChapterNotifier, ChapterState, ChapterArgs>((ref, args) {
  return ChapterNotifier(ref.read(getChapterVersesUseCaseProvider), args);
});
