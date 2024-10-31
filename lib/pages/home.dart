import 'package:flutter/material.dart';
import 'package:quest_bank/pages/filter.dart';
import 'package:quest_bank/widget/widget_support.dart';
import 'package:quest_bank/pages/exam.dart';
import 'package:quest_bank/pages/subject.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _options = [
    'Math Class 12',
    'Physics Class 10',
    'Chemistry Class 12',
    'Biology Class 12',
    'History Class 10',
    'Geography Class 10',
    'English Class 10',
    'Economics Class 10',
    'Neet',
    'Cet',
    'Ncert',
    'Cat',
    'Cbse',
    'Icse'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 28, bottom: 10),
                    child: Image.asset(
                      "images/arodek-logo.png",
                      width: MediaQuery.of(context).size.height / 13.5,
                      height: MediaQuery.of(context).size.height / 16,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(),
                      child: Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text.isEmpty) {
                            return const Iterable<String>.empty();
                          }
                          return _options.where((String option) {
                            return option.toLowerCase().contains(
                                  textEditingValue.text.toLowerCase(),
                                );
                          });
                        },
                        onSelected: (String selection) {
                          print('You selected: $selection');
                        },
                        fieldViewBuilder: (context, controller, focusNode,
                            onEditingComplete) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 30, bottom: 10),
                            child: Material(
                              elevation: 0.5,
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                height: MediaQuery.of(context).size.height / 16,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextField(
                                  controller: controller,
                                  focusNode: focusNode,
                                  decoration: InputDecoration(
                                    hintText: 'Search',
                                    hintStyle:
                                        AppWidget.semiboldTextFieldStyle(),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    prefixIcon: Icon(Icons.search,
                                        size: 28, color: Color(0Xff0c9cc8)),
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.filter_list_alt,
                                          size: 28, color: Color(0Xff0c9cc8)),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FilterPage()));
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        optionsViewBuilder: (context, onSelected, options) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              elevation: 0,
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.30,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: options.length,
                                  itemBuilder: (context, index) {
                                    final option = options.elementAt(index);
                                    return ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 16),
                                      title: Text(option),
                                      onTap: () {
                                        onSelected(option);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(0.1),
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildExamCard(exams[0])),
                      SizedBox(width: 10),
                      Expanded(child: _buildExamCard(exams[1])),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: _buildExamCard(exams[2])),
                      SizedBox(width: 10),
                      Expanded(child: _buildExamCard(exams[3])),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: _buildExamCard(exams[4])),
                      SizedBox(width: 10),
                      Expanded(child: _buildExamCard(exams[5])),
                    ],
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FilterPage()));
                    },
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(16),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/1.08,
                            height: MediaQuery.of(context).size.height / 8,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.all_inbox,
                                      size: 38, color: Color(0Xff0c9cc8)),
                                  SizedBox(width:5),
                                  Text(
                                    'Explore More',
                                    style: AppWidget.boldTextFieldStyle(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExamCard(Exam exam) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubjectsPage(
              examName: exam.name,
              subjects: exam.subjects,
              subjects12: exam.subjects12,
              description1: exam.description1,
              description2: exam.description2,
              description3: exam.description3,
              description4: exam.description4,
            ),
          ),
        );
      },
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 165,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(exam.icon, size: 38, color: Color(0Xff0c9cc8)),
                SizedBox(height: 10),
                Text(
                  exam.name,
                  style: AppWidget.boldTextFieldStyle(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
