import 'package:flutter/material.dart';
import 'package:group_u/routesManager/routes_manager.dart';
import 'package:group_u/viewModels/student_assistants_view_model.dart';
import 'package:provider/provider.dart';

import 'routesManager/routes_manager.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => StudentAssistantsViewModel(),
      child: const MaterialApp(
      //initialRoute: RouteManager.homeScreen,
      //onGenerateRoute: RouteManager.generateRoute,
      ),
    ),
  );
}

class MaterialApp extends StatelessWidget{
  const MaterialApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
     debugShowCheckedModeBanner: false,
     title: 'Student Assistant System',
     initialRoute: RouteManager.authenticationScreen,
     onGenerateRoute: RouteManager.generateRoute,

    );
  }
}