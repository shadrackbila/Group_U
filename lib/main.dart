import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:group_u/viewModels/auth_view_model.dart';
import 'package:group_u/viewModels/student_assistants_view_model.dart';
import 'package:group_u/services/supabase_service.dart';
import 'package:group_u/views/authentication_screen.dart';
import 'package:group_u/views/home_screen.dart';
import 'package:group_u/views/admin_read.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL',      // Get from your Supabase project
    anonKey: 'YOUR_SUPABASE_ANON_KEY', // Get from your Supabase project
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
        home: Consumer<AuthViewModel>(
          builder: (context, authVM, child) {
            if (authVM.isLoggedIn) {
              // User is already logged in, go to appropriate screen
              if (authVM.currentUserRole == 'admin') {
                return const AdminReadScreen();
              } else {
                return const HomeScreen();
              }
            }
            return const AuthenticationScreen();
          },
        ),
      ),
    );
  }
}