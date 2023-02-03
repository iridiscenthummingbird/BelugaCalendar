import 'package:beluga_calendar/services/email_validation.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
        labelText: 'Email',
        labelStyle: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      validator: (input) {
        if (input != null) {
          return input.isValidEmail() ? null : 'A valid email is required';
        }
        return null;
      },
    );
  }
}
