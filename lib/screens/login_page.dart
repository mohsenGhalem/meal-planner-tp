import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tp02/components/utils.dart';
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
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
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
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.person),
                  controller: emailController,
                  validator: myValidateEmailFct,
                ),
                MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController,
                  prefixIcon: const Icon(Icons.lock),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password Can't be empty";
                    }
                    return null;
                  },
                ),
                isLoading
                    ? const LoadingWidget()
                    : Column(
                      children: [
                        MyButton(
                          label: "Login",
                          onPressed: login,
                        ),
                        MyTextButton(
                          label: "Forget my password ?",
                          onPressed: ()=>Navigator.of(context).pushNamed('/forgot'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Dont have an account ?"),
                            MyTextButton(
                              label: "Sign up",
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/signup');
                              },
                            ),
                          ],
                        ),
                      ])
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    try {
      if (myFormState.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        final firebaseAuth = FirebaseAuth.instance;
        await firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          throw Exception("The state isn't availlable");
        }
      }
    } on FirebaseAuthException catch (error) {
      if (mounted) {
        buildSnackBar(
            context: context, title: error.message ?? 'An error Occured');
      }
    } catch (e) {
      if (mounted) {
        buildSnackBar(context: context, title: e.toString());
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
