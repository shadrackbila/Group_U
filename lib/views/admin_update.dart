import 'package:flutter/material.dart';
import 'package:group_u/Components/pop_up_failed.dart';
import 'package:group_u/Components/pop_up_success.dart';
import 'package:group_u/viewModels/student_assistants_view_model.dart';
import 'package:provider/provider.dart';

class AdminUpdate extends StatefulWidget {
  final int index;
  const AdminUpdate({super.key, required this.index});

  @override
  State<AdminUpdate> createState() => _AdminUpdateState();
}

class _AdminUpdateState extends State<AdminUpdate> {
  String? _status;
  final _formKey = GlobalKey<FormState>();
  bool _results = false;

  late StudentAssistantsViewModel _assistantsViewModel;

  @override
  void initState() {
    super.initState();
    _assistantsViewModel = context.read<StudentAssistantsViewModel>();

    final existing = _assistantsViewModel.applications[widget.index];
    _status = existing.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Application",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 10),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Status",
                  border: OutlineInputBorder(),
                ),

                items: [
                  DropdownMenuItem(value: "pending", child: Text("Pending")),
                  DropdownMenuItem(value: "accepted", child: Text("Accept")),
                  DropdownMenuItem(value: "rejected", child: Text("Reject")),
                ],
                onChanged: (value) {
                  setState(() {
                    _status = value;
                  });
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
            final (success, message) = _assistantsViewModel.updateApplication(
              index: widget.index,
              status: _status,
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
