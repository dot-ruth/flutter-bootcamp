import 'package:dio/dio.dart';

import '../models/bible_book_model.dart';

class BibleService {
  final Dio _dio;

  BibleService({Dio? dio}) : _dio = dio ?? Dio();

  Future<BiblePassage> fetchPassage(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError('Query cannot be empty');
    }

    final encoded = Uri.encodeComponent(trimmed);
    final url = 'https://bible-api.com/$encoded';

    final response = await _dio.get(url);
    return BiblePassage.fromJson(response.data as Map<String, dynamic>);
  }
}
