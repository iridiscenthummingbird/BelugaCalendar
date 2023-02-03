import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscuringCharacter: '*',
      obscureText: true,
      cursorColor: const Color(0xFFFFE500),
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      decoration: const InputDecoration(
        errorStyle: TextStyle(
          color: Color(0xFFFFE500),
          fontWeight: FontWeight.w500,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFFFE500),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFFFE500),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        labelText: 'Password',
        labelStyle: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      validator: (input) {
        if (input != null && input.isEmpty) {
          return 'A password is required';
        }
        if (input != null && input.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }
}
