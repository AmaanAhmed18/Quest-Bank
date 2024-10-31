import 'package:flutter/material.dart';
import 'package:quest_bank/pages/zip.dart';
import 'package:quest_bank/widget/widget_support.dart';
import 'package:quest_bank/widget/book_manager.dart';

class BookMark extends StatefulWidget {
  final bool showBackButton;

  const BookMark({super.key, required this.showBackButton});

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 28),
              child: Row(
                children: [
                  if (widget.showBackButton)
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 34,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  Text(
                    'Bookmarks',
                    style: AppWidget.bookTextFieldStyle(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<List<Bookmark>>(
                valueListenable: BookmarkManager.bookmarksNotifier,
                builder: (context, bookmarks, _) {
                  if (bookmarks.isEmpty) {
                    return Center(
                      child: Text(
                        'No bookmarks added',
                        style: AppWidget.LightTextFieldStyle(),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: bookmarks.length,
                    itemBuilder: (context, index) {
                      Bookmark bookmark = bookmarks[index];
                      return BookmarkItem(
                        bookmark: bookmark,
                        ZipFilePage: ZipFilePage,
                        );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookmarkItem extends StatelessWidget {
  final Bookmark bookmark;
  final ZipFilePage;

  const BookmarkItem({super.key, required this.bookmark, required this.ZipFilePage});

  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      // onTap: (){
      //           Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => ZipFilePage(
      //         examName: bookmark.exam,
      //         subjects: [bookmark.subject], 
      //         subjects12: [], 
      //         Selectedsubject: bookmark.subject,
      //         Selectedsubject12: '',
      //       ),
      //     ),
      //   );
      // },
      child: Container(
        // height: 150,
        height: MediaQuery.of(context).size.height / 6,
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 14),
              height: MediaQuery.of(context).size.height / 7,
              width: MediaQuery.of(context).size.height / 7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(bookmark.icon, size: 50, color: Color(0Xff0c9cc8)),
                    SizedBox(height: 10),
                    Text(
                      bookmark.exam,
                      style: AppWidget.boldTextFieldStyle(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 30),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 55, left: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bookmark.subject,
                      style: AppWidget.book1TextFieldStyle(),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment(1.0, -1.0),
              child: IconButton(
                icon: Icon(
                  Icons.delete_rounded,
                  size: 24,
                  color: const Color.fromARGB(255, 106, 106, 106),
                ),
                onPressed: () {
                  BookmarkManager.removeBookmark(
                      bookmark.subject, bookmark.exam, bookmark.icon);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
