import 'package:flutter/material.dart';
import 'package:group_u/Components/pop_up.dart';
import 'package:group_u/models/student_assistant_model.dart';
import 'package:group_u/routesManager/routes_manager.dart';
import 'package:group_u/viewModels/student_assistants_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Applications", style: TextStyle(color: Colors.white)),

        centerTitle: false,
        backgroundColor: Colors.blue,
      ),
      body: Consumer<StudentAssistantsViewModel>(
        builder: (context, value, child) {
          final List<StudentAssistantModel> applications = value.applications;
          if (applications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.folder_open, size: 80, color: Colors.grey),
                  SizedBox(height: 10),
                  Text(
                    "No applications yet",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Tap the + button to create one",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: applications.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: PopUp(application: applications[index]),
                          ),
                        );
                      },
                      title: Text(applications[index].module),
                      subtitle: Text(
                        "Second Module: ${applications[index].secondModule} ",
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(141, 255, 214, 64),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(5),
                        child: Text(
                          applications[index].status,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 123, 93, 2),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var vm = context.read<StudentAssistantsViewModel>();
          Navigator.pushNamed(
            context,
            RouteManager.studentAssistantFormCreate,
            arguments: vm,
          );
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
