import 'package:flutter/material.dart';
import 'package:quest_bank/pages/zip.dart';
import 'package:quest_bank/widget/widget_support.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String selectedExam = "Exam";
  String selectedLevel = "Level";
  String selectedSubject = "Subject";
  String selectedYear = "Year";

  void onSubjectSelected(String subject) {
    setState(() {
      selectedSubject = subject;
    });
  }

  void _applyFilters() {
    if (selectedExam != "Exam" &&
        selectedLevel != "Level" &&
        selectedSubject != "Subject" &&
        selectedYear != "Year") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ZipFilePage(
            examName: selectedExam,
            level: selectedLevel,
            subjects: [selectedSubject],
            subjects12: [],
            Selectedsubject: selectedSubject,
            Selectedsubject12: '',
            description1: '',
            description3: '',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Text('Please select all options before applying filters.'),
              SizedBox(width: 5),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.all(20),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 30),
            color: Colors.white10,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        iconSize: 34,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        "Filter",
                        style: AppWidget.bookTextFieldStyle(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.0),
                _buildInfoCard(
                    label1: selectedExam,
                    label2: "View All",
                    icon: Icons.assignment,
                    onTap: () => _showModal("Exam")),
                SizedBox(height: 25.0),
                _buildInfoCard(
                    label1: selectedLevel,
                    label2: "View All",
                    icon: Icons.school,
                    onTap: () => _showModal("Level")),
                SizedBox(height: 25.0),
                _buildInfoCard(
                    label1: selectedSubject,
                    label2: "View All",
                    icon: Icons.book_rounded,
                    onTap: () => _showModal("Subject")),
                SizedBox(height: 25.0),
                _buildInfoCard(
                    label1: selectedYear,
                    label2: "View All",
                    icon: Icons.calendar_month,
                    onTap: () => _showModal("Year")),
                SizedBox(height: 70.0),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(25),
                  child: InkWell(
                    onTap: _applyFilters,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      width: MediaQuery.of(context).size.height / 2.5,
                      height: MediaQuery.of(context).size.height / 17,
                      decoration: BoxDecoration(
                        color: (selectedExam != "Exam" &&
                                selectedLevel != "Level" &&
                                selectedSubject != "Subject" &&
                                selectedYear != "Year")
                            ? Color(0Xff0c9cc8)
                            : Color.fromARGB(255, 162, 208, 228),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: (selectedExam != "Exam" &&
                                  selectedLevel != "Level" &&
                                  selectedSubject != "Subject" &&
                                  selectedYear != "Year")
                              ? _applyFilters
                              : null,
                          child: Text(
                            "APPLY",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins1',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String label1,
    required String label2,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 2.0,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 25,
                    color: Color(0Xff0c9cc8),
                  ),
                  SizedBox(width: 10),
                  Text(
                    label1,
                    style: TextStyle(
                      color: Color(0Xff3f3d3d),
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: onTap,
                      child: Text(
                        label2,
                        style: AppWidget.fitlitTextFieldStyle(),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_drop_down,
                          size: 30, color: Color(0Xff3f3d3d)),
                      onPressed: onTap,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showModal(String label) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _buildModalBottomSheetContent(label);
      },
    );
  }

  Widget _buildModalBottomSheetContent(String label) {
    switch (label) {
      case "Exam":
        return _examModalContent();
      case "Level":
        return _levelModalContent();
      case "Subject":
        return _subjectModalContent();
      case "Year":
        return _yearModalContent();
      default:
        return Center(child: Text("No content available"));
    }
  }

  Widget _examModalContent() {
    List<String> examOptions = [
      "NEET",
      "CET",
      "NCERT",
      "CAT",
      "CBSE",
      "JEE",
      "ICSE"
    ];

    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 2, right: 2),
      child: Column(
        children: [
          Icon(
            Icons.drag_handle_sharp,
            size: 40,
            color: Colors.grey,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: examOptions.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                    title: Text(
                      examOptions[index],
                      style: TextStyle(
                          color: Color(0Xff3f3d3d),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    onTap: () {
                      setState(() {
                        selectedExam = examOptions[index];
                        selectedLevel = "Level";
                        selectedSubject = "Subject";
                        selectedYear = "Year";
                      });
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _levelModalContent() {
    List<String> levelOptions;

    switch (selectedExam) {
      case "NEET":
      case "CET":
        levelOptions = ["Level 1", "Level 2"];
        break;
      case "JEE":
        levelOptions = ["Jee Main", "Jee Advanced"];
        break;
      case "CBSE":
      case "ICSE":
        levelOptions = ["Class 10", "Class 12"];
        break;
      case "CAT":
        levelOptions = ["Section 1", "Section 2"];
        break;
      case "NCERT":
        levelOptions = ["Class 10", "Class 12"];
        break;
      default:
        levelOptions = ["Class 10", "Class 12", "Jee Main", "Jee Advanced"];
    }

    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 2, right: 2),
      child: Column(
        children: [
          Icon(
            Icons.drag_handle_sharp,
            size: 40,
            color: Colors.grey,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: levelOptions.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                    title: Text(
                      levelOptions[index],
                      style: TextStyle(
                        color: Color(0Xff3f3d3d),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectedLevel = levelOptions[index];
                      });
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _subjectModalContent() {
    List<String> subjectOptions;

    switch (selectedExam) {
      case "NEET":
        subjectOptions = ["Physics", "Chemistry", "Biology"];
        break;
      case "CET":
        subjectOptions = ["Physics", "Chemistry", "Maths", "Biology"];
        break;
      case "JEE":
        subjectOptions = ["Physics", "Chemistry", "Maths"];
        break;
      case "CBSE":
      case "ICSE":
        subjectOptions = [
          "English",
          "Maths",
          "Physics",
          "Chemistry",
          "Biology",
          "History",
          "Geography"
        ];
        break;
      case "CAT":
        subjectOptions = ["QA", "VARC", "DILR"];
        break;
      case "NCERT":
        subjectOptions = [
          "English",
          "Maths",
          "Physics",
          "Chemistry",
          "Biology",
          "History",
          "Geography"
        ];
        break;
      default:
        subjectOptions = [
          "English",
          "Maths",
          "Physics",
          "Chemistry",
          "Biology",
          "History",
          "Geography",
          "Economics",
          "QA",
          "VARC",
          "DILR"
        ];
    }

    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 2, right: 2),
      child: Column(
        children: [
          Icon(
            Icons.drag_handle_sharp,
            size: 40,
            color: Colors.grey,
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ListView.builder(
                itemCount: subjectOptions.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                      title: Text(
                        subjectOptions[index],
                        style: TextStyle(
                          color: Color(0Xff3f3d3d),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        setState(() {
                          selectedSubject = subjectOptions[index];
                        });
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _yearModalContent() {
    List<String> yearOptions = [
      "2024",
      "2025",
      "2026",
    ];

    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 2, right: 2),
      child: Column(
        children: [
          Icon(
            Icons.drag_handle_sharp,
            size: 40,
            color: Colors.grey,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: yearOptions.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                    title: Text(
                      yearOptions[index],
                      style: TextStyle(
                          color: Color(0Xff3f3d3d),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    onTap: () {
                      setState(() {
                        selectedYear = yearOptions[index];
                      });
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
