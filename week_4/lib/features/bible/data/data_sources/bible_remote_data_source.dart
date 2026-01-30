import 'package:dio/dio.dart';

import '../../domain/entities/verse.dart';
import '../models/bible_api_passage_model.dart';
import '../models/bible_api_search_verse_model.dart';
import '../models/bible_supersearch_verse_model.dart';

abstract class BibleRemoteDataSource {
  Future<BibleApiPassageModel> getChapter({
    required String bookName,
    required int chapterNumber,
  });

  Future<List<Verse>> searchVerses({
    required String query,
  });
}

class BibleRemoteDataSourceImpl implements BibleRemoteDataSource {
  final Dio dio;

  BibleRemoteDataSourceImpl(this.dio);

  @override
  Future<BibleApiPassageModel> getChapter({
    required String bookName,
    required int chapterNumber,
  }) async {
    final query = '$bookName $chapterNumber';
    final encoded = Uri.encodeComponent(query);
    final url = 'https://bible-api.com/$encoded';

    final response = await dio.get(url);
    return BibleApiPassageModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<Verse>> searchVerses({
    required String query,
  }) async {
    if (_looksLikeBibleReference(query)) {
      return _searchByReferenceWithBibleApi(query);
    }

    final response = await dio.get(
      'https://api.biblesupersearch.com/api',
      queryParameters: {
        'bible': 'web',
        'search': query,
        'format': 'passage',
      },
    );

    final data = response.data as Map<String, dynamic>;
    final results = data['results'];

    if (results is List) {
      final out = <Verse>[];

      for (final item in results) {
        if (item is! Map<String, dynamic>) continue;

        final bookName = (item['book_name'] as String?) ?? '';
        final versesByBible = item['verses'];
        if (versesByBible is! Map) continue;

        final bibleVerses = versesByBible['web'] ?? (versesByBible.values.isNotEmpty ? versesByBible.values.first : null);
        if (bibleVerses is! Map) continue;

        for (final chapterEntry in bibleVerses.entries) {
          final chapterKey = chapterEntry.key;
          final chapterMap = chapterEntry.value;
          if (chapterMap is! Map) continue;

          for (final verseEntry in chapterMap.entries) {
            final verseKey = verseEntry.key;
            final verseValue = verseEntry.value;

            String text = '';
            if (verseValue is Map && verseValue['text'] is String) {
              text = (verseValue['text'] as String).trim();
            } else if (verseValue is String) {
              text = verseValue.trim();
            }

            if (text.isEmpty) continue;

            out.add(
              BibleSuperSearchVerseModel(
                reference: (bookName.isEmpty) ? '$chapterKey:$verseKey' : '$bookName $chapterKey:$verseKey',
                text: text,
              ),
            );
          }
        }
      }

      return out;
    }

    final out = <Verse>[];

    if (results is Map && results['web'] is List) {
      for (final item in (results['web'] as List)) {
        if (item is! Map<String, dynamic>) continue;
        out.add(
          BibleSuperSearchVerseModel.fromMinimalJson(
            item,
            bookName: (item['book_name'] as String?) ?? (item['book'] as String?) ?? '',
          ),
        );
      }
    }

    return out;
  }

  bool _looksLikeBibleReference(String query) {
    final q = query.trim();
    if (q.isEmpty) return false;

    final hasNumber = RegExp(r'\d').hasMatch(q);
    if (!hasNumber) return false;

    if (q.contains(':')) return true;

    return RegExp(r'^\s*(?:[1-3]\s*)?[A-Za-z]{2,}\s+\d+\s*$').hasMatch(q);
  }

  Future<List<Verse>> _searchByReferenceWithBibleApi(String query) async {
    final encoded = Uri.encodeComponent(query.trim());
    final url = 'https://bible-api.com/$encoded';

    final response = await dio.get(url);
    final data = response.data as Map<String, dynamic>;
    final versesJson = (data['verses'] as List<dynamic>? ?? const <dynamic>[]);

    return versesJson
        .whereType<Map<String, dynamic>>()
        .map(BibleApiSearchVerseModel.fromJson)
        .toList();
  }
}
