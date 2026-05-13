import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
// final StudentAssistantsViewModel _assistantsViewModel =
  //    StudentAssistantsViewModel();

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
          child: ListView(
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
                  DropdownMenuItem(value: "TPG316", child: Text("TPG316")),
                  DropdownMenuItem(value: "SOD316", child: Text("SOD316")),
                  DropdownMenuItem(value: "SOE316", child: Text("SOE316")),
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
                  DropdownMenuItem(value: "CMN316", child: Text("CMN316")),
                  DropdownMenuItem(value: "SSE316", child: Text("SSE316")),
                  DropdownMenuItem(value: "MAT316", child: Text("MAT316")),
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
        onPressed: () async {
          if(_formKey.currentState!.validate()){
            
            await Provider.of<StudentAssistantsViewModel>(
              context,
              listen: false,
            ).createApplication(
              name: _nameController.text,
              surname: _surnameController.text,
              academicLevel: _selectedValueYear.toString(), 
              module: _selectedValueModule.toString(), 
              secondModule: _selectedValueYear.toString(), 
              secondModuleLevel: _selectedValueYear.toString(), 
              meetRequirements: true,
              );

              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context)
              .showSnackBar(
                const SnackBar(content: 
                Text("Application Submitted"),
                )
              );
          }
        },
        child: Text("Submit", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
