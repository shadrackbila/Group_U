
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/admin_viewmodel.dart';
import '../../models/application_model.dart';

class AdminUpdate extends StatefulWidget {
  const AdminUpdate({super.key});

  @override
  State<AdminUpdate> createState() => _AdminUpdate();
}

class _AdminUpdate extends State<AdminUpdate> {
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
        title: const Text('Admin Update Screen'),
        backgroundColor: Colors.green,
      ),
      body: Consumer<AdminViewModel>(
        builder: (context, vm, _) {
          return ListView.builder(
            itemCount: vm.applications.length,
            itemBuilder: (context, index) {
              ApplicationModel app = vm.applications[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        app.studentName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(app.studentEmail),
                      Text('Current Status: ${app.status}'),
                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () {
                                vm.approveApplication(app.id!);
                              },
                              child: const Text('Approve'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {
                                vm.rejectApplication(app.id!);
                              },
                              child: const Text('Reject'),
                            ),
                          ),
                        ],
                      )
                    ],
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
