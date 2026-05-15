import 'package:flutter/material.dart';
import 'package:group_u/views/admin/admin_dashboard_screen.dart';
import 'package:group_u/views/student/application_detail_screen.dart';
import 'package:group_u/views/student/application_form_screen.dart';
import 'package:group_u/views/student/home_screen.dart';
import 'package:group_u/views/student/login_screen.dart';
import '../models/application_model.dart';

/**
 * Student Numbers : 223048044, 222049725, 223022994,223014209,224131946
 * Student Names : Shadrack Bila, Lerato Gladys Molefe,Marcus Mhlambi,Lisa Sandi,Lahluma Maselana
 * Question :   Routes Manager
 */

class AppRoutes {
  static const String login = '/';
  static const String home = '/home';
  static const String applicationDetails = '/application-details';
  static const String applicationForm = '/application-form';
  static const String adminDashboard = '/admin-dashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case home:
        return MaterialPageRoute(
          builder: (_) => const StudentHomeScreen(),
        );

      case applicationDetails:
        final app = settings.arguments as ApplicationModel?;
        return MaterialPageRoute(
          builder: (_) => ApplicationDetailsScreen(application: app!),
        );

      case applicationForm:
        final existing = settings.arguments as ApplicationModel?;
        return MaterialPageRoute(
          builder: (_) => ApplicationFormScreen(existing: existing),
        );

      case adminDashboard:
        return MaterialPageRoute(
          builder: (_) => const AdminDashboardScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 - Page not found')),
          ),
        );
    }
  }
}
