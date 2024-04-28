import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/utils.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> myFormState = GlobalKey();
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Reset Password'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
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
                  "Reset Password",
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 20),
                MyTextField(
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.person),
                  controller: emailController,
                  validator: myValidateEmailFct,
                ),
                isLoading
                    ? const LoadingWidget()
                    : MyButton(
                        label: "Send reset link",
                        onPressed: resetPassword,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  resetPassword() async {
    try {
      if (myFormState.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        final firebaseAuth = FirebaseAuth.instance;
        firebaseAuth.sendPasswordResetEmail(email: emailController.text);

        if (mounted) {
          buildSnackBar(
              context: context, title: 'An email has been sent to your inbox');
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      buildSnackBar(context: context, title: e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
