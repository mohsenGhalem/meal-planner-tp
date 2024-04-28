import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_text_button.dart';
import '../components/my_textfield.dart';
import '../components/utils.dart';

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

  bool isLoading = false;

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
                isLoading
                    ? const LoadingWidget()
                    : Column(
                        children: [
                          MyButton(
                            label: "Sign up",
                            onPressed: signup,
                          ),
                          const SizedBox(height: 15),
                          const Text("OR"),
                          const SizedBox(height: 15),
                          MyButton(
                            label: "Sign up with Google",
                            onPressed: signupWithGoogle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account?"),
                              MyTextButton(
                                label: "Login",
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/login');
                                },
                              ),
                            ],
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

  signupWithGoogle() async {
    try {
      final firebaseAuth = FirebaseAuth.instance;

      // const List<String> scopes = <String>[
      //   'ghalemmohsen@gmail.com',
      //   'https://www.googleapis.com/auth/contacts.readonly',
      // ];

      // GoogleSignIn googleSignIn = GoogleSignIn(
      //   // Optional clientId
      //   // clientId: 'your-client_id.apps.googleusercontent.com',
      //   scopes: scopes,
      // );
      // await googleSignIn.signIn();
      await firebaseAuth.signInWithProvider(GoogleAuthProvider());
    } catch (e) {
      if (mounted) {
        buildSnackBar(context: context, title: e.toString());
      }
    }
  }

  signup() async {
    try {
      if (myFormState.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        final firebaseAuth = FirebaseAuth.instance;
        final user = await firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        await user.user!.sendEmailVerification();
        if (mounted) {
          buildSnackBar(
              context: context,
              title: 'Please verify your email so you can login');
          Navigator.of(context).pushReplacementNamed('/login');
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
