import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  
import 'package:group_u/viewModels/auth_view_model.dart';  
import 'package:group_u/views/authentication_screen.dart';  

class AdminReadScreen extends StatelessWidget {
  const AdminReadScreen({super.key});

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
        title: const Text("Admin Dashboard"),
        actions: [  // Add this
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      // admin screen content here
    );
  }
}