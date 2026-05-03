import 'package:flutter/material.dart';
import 'package:group_u/routesManager/routes_manager.dart';
import 'package:group_u/viewModels/student_assistants_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => StudentAssistantsViewModel(),
      child: MaterialApp(
        initialRoute: RouteManager.homeScreen,
        onGenerateRoute: RouteManager.generateRoute,
      ),
    ),
  );
}
