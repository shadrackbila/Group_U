import 'package:flutter/material.dart';
import 'package:group_u/Components/pop_up.dart';
import 'package:group_u/routesManager/routes_manager.dart';

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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(child: PopUp()),
                    );
                  },
                  title: Text("item #: $index"),
                  subtitle: Text("Status: "),
                  trailing: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(141, 255, 214, 64),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Pending",
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
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteManager.studentAssistantFormCreate);
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
