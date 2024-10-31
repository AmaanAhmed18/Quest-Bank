import 'package:flutter/material.dart';

class Exam {
  final String name;
  final IconData icon;
  final List<String> subjects;
  final List<String> subjects12;
  final String description1;
  final String description2;
  final String description3;
  final String description4;

  Exam(
      {required this.name,
      required this.subjects,
      required this.subjects12,
      required this.icon,
      required this.description1,
      required this.description2,
      required this.description3,
      required this.description4});
}

final List<Exam> exams = [
  Exam(
      name: 'CBSE',
      subjects: ['English', 'History', 'Math', 'More'],
      subjects12: ['Physics', 'Chemistry', 'More'],
      icon: Icons.school_rounded,
      description1: 'Class 10',
      description2: '2024',
      description3: 'Class 12',
      description4: '2024'),
  Exam(
      name: 'JEE',
      subjects: ['Physics', 'Chemistry', 'More'],
      subjects12: ['Physics', 'Chemistry', 'Maths', 'More'],
      icon: Icons.engineering,
      description1: 'Jee Main',
      description2: '2024',
      description3: 'Jee Advanced',
      description4: '2024'),
  Exam(
      name: 'NEET',
      subjects: ['Biology', 'Chemistry', 'Physics', 'More'],
      subjects12: ['English', 'Math', 'More'],
      icon: Icons.local_hospital,
      description1: 'Neet',
      description2: '2024',
      description3: 'Class 10',
      description4: '2024'),
  Exam(
      name: 'CET',
      subjects: ['Math', 'Physics', 'Chemistry', 'More'],
      subjects12: ['English', 'Math', 'Physics', 'More'],
      icon: Icons.assignment,
      description1: 'Cet',
      description2: '2024',
      description3: 'Class 10',
      description4: '2024'),
  Exam(
      name: 'CAT',
      subjects: ['QA', 'VA', 'DILR', 'More'],
      subjects12: ['English', 'Math', 'Physics', 'More'],
      icon: Icons.business_center,
      description1: 'Cat',
      description2: '2024',
      description3: 'Class 10',
      description4: '2024'),
  Exam(
      name: 'ICSE',
      subjects: ['History', 'Geography', 'Physics', 'More'],
      subjects12: ['English', 'Biology', 'More'],
      icon: Icons.school_rounded,
      description1: 'Class 10',
      description2: '2024',
      description3: 'Class 12',
      description4: '2024'),
];
