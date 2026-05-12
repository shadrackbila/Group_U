import 'package:flutter/material.dart';
import 'package:group_u/routesManager/routes_manager.dart';


class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => 
       _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen>{
  
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _editingController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context)
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authentication",
        style: TextStyle(color:Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      
      body:Padding(
        padding: const EdgeInsets.all(15)),
        
        child:Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller:_emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border:OutlineInputBorder(),
                )
                validator: 
              )
            ],

          )
        ),

    );

}