import 'package:flutter/material.dart';
import 'package:group_u/Components/status.dart';
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Student Assistant",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Status(status: application.status),
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
                      showDialog(
                        context: context,
                        builder: (context) => PopUpConfirmDelete(
                          index: index,
                          onConfirm: () {
                            // Delete the application
                            final viewModel = Provider.of<StudentAssistantsViewModel>(
                              context,
                              listen: false,
                            );
                            viewModel.deleteApplication(index);
                            Navigator.pop(context); // Close the dialog
                          },
                        ),
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
        );
      },
    );
  }
}

// ADD THIS MISSING WIDGET CLASS
class PopUpConfirmDelete extends StatelessWidget {
  final int index;
  final VoidCallback onConfirm;

  const PopUpConfirmDelete({
    super.key,
    required this.index,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Confirm Delete',
        style: TextStyle(
          color: Colors.red.shade700,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange,
            size: 48,
          ),
          const SizedBox(height: 16),
          const Text(
            'Are you sure you want to delete this application?',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'This action cannot be undone.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade700,
          ),
          onPressed: () {
            onConfirm(); // Execute the delete
          },
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}