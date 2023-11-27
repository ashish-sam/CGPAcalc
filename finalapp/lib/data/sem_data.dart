import 'package:flutter/widgets.dart';
import 'package:finalapp/models/course_item.dart';
import 'package:finalapp/data/course_data.dart';

class Semdata extends ChangeNotifier {
  List<CourseData> semList = [];

  List<CourseData> getSemList() {
    return semList;
  }

  void addNewSem(CourseData newSem) {
    semList.add(newSem);
    notifyListeners();
  }

  void deleteSem(CourseData newSem) {
    semList.remove(newSem);
    notifyListeners();
  }
}
