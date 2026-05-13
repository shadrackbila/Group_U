import 'package:flutter/material.dart';
import 'package:group_u/Components/pop_up_confirm_delete.dart';
import 'package:group_u/Components/status.dart';
import 'package:group_u/models/student_assistant_model.dart';
import 'package:group_u/routesManager/routes_manager.dart';
import 'package:group_u/viewModels/student_assistants_view_model.dart';
import 'package:provider/provider.dart';

class PopUpAdmin extends StatelessWidget {
  final int index;
  const PopUpAdmin({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentAssistantsViewModel>(
      builder: (context, value, child) {
        final StudentAssistantModel application = value.applications[index];

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: 400,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Student Assistant",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    Status(status: application.status),
                  ],
                ),
                SizedBox(height: 20),

                _infoBox(
                  color: const Color.fromARGB(141, 255, 255, 255),
                  textColor: const Color.fromARGB(255, 18, 62, 79),
                  text:
                      "${application.name} ${application.surname} | ${application.studentNumber}",
                ),
                SizedBox(height: 12),

                _infoBox(
                  color: const Color.fromARGB(141, 64, 150, 255),
                  textColor: const Color.fromARGB(255, 2, 91, 123),
                  text: "Student level: ${application.academicLevel} Year",
                ),
                SizedBox(height: 12),

                _infoBox(
                  color: const Color.fromARGB(141, 64, 150, 255),
                  textColor: const Color.fromARGB(255, 2, 91, 123),
                  text: "Primary choice: ${application.module}",
                ),
                SizedBox(height: 12),

                _infoBox(
                  color: const Color.fromARGB(141, 64, 150, 255),
                  textColor: const Color.fromARGB(255, 2, 91, 123),
                  text: "Secondary choice: ${application.secondModule}",
                ),
                SizedBox(height: 12),

                Text("Applied on: ${application.date}"),
                SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          RouteManager.adminUpdate,
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
                        showDialog(
                          context: context,
                          builder: (context) =>
                              PopUpConfirmDelete(index: index),
                        );
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
          ),
        );
      },
    );
  }

  Widget _infoBox({
    required Color color,
    required Color textColor,
    required String text,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(8),
      child: Text(text, style: TextStyle(color: textColor)),
    );
  }
}
