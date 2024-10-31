import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bookmark {
  final String subject;
  final String exam;
  final IconData icon;

  Bookmark({
    required this.subject,
    required this.exam,
    required this.icon,
  });
}

class BookmarkManager {
  static final ValueNotifier<List<Bookmark>> bookmarksNotifier = ValueNotifier<List<Bookmark>>([]);

  static List<Bookmark> getBookmarks() {
    return List.unmodifiable(bookmarksNotifier.value);
  }

  static void addBookmark(String subject, String exam, IconData icon) {
    if (subject.isNotEmpty && exam.isNotEmpty &&
        !bookmarksNotifier.value.any((bookmark) =>
            bookmark.subject == subject && bookmark.exam == exam && bookmark.icon == icon)) {
      bookmarksNotifier.value = [
        ...bookmarksNotifier.value,
        Bookmark(subject: subject, exam: exam, icon: icon),
      ];
    }
  }

  static void removeBookmark(String subject, String exam, IconData icon) {
    bookmarksNotifier.value = bookmarksNotifier.value
        .where((bookmark) => !(bookmark.subject == subject && bookmark.exam == exam && bookmark.icon == icon))
        .toList();
  }
}

