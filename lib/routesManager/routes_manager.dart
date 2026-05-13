import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:group_u/viewModels/student_assistants_view_model.dart';
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
  static const String homeScreen = "/";
  static const String adminDelete = "/admin/delete";
  static const String adminRead = "/admin/read";
  static const String adminUpdate = "/admin/update";
  static const String applicationDetailsDelete = "/application/delete";
  static const String applicationDetailsRead = "/application/read";
  static const String authenticationScreen = "/authenticate";
  static const String studentAssistantFormCreate = "/student_assistant/create";
  static const String studentAssistantFormUpdate = "/student_assistant/update";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());

      case adminDelete:
        return MaterialPageRoute(builder: (context) => AdminDelete());

      case adminRead:
        return MaterialPageRoute(builder: (context) => AdminRead());

      case adminUpdate:
        return MaterialPageRoute(
          builder: (context) => AdminUpdate(index: settings.arguments as int),
        );

      case applicationDetailsDelete:
        return MaterialPageRoute(
          builder: (context) => ApplicationDetailsDelete(),
        );

      case applicationDetailsRead:
        return MaterialPageRoute(
          builder: (context) => ApplicationDetailsRead(),
        );

      case authenticationScreen:
        return MaterialPageRoute(builder: (context) => AuthenticationScreen());

      case studentAssistantFormCreate:
        return MaterialPageRoute(
          builder: (context) => StudentAssistantFormCreate(
            vm: settings.arguments as StudentAssistantsViewModel,
          ),
        );

      case studentAssistantFormUpdate:
        return MaterialPageRoute(
          builder: (context) =>
              StudentAssistantFormUpdate(index: settings.arguments as int),
        );

      default:
        throw Exception();
    }
  }
}
