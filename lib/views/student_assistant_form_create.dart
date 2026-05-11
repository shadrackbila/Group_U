import 'package:flutter/material.dart';
import 'package:group_u/viewModels/student_assistants_view_model.dart';

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
  final _surnameController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final StudentAssistantsViewModel _assistantsViewModel =
      StudentAssistantsViewModel();

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name is required";
                  }
                  return null;
                },
              ),

              SizedBox(height: 10),

              TextFormField(
                controller: _surnameController,
                decoration: InputDecoration(
                  labelText: "Surname",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Surname is required";
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Module is required";
                  }
                  return null;
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
                  DropdownMenuItem(value: "option2", child: Text("option 2")),
                  DropdownMenuItem(value: "option3", child: Text("option 3")),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedValueModuleOption2 = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Select a secondary module";
                  }
                  return null;
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Select your level of study";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _assistantsViewModel.createApplication(
              name: _nameController.text,
              surname: _surnameController.text,
              module: _selectedValueModule.toString(),
              academicLevel: _selectedValueYear.toString(),
              secondModule: _selectedValueModuleOption2.toString(),
            );
          }
        },
        child: Text("Submit", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
