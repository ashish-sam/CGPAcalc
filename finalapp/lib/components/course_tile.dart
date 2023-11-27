import 'package:flutter/material.dart';

class CourseTile extends StatelessWidget {
  final String name;
  final int grade;
  final int credits;
  final String sem;
  final String code;

  const CourseTile(
      {super.key,
      required this.name,
      required this.grade,
      required this.sem,
      required this.credits,
      required this.code});

  String stringGrade(int g) {
    String s;
    s = "A_";
    switch (g) {
      case 10:
        s = "A";
        break;
      case 9:
        s = "A-";
        break;
      case 8:
        s = "B";
        break;
      case 7:
        s = "B-";
        break;
      case 6:
        s = "C";
        break;
      case 5:
        s = "C-";
        break;
      case 4:
        s = "D";
        break;
      case 3:
        s = "E";
        break;
    }
    return s;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        (code + ":\t" + name),
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle:
          Text("Semester: " + sem + "\n" + "Credits: " + credits.toString()),
      trailing: Text(
        stringGrade(grade),
        style: TextStyle(
          fontSize: 30,
        ),
      ),
    );
  }
}
