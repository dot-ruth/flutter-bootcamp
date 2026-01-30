import 'package:flutter/material.dart';

import '../models/bible_book_model.dart';
import 'chapter_reading_screen.dart';

class ChapterListScreen extends StatelessWidget {
  final BibleBook book;

  const ChapterListScreen({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: book.chapterCount,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final chapterNumber = index + 1;

          return ListTile(
            title: Text('Chapter $chapterNumber'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ChapterReadingScreen(
                    book: book,
                    chapterNumber: chapterNumber,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
