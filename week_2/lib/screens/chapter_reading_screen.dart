import 'package:flutter/material.dart';
 
import '../models/bible_book_model.dart';
import '../services/bible_service.dart';
 
class ChapterReadingScreen extends StatefulWidget {
  final BibleBook book;
  final int chapterNumber;
 
  const ChapterReadingScreen({
    super.key,
    required this.book,
    required this.chapterNumber,
  });
 
  @override
  State<ChapterReadingScreen> createState() => _ChapterReadingScreenState();
}

class _ChapterReadingScreenState extends State<ChapterReadingScreen> {
  final BibleService _service = BibleService();
  late Future<BiblePassage> _future;
  late String _query;

  @override
  void initState() {
    super.initState();
    _query = '${widget.book.name} ${widget.chapterNumber}';
    _future = _service.fetchPassage(_query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.book.name} ${widget.chapterNumber}'),
        centerTitle: true,
      ),
      body: FutureBuilder<BiblePassage>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Failed to load passage.',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${snapshot.error}',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _future = _service.fetchPassage(_query);
                        });
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final passage = snapshot.data;
          if (passage == null) {
            return const Center(child: Text('No data'));
          }

          final verses = passage.verses;

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            itemCount: verses.length + 1,
            separatorBuilder: (context, index) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Text(
                  passage.reference.isNotEmpty ? passage.reference : _query,
                  style: Theme.of(context).textTheme.titleLarge,
                );
              }

              final Verse verse = verses[index - 1];
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
