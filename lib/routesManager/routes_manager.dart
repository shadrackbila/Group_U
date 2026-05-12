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
  static const String applicationDetailsDelete = "";
  static const String applicationDetailsRead = "";
  static const String authenticationScreen = "/authenticate";
  static const String studentAssistantFormCreate = "/student_assistant/create";
  static const String studentAssistantFormUpdate = "/student_assistant/update";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case adminDelete:
        return MaterialPageRoute(builder: (_) => AdminDelete());

      case adminRead:
        return MaterialPageRoute(builder: (_) => AdminRead());

      case adminUpdate:
        return MaterialPageRoute(builder: (_) => AdminUpdate());

      case applicationDetailsDelete:
        return MaterialPageRoute(builder: (_) => ApplicationDetailsDelete());

      case applicationDetailsRead:
        return MaterialPageRoute(builder: (_) => ApplicationDetailsRead());

      case authenticationScreen:
        return MaterialPageRoute(builder: (_) => AuthenticationScreen());

      case studentAssistantFormCreate:
        return MaterialPageRoute(
          builder: (_) => StudentAssistantFormCreate(
            vm: settings.arguments as StudentAssistantsViewModel,
          ),
        );

      case studentAssistantFormUpdate:
        return MaterialPageRoute(
          builder: (_) => StudentAssistantFormUpdate(
            // vm: settings.arguments as StudentAssistantsViewModel,
          ),
        );

      default:
        throw Exception();
    }
  }
}
