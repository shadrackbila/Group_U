import 'package:flutter/material.dart';
import 'package:group_u/viewModels/student_assistants_view_model.dart';
import 'package:provider/provider.dart';

class PopUpConfirmDelete extends StatelessWidget {
  final int index;
  const PopUpConfirmDelete({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 300,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Are you sure you want to delete this Application?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancel",
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
                    final nav = Navigator.of(context);
                    nav.pop();
                    context
                        .read<StudentAssistantsViewModel>()
                        .deleteApplication(index);
                  },
                  child: Text("Delete", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}