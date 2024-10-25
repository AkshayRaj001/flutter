import 'package:ecommerce/controller/loginProvider.dart';
import 'package:ecommerce/pages/bottomNavigationbar.dart';
import 'package:ecommerce/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    final auth = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: mediaSize.height,
            decoration: BoxDecoration(
              color: myColor,
            ),
          ),
          Positioned(
            top: 80,
            width: mediaSize.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
             
                Text(
                  "SHOPE ME",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      letterSpacing: 2),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: mediaSize.width,
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyle(
                            color: myColor,
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          "Please login with your information",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 60),
                        const Text(
                          "Username ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.done),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an user name';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          "Password",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.remove_red_eye),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            if (value.length < 4) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: rememberUser,
                                  onChanged: (value) {
                                    setState(() {
                                      rememberUser = value!;
                                    });
                                  },
                                ),
                                const Text(
                                  "Remember me",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text("I forgot my password"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await auth.login(usernameController.text,
                                  passwordController.text);
                              auth.loginResponse!.message == 'Login successful'
                                  ? Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CustomBottomNavigationBar()))
                                  : ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              auth.loginResponse?.message ??
                                                  'error')));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          auth.loginResponse?.message ??
                                              'error')));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            elevation: 20,
                            shadowColor: myColor,
                            minimumSize: const Size.fromHeight(60),
                          ),
                          child: const Text("LOGIN"),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
