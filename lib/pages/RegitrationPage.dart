import 'package:ecommerce/controller/RegisterProvider.dart';
import 'package:ecommerce/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
   
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                header(context),
                inputFields(
                  context,
                  nameController,
                  emailController,
                  passwordController,
               
                  _formKey,
                ),
                loginInfo(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


Widget header(BuildContext context) {
  return Column(
    children: [
      Text(
        "Create Account",
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      ),
      SizedBox(height: 10),
      Text(
        "Enter details to get started",
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
      ),
    ],
  );
}

Widget inputFields(
  BuildContext context,
  TextEditingController nameController,
  TextEditingController emailController,
  TextEditingController passwordController,

  GlobalKey<FormState> formKey,
) {
    final registerProvider = Provider.of<RegisterProvider>(context);
    final isLoading = registerProvider.isLoading;
    final registerResponse = registerProvider.registerResponse;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      TextFormField(
        controller: nameController,
        decoration: InputDecoration(
          hintText: "Username",
          fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
          filled: true,
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your username";
          }
          return null;
        },
      ),
      SizedBox(height: 10),
      TextFormField(
        controller: emailController,
        decoration: InputDecoration(
          hintText: "Email",
          fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
          filled: true,
          prefixIcon: Icon(Icons.email_outlined),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your email";
          }
          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            return "Please enter a valid email address";
          }
          return null;
        },
      ),
      SizedBox(height: 10),
      TextFormField(
        controller: passwordController,
        decoration: InputDecoration(
          hintText: "Password",
          fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
          filled: true,
          prefixIcon: Icon(Icons.lock_outline),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
        ),
        obscureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your password";
          }
          if (value.length < 6) {
            return "Password must be at least 6 characters long";
          }
          return null;
        },
      ),
      SizedBox(height: 10),
     
      SizedBox(height: 20),
      ElevatedButton(
        onPressed: () async{
          if (formKey.currentState!.validate()) {
             
                     
                    await  registerProvider.registerUser(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                      );
              registerProvider.message == 'User registered successfully' ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage() )) :ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(registerProvider.message ??'error')),
            );  
           ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(registerProvider.message ??'error')));
          }
        },
        child: Text(
          "Sign Up",
          style: TextStyle(fontSize: 20),
        ),
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(vertical: 16),
       
        ),
      ),
    ],
  );
}

Widget loginInfo(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Already have an account?"),
      TextButton(
        onPressed: () {
         Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage(),));
        },
        child: Text(
          "Login",
          style: TextStyle(color: Colors.indigo),
        ),
      )
    ],
  );
}
