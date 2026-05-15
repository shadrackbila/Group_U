import 'package:flutter/material.dart';
import 'package:group_u/viewmodels/application_viewmodel.dart';
import 'package:group_u/viewmodels/auth_viewmodel.dart';
import '../../utils/app_routes.dart';
import 'package:provider/provider.dart';

/**
 * Student Numbers : 223048044, 222049725, 223022994,223014209,224131946
 * Student Names : Shadrack Bila, Lerato Gladys Molefe,Marcus Mhlambi,Lisa Sandi,Lahluma Maselana
 * Question : Home screen
 */

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load applications when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ApplicationViewModel>().loadApplications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        title: const Text(
          'Student Assistant Portal',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          // REFRESH
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context
                  .read<ApplicationViewModel>()
                  .loadApplications(); // ✅ correct VM
            },
          ),
          // LOGOUT
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await context.read<AuthViewModel>().signOut();
              if (mounted) {
                // ✅ works now — StatefulWidget
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1565C0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.school, color: Colors.white, size: 50),
                  SizedBox(height: 15),
                  Text(
                    'Welcome Student',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Apply for Student Assistant positions '
                    'for your academic modules.',
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Student Assistant Rules',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Padding(
                padding: EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RuleTile(
                        text: 'A student may submit only ONE application.'),
                    RuleTile(text: 'A maximum of TWO modules may be selected.'),
                    RuleTile(text: 'Supporting document upload is required.'),
                    RuleTile(
                        text: 'Applications can only be edited while pending.'),
                    RuleTile(
                        text:
                            'Eligibility approval is handled by admin staff.'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // APPLY NOW BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  'Apply Now',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.applicationForm);
                },
              ),
            ),

            const SizedBox(height: 15),

            // VIEW MY APPLICATION BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.visibility),
                label: const Text(
                  'View My Applications',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  final vm = context.read<ApplicationViewModel>();

                  if (vm.applications.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No application found.')),
                    );
                    return;
                  }

                  Navigator.pushNamed(
                    context,
                    AppRoutes.applicationDetails,
                    arguments:
                        vm.applications.first, // ✅ passes the ApplicationModel
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RuleTile extends StatelessWidget {
  final String text;
  const RuleTile({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 15)),
          ),
        ],
      ),
    );
  }
}
