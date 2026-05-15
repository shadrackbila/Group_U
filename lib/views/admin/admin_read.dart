import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/admin_viewmodel.dart';
import '../../models/application_model.dart';

/**
 * Student Numbers : 223048044, 222049725, 223022994,223014209,224131946
 * Student Names : Shadrack Bila, Lerato Gladys Molefe,Marcus Mhlambi,Lisa Sandi,Lahluma Maselana
 * Question :   Admin read screen
 */

class AdminRead extends StatefulWidget {
  const AdminRead({super.key});

  @override
  State<AdminRead> createState() => _AdminRead();
}

class _AdminRead extends State<AdminRead> {
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
        title: const Text('Admin Read Screen'),
        backgroundColor: Colors.blue,
      ),
      body: Consumer<AdminViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (vm.applications.isEmpty) {
            return const Center(
              child: Text('No Applications Found'),
            );
          }

          return ListView.builder(
            itemCount: vm.applications.length,
            itemBuilder: (context, index) {
              ApplicationModel app = vm.applications[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(app.studentName[0]),
                  ),
                  title: Text(app.studentName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(app.studentEmail),
                      Text('Status: ${app.status}'),
                      Text('Module: ${app.module1Name}'),
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
