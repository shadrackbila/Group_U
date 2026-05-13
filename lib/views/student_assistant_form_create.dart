import 'package:flutter/material.dart';
import 'package:group_u/Components/pop_up_failed.dart';
import 'package:group_u/Components/pop_up_success.dart';
import 'package:group_u/viewModels/student_assistants_view_model.dart';

class StudentAssistantFormCreate extends StatefulWidget {
  final StudentAssistantsViewModel vm;
  const StudentAssistantFormCreate({super.key, required this.vm});

  @override
  State<StudentAssistantFormCreate> createState() =>
      _StudentAssistantFormCreateState();
}

class _StudentAssistantFormCreateState
    extends State<StudentAssistantFormCreate> {
  String? _selectedValueModule;
  String? _selectedValueYear;
  String? _selectedValueModuleOption2;
  bool _meetRequirements = false;
  bool _results = false;
  final _surnameController = TextEditingController();
  final _nameController = TextEditingController();
  final _studentNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _studentNumberController.dispose();
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
                controller: _studentNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Student number",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Student number is required";
                  }
                  if (value.length != 9) {
                    return "Student number must be exactly 9 digits";
                  }
                  if (!RegExp(r'^\d{9}$').hasMatch(value)) {
                    return "Student number must contain numbers only";
                  }
                  return null;
                },
              ),

              SizedBox(height: 10),
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

              SizedBox(height: 10),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Module",
                  border: OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(value: "SOD316", child: Text("SOD316")),
                  DropdownMenuItem(value: "TPG316", child: Text("TPG316")),
                  DropdownMenuItem(value: "CMN316", child: Text("CMN316")),
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
                  DropdownMenuItem(value: "SSE316", child: Text("SSE316")),
                  DropdownMenuItem(value: "SOE316", child: Text("SOE316")),
                  DropdownMenuItem(value: "ITS316", child: Text("ITS316")),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedValueModuleOption2 = value;
                  });
                },
              ),

              SizedBox(height: 20),

              CheckboxListTile(
                title: Text("I meet the minimum requirements"),
                value: _meetRequirements,
                onChanged: (value) {
                  setState(() => _meetRequirements = value ?? false);
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
            final (success, message) = widget.vm.createApplication(
              studentNumber: _studentNumberController.text,
              name: _nameController.text,
              surname: _surnameController.text,
              module: _selectedValueModule.toString(),
              academicLevel: _selectedValueYear.toString(),
              secondModule: _selectedValueModuleOption2 ?? "",
              meetRequirements: _meetRequirements,
            );

            _results = success;

            if (_results) {
              showDialog(
                context: context,
                builder: (context) =>
                    Dialog(child: PopUpSuccess(message: message)),
              ).then((_) => Navigator.pop(context));
            } else {
              showDialog(
                context: context,
                builder: (context) =>
                    Dialog(child: PopUpFailed(errorMessage: message)),
              ).then((_) => Navigator.pop(context));
            }
          }
        },
        child: Text("Submit", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}