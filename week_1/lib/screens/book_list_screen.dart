import 'package:flutter/material.dart';
import 'package:week_1/models/bible_book_model.dart';

import '../models/dummy_data.dart';
import 'chapter_reading_screen.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bible Reader'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: dummyBibleBooks.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final BibleBook book = dummyBibleBooks[index];

          return ListTile(
            title: Text(
              book.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text('${book.testament} • ${book.chapterCount} chapters'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ChapterReadingScreen(
                    book: book,
                    chapterNumber: 1,
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
