import 'package:week_1/models/bible_book_model.dart';

final List<BibleBook> dummyBibleBooks = [
  const BibleBook(id: 1, name: 'Genesis', chapterCount: 50, testament: 'OT'),
  const BibleBook(id: 2, name: 'Exodus', chapterCount: 40, testament: 'OT'),
  const BibleBook(id: 3, name: 'Leviticus', chapterCount: 27, testament: 'OT'),
  const BibleBook(id: 4, name: 'Numbers', chapterCount: 36, testament: 'OT'),
  const BibleBook(id: 5, name: 'Deuteronomy', chapterCount: 34, testament: 'OT'),
  const BibleBook(id: 40, name: 'Matthew', chapterCount: 28, testament: 'NT'),
  const BibleBook(id: 41, name: 'Mark', chapterCount: 16, testament: 'NT'),
  const BibleBook(id: 42, name: 'Luke', chapterCount: 24, testament: 'NT'),
  const BibleBook(id: 43, name: 'John', chapterCount: 21, testament: 'NT'),
];

final Map<int, Map<int, List<Verse>>> dummyVersesByBookIdAndChapter = {
  1: {
    1: const [
      Verse(chapterNumber: 1, verseNumber: 1, text: 'In the beginning God created the heavens and the earth.'),
      Verse(chapterNumber: 1, verseNumber: 2, text: 'Now the earth was formless and empty, darkness was over the surface of the deep, and the Spirit of God was hovering over the waters.'),
      Verse(chapterNumber: 1, verseNumber: 3, text: 'And God said, “Let there be light,” and there was light.'),
      Verse(chapterNumber: 1, verseNumber: 4, text: 'God saw that the light was good, and he separated the light from the darkness.'),
      Verse(chapterNumber: 1, verseNumber: 5, text: 'God called the light “day,” and the darkness he called “night.” And there was evening, and there was morning—the first day.'),
    ],
  },
  2: {
    1: const [
      Verse(chapterNumber: 1, verseNumber: 1, text: 'These are the names of the sons of Israel who went to Egypt with Jacob, each with his family:'),
      Verse(chapterNumber: 1, verseNumber: 2, text: 'Reuben, Simeon, Levi and Judah;'),
      Verse(chapterNumber: 1, verseNumber: 3, text: 'Issachar, Zebulun and Benjamin;'),
    ],
  },
  40: {
    1: const [
      Verse(chapterNumber: 1, verseNumber: 1, text: 'This is the genealogy of Jesus the Messiah the son of David, the son of Abraham:'),
      Verse(chapterNumber: 1, verseNumber: 2, text: 'Abraham was the father of Isaac, Isaac the father of Jacob, Jacob the father of Judah and his brothers,'),
    ],
  },
};

List<Verse> getDummyVerses({required int bookId, required int chapterNumber}) {
  return dummyVersesByBookIdAndChapter[bookId]?[chapterNumber] ?? const <Verse>[];
}
