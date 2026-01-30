import 'package:flutter/material.dart';

import '../../domain/entities/bible_book.dart';
import 'chapter_reading_page.dart';

class ChapterListPage extends StatelessWidget {
  final BibleBook book;

  const ChapterListPage({
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
                  builder: (_) => ChapterReadingPage(
                    bookName: book.name,
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
