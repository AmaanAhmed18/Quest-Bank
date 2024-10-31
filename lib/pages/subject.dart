import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:quest_bank/pages/bookmark.dart';
import 'package:quest_bank/pages/bottomnav.dart';
import 'package:quest_bank/pages/home.dart';
import 'package:quest_bank/pages/profile.dart';
import 'package:quest_bank/pages/filter.dart';
import 'package:quest_bank/pages/zip.dart';
import 'package:quest_bank/widget/widget_support.dart';

class SubjectsPage extends StatefulWidget {
  final String examName;
  final List<String> subjects;
  final List<String> subjects12;
  final String description1;
  final String description2;
  final String description3;
  final String description4;

  SubjectsPage({
    required this.examName,
    required this.subjects,
    required this.subjects12,
    required this.description1,
    required this.description2,
    required this.description3,
    required this.description4,
  });

  @override
  State<SubjectsPage> createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool showSecondContainer = widget.examName == 'CBSE' ||
        widget.examName == 'JEE' ||
        widget.examName == 'ICSE';

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 38, left: 18, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  iconSize: 34,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  widget.examName,
                  style: AppWidget.bookTextFieldStyle(),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.description1,
                          style: AppWidget.subTextFieldStyle(),
                        ),
                        Text(
                          widget.description2,
                          style: AppWidget.yearTextFieldStyle(),
                        ),
                      ],
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 2,
                        ),
                        itemCount: widget.subjects.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (widget.subjects[index] == 'More') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FilterPage()),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ZipFilePage(
                                      examName: widget.examName,
                                      level: '',
                                      subjects: widget.subjects,
                                      subjects12: widget.subjects12,
                                      Selectedsubject: widget.subjects[index],
                                      Selectedsubject12: '',
                                      description1: widget.description1,
                                      description3: widget.description3,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.subjects[index],
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: MediaQuery.of(context).size.height / 16,
        color: Color(0Xff0c9cc8),
        backgroundColor: Color(0XffFAFAFA),
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BottomNav()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookMark(showBackButton: true)),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Profile(showBackButton: true)),
              );
            }
          });
        },
        items: [
          Icon(Icons.home_filled, color: Colors.white, size: 28),
          Icon(Icons.bookmark_rounded, color: Colors.white, size: 28),
          Icon(Icons.person_4_rounded, color: Colors.white, size: 28),
        ],
      ),
    );
  }
}
