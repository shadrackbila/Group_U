
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/admin_viewmodel.dart';
import '../../models/application_model.dart';

class AdminDelete extends StatefulWidget {
  const AdminDelete({super.key});

  @override
  State<AdminDelete> createState() => _AdminDeleteScreenState();
}

class _AdminDeleteScreenState extends State<AdminDelete> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminViewModel>().loadAllApplications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Delete Screen'),
        backgroundColor: Colors.red,
      ),
      body: Consumer<AdminViewModel>(
        builder: (context, vm, _) {
          return ListView.builder(
            itemCount: vm.applications.length,
            itemBuilder: (context, index) {
              ApplicationModel app = vm.applications[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(app.studentName),
                  subtitle: Text(app.studentEmail),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Delete Application'),
                          content: Text(
                            'Are you sure you want to delete ${app.studentName}?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                vm.deleteApplication(app.id!);
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
