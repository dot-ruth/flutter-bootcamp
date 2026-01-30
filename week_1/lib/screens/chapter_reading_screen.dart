import 'package:flutter/material.dart';
import 'package:week_1/models/bible_book_model.dart';

import '../models/dummy_data.dart';

class ChapterReadingScreen extends StatelessWidget {
  final BibleBook book;
  final int chapterNumber;

  const ChapterReadingScreen({
    super.key,
    required this.book,
    required this.chapterNumber,
  });

  @override
  Widget build(BuildContext context) {
    final verses = getDummyVerses(bookId: book.id, chapterNumber: chapterNumber);

    return Scaffold(
      appBar: AppBar(
        title: Text('${book.name} $chapterNumber'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        itemCount: verses.length,
        separatorBuilder: (context, index) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final Verse verse = verses[index];

          return Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${verse.verseNumber} ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        height: 1.6,
                      ),
                ),
                TextSpan(
                  text: verse.text,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 18,
                        height: 1.6,
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
