import 'dart:convert';
import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quest_bank/widget/book_manager.dart';
import 'package:quest_bank/pages/bookmark.dart';
import 'package:quest_bank/pages/bottomnav.dart';
import 'package:quest_bank/pages/profile.dart';
import 'package:quest_bank/widget/widget_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ZipFilePage extends StatefulWidget {
  final String examName;
  final String level;
  final List<String> subjects;
  final List<String> subjects12;
  final String Selectedsubject;
  final String Selectedsubject12;
  final String description1;
  final String description3;

  ZipFilePage({
    required this.examName,
    required this.level,
    required this.subjects,
    required this.subjects12,
    required this.Selectedsubject,
    required this.Selectedsubject12,
    required this.description1,
    required this.description3,
  });

  @override
  State<ZipFilePage> createState() => _ZipFilePageState();
}

class _ZipFilePageState extends State<ZipFilePage> {
  int currentTabIndex = 0;
  bool _isLoading = true;
  bool _isBookmarked = false;

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<void> requestStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
    } else {}
  }

  String generateApiUrl(String exam, String level, String subject, String year,
      String description1, String description3) {
    String levelCode = "";
    String subjectCode = "";
    int nextYear = int.parse(year) + 1;
    String yearCode = nextYear.toString().substring(2, 4);

    String effectiveLevel = level.isNotEmpty
        ? level
        : description1.isNotEmpty
            ? description1
            : description3.isNotEmpty
                ? description3
                : "";

    print("Effective Level: '$effectiveLevel'");
    print("Description 1: '$description1'");
    print("Description 3: '$description3'");

    if (exam == "CBSE" || exam == "ICSE") {
      if (description1.isNotEmpty) {
        levelCode = "10";
        print("Description 1 is used, Level Code set to: $levelCode");
      } else if (description3.isNotEmpty) {
        levelCode = "12";
        print("Description 3 is used, Level Code set to: $levelCode");
      } else {
        levelCode = (effectiveLevel.contains("10")) ? "10" : "12";
        print("Level Code based on effectiveLevel: $levelCode");
      }
    } else if (exam == "JEE") {
      levelCode = (effectiveLevel.toLowerCase().contains("main")) ? "M" : "A";
      print("JEE Level Code: $levelCode");
    } else if (exam == "NEET" || exam == "CET") {
      levelCode = "";
      print("NEET/CET Level Code: $levelCode");
    } else if (exam == "NCERT") {
      levelCode = (effectiveLevel.contains("10")) ? "10" : "12";
      print("NCERT Level Code: $levelCode");
    } else if (exam == "CAT") {
      levelCode = "";
      print("CAT Level Code: $levelCode");
    }

    switch (subject) {
      case "English":
        subjectCode = "EN";
        break;
      case "History":
        subjectCode = "HIS";
        break;
      case "Geography":
        subjectCode = "GEO";
        break;
      case "Math":
        subjectCode = "MAT";
        break;
      case "Physics":
        subjectCode = "PHY";
        break;
      case "Chemistry":
        subjectCode = "CHEM";
        break;
      case "Biology":
        subjectCode = "BIO";
        break;
      case "QA":
        subjectCode = "QA";
        break;
      case "VARC":
        subjectCode = "VA";
        break;
      case "DILR":
        subjectCode = "LR";
        break;
    }

    print(
        "Exam: $exam, Level: $level, Description 1: $description1, Description 3: $description3, Level Code: $levelCode, Subject: $subject, Subject Code: $subjectCode, Year Code: $yearCode");

    String apiUrl =
        "${exam.toUpperCase()}$levelCode$subjectCode${yearCode}_q.zip";
    return apiUrl;
  }

  Future<void> downloadFile(
    BuildContext context,
    String exam,
    String level,
    String subject,
    String year,
    String description1,
    String description3,
    String fileName,
  ) async {
    await requestStoragePermission();

    try {
      String apiUrl = generateApiUrl(
          exam, level, subject, year, description1, description3);
      String requestUrl = "http://10.0.1.122:5000/download/$apiUrl";

      print('Generated URL: $requestUrl');

      String? accessToken = await getAccessToken();
      if (accessToken == null) {
        print('Access token not found. Please log in again.');
        return;
      }
      print('Access Token: $accessToken');

      Dio dio = Dio();

      final response = await dio.get(
        requestUrl,
        data: {'access_token': accessToken},
        options: Options(
          responseType: ResponseType.json,
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        print('API Response: ${response.data}');
        String? downloadLink = response.data['download_url'];

        if (downloadLink != null && downloadLink.isNotEmpty) {
          Uri downloadUri = Uri.parse(downloadLink);

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Download File'),
                content: Text('Do you want to download this file?'),
                actions: <Widget>[
                  TextButton(
                    child: Text('Download'),
                    onPressed: () async {
                      try {
                        Directory? directory =
                            await getExternalStorageDirectory();
                        if (directory != null) {
                          String newPath = "";
                          List<String> folders = directory.path.split("/");
                          for (int i = 1; i < folders.length; i++) {
                            String folder = folders[i];
                            if (folder != "Android") {
                              newPath += "/" + folder;
                            } else {
                              break;
                            }
                          }
                          newPath = newPath + "/Download";

                          directory = Directory(newPath);
                          if (!await directory.exists()) {
                            await directory.create(recursive: true);
                          }

                          String filePath = '${directory.path}/$fileName';

                          final fileResponse = await dio.get(
                            downloadUri.toString(),
                            options: Options(
                              responseType: ResponseType.stream,
                              followRedirects: false,
                              validateStatus: (status) => status! < 500,
                            ),
                          );

                          if (fileResponse.statusCode == 200) {
                            final file = File(filePath);
                            final raf = file.openSync(mode: FileMode.write);

                            await for (var chunk in fileResponse.data.stream) {
                              raf.writeFromSync(chunk);
                            }
                            await raf.close();

                            print('File downloaded to: $filePath');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    Text('File Downloaded Successfully'),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.greenAccent,
                                      size: 20,
                                    ),
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
                          } else {
                            print(
                                'Failed to download file. Status code: ${fileResponse.statusCode}');
                          }
                        } else {
                          print('Could not access external storage');
                        }
                      } catch (e) {
                        print('Error downloading file: $e');
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          print('Download link is null or empty');
        }
      } else {
        print(
            'Failed to retrieve download link. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching download link: $e');
    }
  }

  IconData getIconForExam(String examName) {
    switch (examName) {
      case 'CBSE':
        return Icons.school_rounded;
      case 'JEE':
        return Icons.engineering;
      case 'NEET':
        return Icons.local_hospital;
      case 'CET':
        return Icons.assignment;
      case 'CAT':
        return Icons.business_center;
      case 'ICSE':
        return Icons.school_rounded;
      case 'NCERT':
        return Icons.school_rounded;
      default:
        return Icons.help;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(Duration(seconds: 4));
    setState(() {
      _isLoading = false;
    });
  }

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
      IconData icon = getIconForExam(widget.examName);
      print('Icon for ${widget.examName}: $icon');

      if (_isBookmarked) {
        if (widget.Selectedsubject.isNotEmpty) {
          BookmarkManager.addBookmark(
              widget.Selectedsubject, widget.examName, icon);
        }
        if (widget.Selectedsubject12.isNotEmpty) {
          BookmarkManager.addBookmark(
              widget.Selectedsubject12, widget.examName, icon);
        }
      } else {
        if (widget.Selectedsubject.isNotEmpty) {
          BookmarkManager.removeBookmark(
              widget.Selectedsubject, widget.examName, icon);
        }
        if (widget.Selectedsubject12.isNotEmpty) {
          BookmarkManager.removeBookmark(
              widget.Selectedsubject12, widget.examName, icon);
        }
      }
    });

    final snackBar = SnackBar(
      content: Row(
        children: [
          Text(_isBookmarked
              ? 'Bookmark added successfully'
              : 'Bookmark removed successfully'),
          SizedBox(width: 5),
          Icon(
            Icons.check_circle,
            color: Colors.greenAccent,
            size: 20,
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.all(20),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Color(0Xff0c9cc8),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 18, top: 38, right: 18),
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
                      Expanded(
                        child: Text(
                          widget.examName,
                          style: AppWidget.bookTextFieldStyle(),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _isBookmarked
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          size: 34,
                          color: Color(0Xff0c9cc8),
                        ),
                        onPressed: _toggleBookmark,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      downloadFile(
                          context,
                          widget.examName,
                          widget.level,
                          widget.Selectedsubject,
                          "2024",
                          widget.description1,
                          widget.description3,
                          "all_files.zip");
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2.65,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12, left: 18),
                                    child: Text(
                                      "Download Zip.file",
                                      style: AppWidget.subTextFieldStyle(),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 15, left: 5),
                                    child: Icon(
                                      Icons.download_rounded,
                                      size: 26,
                                      color: Color(0Xff0c9cc8),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 18),
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildOption("Previous Year Questions",
                                        Icons.article),
                                    SizedBox(height: 15),
                                    _buildOption("Report Analysis",
                                        Icons.bar_chart_rounded),
                                    SizedBox(height: 15),
                                    _buildOption(
                                        "Probable Questions", Icons.lightbulb),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 18,
                            right: 16,
                            child: Container(
                              width: MediaQuery.of(context).size.height,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (widget.Selectedsubject.isNotEmpty)
                                      Text(
                                        widget.Selectedsubject,
                                        style: AppWidget.yearTextFieldStyle(),
                                      ),
                                    if (widget.Selectedsubject12.isNotEmpty)
                                      Text(
                                        widget.Selectedsubject12,
                                        style: AppWidget.yearTextFieldStyle(),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "Or View",
                          style: AppWidget.subTextFieldStyle(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, top: 3),
                        child: Icon(
                          Icons.visibility_rounded,
                          size: 26,
                          color: Color(0Xff0c9cc8),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      _buildViewOption("Previous Year questions"),
                      SizedBox(height: 8),
                      _buildViewOption("Report Analysis"),
                      SizedBox(height: 8),
                      _buildViewOption("Probable Questions"),
                    ],
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

  Widget _buildOption(String text, IconData icon) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: MediaQuery.of(context).size.height / 14,
        width: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 26, color: Color(0Xff0c9cc8)),
            SizedBox(width: 5),
            Text(
              text,
              style: AppWidget.nav3TextFieldStyle(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewOption(String text) {
    return Container(
      height: MediaQuery.of(context).size.height / 14,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              text,
              style: AppWidget.intrTextFieldStyle(),
            ),
          ),
        ],
      ),
    );
  }
}
