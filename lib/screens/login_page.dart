import 'package:flutter/material.dart';
import '../components/my_button.dart';
import '../components/my_text_button.dart';
import '../components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> myFormState = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: double.maxFinite,
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: SingleChildScrollView(
          child: Form(
            key: myFormState,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Welcome to my app",
                  style: TextStyle(fontSize: 30),
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/chef.png"),
                  radius: 50,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  hintText: "Username",
                  prefixIcon: const Icon(Icons.person),
                  controller: usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'you forgot to enter your username';
                    }
                    if (value.length < 4) {
                      return 'the username should be at least 4 characters';
                    }
                    return null;
                  },
                ),
                MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController,
                  prefixIcon: const Icon(Icons.lock),
                  validator: (value){
                    if (value==null || value.isEmpty) {
                      return "Password Can't be empty";
                    }
                    return null;
                  },
                ),
                MyButton(
                  label: "Login",
                  onPressed: () {
                    if (myFormState.currentState!.validate()) {
                      Navigator.of(context).pushReplacementNamed('/home');
                    }
                  },
                ),
                MyTextButton(
                  label: "Forget my password ?",
                  onPressed: () {},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Dont have an account ?"),
                    MyTextButton(
                      label: "Sign up",
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/signup');
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
