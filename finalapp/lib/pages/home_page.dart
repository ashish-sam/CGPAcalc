import 'package:finalapp/components/course_tile.dart';
import 'package:finalapp/data/course_data.dart';
import 'package:finalapp/data/sem_data.dart';
import 'package:finalapp/models/course_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final creditController = TextEditingController();
  final codeController = TextEditingController();
  int gradePoint = 0;
  int? newValue;

  void addNewCourse() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Add new course"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: nameController,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(hintText: "Course Title"),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: codeController,
                          textCapitalization: TextCapitalization.characters,
                          decoration: InputDecoration(hintText: "Code"),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: creditController,
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(hintText: "Course Credits"),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          decoration: InputDecoration(hintText: "Grade"),
                          value: gradePoint,
                          icon: Icon(Icons.arrow_drop_down),
                          onChanged: (newValue) {
                            setState(() {
                              gradePoint = newValue!;
                            });
                          },
                          items: [
                            DropdownMenuItem<int>(
                                value: 0, child: Text("Grade")),
                            DropdownMenuItem<int>(value: 10, child: Text("A")),
                            DropdownMenuItem<int>(value: 9, child: Text("A-")),
                            DropdownMenuItem<int>(value: 8, child: Text("B")),
                            DropdownMenuItem<int>(value: 7, child: Text("B-")),
                            DropdownMenuItem<int>(value: 6, child: Text("C")),
                            DropdownMenuItem<int>(value: 5, child: Text("C-")),
                            DropdownMenuItem<int>(value: 4, child: Text("D")),
                            DropdownMenuItem<int>(value: 3, child: Text("E")),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: save,
                  child: Text("Save"),
                ),
                MaterialButton(
                  onPressed: cancel,
                  child: Text("Cancel"),
                ),
              ],
            ));
  }

  String? semester;
  void save() {
    CourseItem newCourse = CourseItem(
        name: nameController.text,
        credits: int.parse(creditController.text),
        grade: gradePoint,
        sem: "1-1",
        code: codeController.text);
    Provider.of<CourseData>(context, listen: false).addNewCourse(newCourse);
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    nameController.clear();
    gradePoint = 0;
    creditController.clear();
    codeController.clear();
  }

  List<bool> expanded = [false, false];

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseData>(
        builder: (context, value, child) => Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Center(
                  child: Text(
                    'CGPA Calculator',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              floatingActionButton: FloatingActionButton(
                elevation: 0,
                
                backgroundColor: Colors.black,
                onPressed: addNewCourse,
                child: Icon(Icons.add),
              ),
              body: Column(
                children: [
                  Container(
                    child: Text(
                      "CGPA=" + value.calcGPA(),
                      style: TextStyle(
                        fontSize: 50,
                      ),
                    ),
                  ),
                  ExpansionPanelList(
                    elevation: 1,
                    expansionCallback: (panelIndex, isClosed) {
                      setState(() {
                        expanded[panelIndex] = isClosed;
                      });
                    },
                    children: [
                      ExpansionPanel(
                        headerBuilder: (context, isOpen) {
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "1-1",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                        body: Column(
                          children: [
                            Divider(
                              height: 1,
                            ),
                            TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                              ),
                              onPressed: addNewCourse,
                              child: Text(
                                "ADD COURSE",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              height: 1,
                            ),
                            Container(
                              color: Colors.yellow.shade100,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.getCourseList().length,
                                itemBuilder: (context2, index) => CourseTile(
                                  name: value.getCourseList()[index].name,
                                  grade: value.getCourseList()[index].grade,
                                  sem: "1-1",
                                  credits: value.getCourseList()[index].credits,
                                  code: value.getCourseList()[index].code,
                                ),
                              ),
                            ),
                          ],
                        ),
                        isExpanded: expanded[0],
                        canTapOnHeader: true,
                      ),
                      
                    ],
                  ),
                ],
              ),
            ));
  }
}
