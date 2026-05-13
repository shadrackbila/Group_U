import 'package:flutter/material.dart';
import 'package:group_u/Components/pop_up_admin.dart';
import 'package:group_u/Components/status.dart';
import 'package:group_u/models/student_assistant_model.dart';
import 'package:group_u/viewModels/student_assistants_view_model.dart';
import 'package:provider/provider.dart';

class AdminRead extends StatefulWidget {
  const AdminRead({super.key});

  @override
  State<AdminRead> createState() => _AdminReadState();
}

class _AdminReadState extends State<AdminRead> {
  String _selectedFilter = "all";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin - Applications Available",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: Consumer<StudentAssistantsViewModel>(
        builder: (context, value, child) {
          final List<StudentAssistantModel> applications =
              _selectedFilter == "all"
              ? value.applications
              : value.applications
                    .where((p) => p.status == _selectedFilter)
                    .toList();

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterChip(
                        label: Text("All"),
                        selected: _selectedFilter == "all",
                        onSelected: (_) =>
                            setState(() => _selectedFilter = "all"),
                        selectedColor: Colors.blue[100],
                        checkmarkColor: Colors.blue,
                        labelStyle: TextStyle(
                          color: _selectedFilter == "all"
                              ? Colors.blue
                              : Colors.grey[700],
                          fontWeight: _selectedFilter == "all"
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      SizedBox(width: 8),
                      FilterChip(
                        label: Text("Pending"),
                        selected: _selectedFilter == "pending",
                        onSelected: (_) =>
                            setState(() => _selectedFilter = "pending"),
                        selectedColor: const Color.fromARGB(141, 255, 214, 64),
                        checkmarkColor: const Color.fromARGB(255, 123, 93, 2),
                        labelStyle: TextStyle(
                          color: _selectedFilter == "pending"
                              ? const Color.fromARGB(255, 123, 93, 2)
                              : Colors.grey[700],
                          fontWeight: _selectedFilter == "pending"
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      SizedBox(width: 8),
                      FilterChip(
                        label: Text("Accepted"),
                        selected: _selectedFilter == "accepted",
                        onSelected: (_) =>
                            setState(() => _selectedFilter = "accepted"),
                        selectedColor: const Color.fromARGB(141, 100, 220, 100),
                        checkmarkColor: const Color.fromARGB(255, 2, 100, 2),
                        labelStyle: TextStyle(
                          color: _selectedFilter == "accepted"
                              ? const Color.fromARGB(255, 2, 100, 2)
                              : Colors.grey[700],
                          fontWeight: _selectedFilter == "accepted"
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      SizedBox(width: 8),
                      FilterChip(
                        label: Text("Rejected"),
                        selected: _selectedFilter == "rejected",
                        onSelected: (_) =>
                            setState(() => _selectedFilter = "rejected"),
                        selectedColor: const Color.fromARGB(141, 220, 100, 100),
                        checkmarkColor: const Color.fromARGB(255, 150, 2, 2),
                        labelStyle: TextStyle(
                          color: _selectedFilter == "rejected"
                              ? const Color.fromARGB(255, 150, 2, 2)
                              : Colors.grey[700],
                          fontWeight: _selectedFilter == "rejected"
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: applications.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.folder_open,
                              size: 80,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "No applications found",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: applications.length,
                        itemBuilder: (context, index) {
                          final realIndex = value.applications.indexOf(
                            applications[index],
                          );
                          return ListTile(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    PopUpAdmin(index: realIndex),
                              );
                            },
                            title: Text(applications[index].module),
                            subtitle:
                                applications[index].secondModule.isNotEmpty
                                ? Text(
                                    "Second Module: ${applications[index].secondModule}",
                                  )
                                : null,
                            trailing: Status(
                              status: applications[index].status,
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
