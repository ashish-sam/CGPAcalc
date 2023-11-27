import 'package:flutter/widgets.dart';
import 'package:finalapp/models/course_item.dart';

class CourseData extends ChangeNotifier{
  List<CourseItem> courseList = [];
  int sem = 1;
  List<CourseItem> getCourseList() {
    return courseList;
  }

  void addNewCourse(CourseItem newCourse) {
    courseList.add(newCourse);

    notifyListeners();
  }

  void deleteCourse(CourseItem newCourse) {
    courseList.remove(newCourse);

    notifyListeners();
  }

  String calcGPA() {
    double sum = 0, creditSum = 0, GPA = 0.0;
    for (int i = 0; i < getCourseList().length; i++) {
      sum += getCourseList()[i].credits * getCourseList()[i].grade;
    }
    for (int i = 0; i < getCourseList().length; i++) {
      creditSum += getCourseList()[i].credits;
    }
    Listener();
    if (creditSum > 0) GPA = sum / creditSum;
    return GPA.toStringAsFixed(2);
  }
}
