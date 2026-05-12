import 'package:flutter/material.dart';
import 'package:group_u/Components/pop_up_failed.dart';
import 'package:group_u/Components/pop_up_success.dart';
import 'package:group_u/models/student_assistant_model.dart';
import 'package:group_u/routesManager/routes_manager.dart';
import 'package:group_u/viewModels/student_assistants_view_model.dart';
import 'package:provider/provider.dart';

class PopUp extends StatelessWidget {
  final int index;
  const PopUp({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentAssistantsViewModel>(
      builder: (context, value, child) {
        final StudentAssistantModel application = value.applications[index];

        return Container(
          width: 300,
          height: 300,
          padding: EdgeInsets.all(10),

          // Student Card section
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Student Assistant",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(141, 255, 214, 64),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      application.status,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 123, 93, 2),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(141, 64, 150, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(5),
                child: Text(
                  "${application.academicLevel} Year",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 2, 91, 123),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(141, 64, 150, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(5),
                child: Text(
                  "Primary choice : ${application.module}",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 2, 91, 123),
                  ),
                ),
              ),

              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(141, 64, 150, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(5),
                child: Text(
                  "Secondary choice : ${application.secondModule}",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 2, 91, 123),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text("Applied on: ${application.date}"),
              SizedBox(height: 15),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RouteManager.studentAssistantFormUpdate,
                        arguments: index,
                      );
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 80, 148, 203),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 203, 80, 80),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      bool results = context
                          .read<StudentAssistantsViewModel>()
                          .deleteApplication(index);

                      if (results) {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(child: PopUpSuccess()),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(child: PopUpFailed()),
                        );
                      }
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
