import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/scripture_verse.dart';
import '../providers/chapter_notifier.dart';

class ChapterReadingPage extends ConsumerWidget {
  final String bookName;
  final int chapterNumber;

  const ChapterReadingPage({
    super.key,
    required this.bookName,
    required this.chapterNumber,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ChapterArgs(bookName: bookName, chapterNumber: chapterNumber);
    final state = ref.watch(chapterProvider(args));

    return Scaffold(
      appBar: AppBar(
        title: Text('$bookName $chapterNumber'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => ref.read(chapterProvider(args).notifier).load(),
            icon: const Icon(Icons.refresh),
          ),
        ],
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
                      'Failed to load chapter.',
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
                      onPressed: () => ref.read(chapterProvider(args).notifier).load(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final chapter = state.chapter;
          if (chapter == null) {
            return const Center(child: Text('No data'));
          }

          final verses = chapter.verses;

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            itemCount: verses.length + 1,
            separatorBuilder: (context, index) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Text(
                  chapter.reference.isNotEmpty ? chapter.reference : '$bookName $chapterNumber',
                  style: Theme.of(context).textTheme.titleLarge,
                );
              }

              final ScriptureVerse verse = verses[index - 1];
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
          );
        },
      ),
    );
  }
}
