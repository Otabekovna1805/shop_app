import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/screen/home.dart';
import 'package:shop_app/screen/registration_page.dart';

import '../model/user_model.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Enter Email',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.grey, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                    const BorderSide(color: Colors.black, width: 2)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Enter Password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.grey, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                    const BorderSide(color: Colors.black, width: 2)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: buttonLogin,
              style: Theme.of(context).elevatedButtonTheme.style,
              child: const Text(
                'Registration',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                  children:[
                    const TextSpan(
                        text: "Don't have an account ",
                        style: TextStyle(color: Colors.black)
                    ),
                    TextSpan(
                      text: 'Registration',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()..onTap = gotoRegistration,
                    ),

                  ]
              ),
            )
          ],
        ),
      ),
    );
  }
  void gotoRegistration() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RegistrationPage()));
  }

  void buttonLogin() async {
    List<Map<String, Object?>> response = auth.getData;
    List<User> users = response.map((e) => User.fromJson(e)).toList();
    List<User> haveUser = users.where((user) {
      return user.email == emailController.text.trim() && user.password == passwordController.text.trim();
    }).toList();

    if(haveUser.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User Not Found')));
    } else {
      await auth.saveUser(haveUser[0]);
      if(context.mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Homes()));
      }
    }
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
