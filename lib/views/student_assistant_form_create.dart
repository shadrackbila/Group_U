import 'package:flutter/material.dart';

class StudentAssistantFormCreate extends StatefulWidget {
  const StudentAssistantFormCreate({super.key});

  @override
  State<StudentAssistantFormCreate> createState() =>
      _StudentAssistantFormCreateState();
}

class _StudentAssistantFormCreateState
    extends State<StudentAssistantFormCreate> {
  String? _selectedValueModule;
  String? _selectedValueYear;
  String? _selectedValueModuleOption2;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("New Application", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 10),

              TextFormField(
                decoration: InputDecoration(
                  labelText: "Surname",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 10),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Module",
                  border: OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(value: "option1", child: Text("Option 1")),
                  DropdownMenuItem(value: "option2", child: Text("Option 2")),
                  DropdownMenuItem(value: "option3", child: Text("Option 3")),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedValueModule = value;
                  });
                },
              ),

              SizedBox(height: 10),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Second Module option",
                  border: OutlineInputBorder(),
                ),

                items: [
                  DropdownMenuItem(value: "option1", child: Text("option 1")),
                  DropdownMenuItem(value: "option1", child: Text("option 1")),
                  DropdownMenuItem(value: "option1", child: Text("option 1")),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedValueModuleOption2 = value;
                  });
                },
              ),

              SizedBox(height: 10),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Year of study",
                  border: OutlineInputBorder(),
                ),

                items: [
                  DropdownMenuItem(value: "1", child: Text("1st Year")),
                  DropdownMenuItem(value: "2", child: Text("2nd Year")),
                  DropdownMenuItem(value: "3", child: Text("3rd Year")),
                  DropdownMenuItem(value: "4", child: Text("4th Year")),
                  DropdownMenuItem(
                    value: "postGraduate",
                    child: Text("Post graduate"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedValueYear = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        child: Text("Submit", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
