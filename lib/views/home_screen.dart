import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  
import 'package:group_u/Components/pop_up.dart';
import 'package:group_u/routesManager/routes_manager.dart';
import 'package:group_u/viewModels/auth_view_model.dart';  
import 'package:group_u/views/authentication_screen.dart';  

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ADD THIS METHOD HERE
  void _logout(BuildContext context) async {
    final authVM = Provider.of<AuthViewModel>(context, listen: false);
    await authVM.logout();
    if (context.mounted) {  
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthenticationScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Applications", style: TextStyle(color: Colors.white)),
        centerTitle: false,
        backgroundColor: Colors.blue,
        
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => _logout(context),
            tooltip: 'Logout',
          ),
        ],
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
                  subtitle: const Text("Status: "),
                  trailing: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(141, 255, 214, 64),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: const Text(
                      "Pending",
                      style: TextStyle(
                        color: Color.fromARGB(255, 123, 93, 2),
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
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}