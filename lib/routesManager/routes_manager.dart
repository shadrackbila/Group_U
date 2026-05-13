// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:group_u/views/admin_delete.dart';
import 'package:group_u/views/admin_read.dart';
import 'package:group_u/views/admin_update.dart';
import 'package:group_u/views/application_details_delete.dart';
import 'package:group_u/views/application_details_read.dart';
import 'package:group_u/views/authentication_screen.dart';
import 'package:group_u/views/home_screen.dart';
import 'package:group_u/views/student_assistant_form_create.dart';
import 'package:group_u/views/student_assistant_form_update.dart';

class RouteManager {
  static const String homeScreen = "/home";
  static const String adminDelete = "/admin/delete";
  static const String adminRead = "/admin/read";
  static const String adminUpdate = "/admin/update";
  static const String applicationDetailsDelete = "/application/delete";
  static const String applicationDetailsRead = "/application/read";
  static const String authenticationScreen = "/authenticate";
  static const String studentAssistantFormCreate = "/student_assistant/create";
  static const String studentAssistantFormUpdate = "/student_assistant/update";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    print("Navigating to: ${settings.name}");
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case adminDelete:
        return MaterialPageRoute(builder: (_) => const AdminDelete());

      case adminRead:
        return MaterialPageRoute(builder: (_) => const AdminReadScreen());

      case adminUpdate:
        return MaterialPageRoute(builder: (_) => const AdminUpdate());

      case applicationDetailsDelete:
        return MaterialPageRoute(
          builder: (_) => const ApplicationDetailsDelete(),
        );

      case applicationDetailsRead:
        return MaterialPageRoute(
          builder: (_) => const ApplicationDetailsRead(),
        );

      case authenticationScreen:
        return MaterialPageRoute(builder: (_) => const AuthenticationScreen());

      case studentAssistantFormCreate:
        return MaterialPageRoute(
          builder: (_) => const StudentAssistantFormCreate(),
        );

      case studentAssistantFormUpdate:
        return MaterialPageRoute(
          builder: (_) => const StudentAssistantFormUpdate(),
        );

      default:
        // error handling
        print("Route not found: ${settings.name}");
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Route not found'),
                  Text('${settings.name}'),
                  ElevatedButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                      context,
                      RouteManager.authenticationScreen,
                    ),
                    child: const Text('Go to Login'),
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }
}
