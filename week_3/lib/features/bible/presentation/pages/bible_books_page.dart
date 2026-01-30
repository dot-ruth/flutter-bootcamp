import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/bible_book.dart';
import '../providers/bible_books_notifier.dart';
import 'chapter_list_page.dart';

class BibleBooksPage extends ConsumerWidget {
  const BibleBooksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bibleBooksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bible Books'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Failed to load books.',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.errorMessage!,
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => ref.read(bibleBooksProvider.notifier).load(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final books = state.books;

          return ListView.separated(
            itemCount: books.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final BibleBook book = books[index];

              return ListTile(
                title: Text(book.name),
                subtitle: Text('${book.testament} • ${book.chapterCount} chapters'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ChapterListPage(book: book),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
