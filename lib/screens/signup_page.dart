import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_text_button.dart';
import '../components/my_textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUpPage> {
  GlobalKey<FormState> myFormState = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  String? myValidateEmailFct(String? value) {
    const pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    final regex = RegExp(pattern);

    if (value!.isEmpty) {
      return "Email Can't be empty ";
    } else if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? myValidatePwdFct(String? value) {
    const pattern = r'^(?=.*[A-Z])(?=.*?[0-9])(?=.*?[ @#\&*~]) .{8,}';
    final regex = RegExp(pattern);
    if (value!.isEmpty) {
      return "Password Can't be empty ";
    } else if (!regex.hasMatch(value)) {
      return '''The password must be at least 8
            characters \n and should contain at least one upper case, \n one digit,
            one special character among (@#&*~)''';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: SingleChildScrollView(
          child: Form(
            key: myFormState,
            child: Column(
              children: [
                const Text(
                  "Create an account",
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(height: 20),
                MyTextField(
                  hintText: "Username",
                  controller: usernameController,
                  prefixIcon: const Icon(Icons.person),
                  validator: (value) {
                    if (value==null|| value.isEmpty) {
                      return 'you forgot to enter your username';
                    }
                    if (value.length<4) {
                      return 'the username should be at least 4 characters';
                    }
                    return null;
                  },
                ),
                MyTextField(
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  controller: emailController,
                  validator: myValidateEmailFct,
                ),
                MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController,
                  prefixIcon: const Icon(Icons.lock),
                  validator: myValidatePwdFct,
                ),
                MyTextField(
                  hintText: "Confirm Password",
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "you forgot to confirm your password";
                    }
                    if (value != passwordController.text) {
                      return "Password should be the same !";
                    }

                    return null;
                  },
                ),
                MyButton(
                  label: "Sign up",
                  onPressed: () {
                    if (myFormState.currentState!.validate()) {
                      Navigator.of(context).pushReplacementNamed('/home');
                    }
                  },
                ),
                const SizedBox(height: 15),
                const Text("OR"),
                const SizedBox(height: 15),
                MyButton(
                  label: "Sign up with Google",
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/home');
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    MyTextButton(
                      label: "Login",
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
