import 'package:flutter/material.dart';
import '../models/bible_book_model.dart';
import '../models/book_catalog.dart';
import 'chapter_list_screen.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bible Books'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: bibleBookCatalog.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final BibleBook book = bibleBookCatalog[index];
          return ListTile(
            title: Text(book.name),
            subtitle: Text('${book.testament} • ${book.chapterCount} chapters'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ChapterListScreen(book: book),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
