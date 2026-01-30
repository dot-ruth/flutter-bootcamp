import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/verse.dart';
import '../providers/verse_search_notifier.dart';

class VerseSearchPage extends ConsumerWidget {
  const VerseSearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(verseSearchProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: ref.read(verseSearchProvider.notifier).onQueryChanged,
              decoration: const InputDecoration(
                hintText: 'Search for a verse or topic...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Builder(
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
                            'Search failed.',
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.errorMessage!,
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (state.query.trim().isNotEmpty && state.results.isEmpty) {
                  return const Center(child: Text('No results found'));
                }

                if (state.query.trim().isEmpty) {
                  return const Center(child: Text('Start typing to search'));
                }

                final results = state.results;
                return ListView.separated(
                  itemCount: results.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final Verse verse = results[index];
                    return ListTile(
                      title: Text(verse.reference.isEmpty ? 'Verse' : verse.reference),
                      subtitle: Text(
                        verse.text,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
