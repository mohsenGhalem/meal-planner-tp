import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool obscureText;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;

  const MyTextField({
    super.key,
    this.validator,
    this.controller,
    this.obscureText=false,
    this.hintText,
    this.hintStyle,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        
        validator: validator,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: hintStyle,
            errorMaxLines: 5,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            filled: true,
            prefixIcon: prefixIcon),
      ),
    );
  }
}
