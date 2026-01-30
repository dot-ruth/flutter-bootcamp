import 'package:dio/dio.dart';

import '../models/bible_api_passage_model.dart';

abstract class BibleRemoteDataSource {
  Future<BibleApiPassageModel> getChapter({
    required String bookName,
    required int chapterNumber,
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
}
