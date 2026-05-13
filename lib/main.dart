import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:group_u/viewModels/auth_view_model.dart';
import 'package:group_u/viewModels/student_assistants_view_model.dart';
import 'package:group_u/services/supabase_service.dart';
import 'package:group_u/routesManager/routes_manager.dart';  
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://oitkwvnzkvkgejplqxwf.supabase.co',      // Got from your Supabase project
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9pdGt3dm56a3ZrZ2VqcGxxeHdmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzgzMzU1NzAsImV4cCI6MjA5MzkxMTU3MH0.jqnyZED56aKVt_3778otjd74YO2dofBoGgIdOnaFXfg', // Got from your Supabase project
  );
  
  // Initialize the service with the Supabase client
  SupabaseService().initialize(Supabase.instance.client);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()..checkAuthStatus()),
        ChangeNotifierProvider(create: (_) => StudentAssistantsViewModel()),
      ],
      child: MaterialApp(
        title: 'Student Assistant Management',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: RouteManager.authenticationScreen,
        onGenerateRoute: RouteManager.generateRoute,
       
        ),
      );
  }
}