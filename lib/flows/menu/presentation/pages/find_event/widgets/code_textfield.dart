import 'package:flutter/material.dart';

class CodeTextField extends StatelessWidget {
  const CodeTextField({
    this.controller,
    super.key,
  });
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Theme.of(context).primaryColor,
      style: TextStyle(
        fontSize: 16,
        color: Theme.of(context).primaryColor,
      ),
      decoration: InputDecoration(
        errorStyle: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).errorColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).errorColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor.withOpacity(0.6),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        labelText: 'Enter code',
        labelStyle: TextStyle(
          fontSize: 16,
          color: Theme.of(context).primaryColor,
        ),
      ),
      validator: (value) {
        if (value!.length < 6) {
          return 'Code should be at least 6 symbols';
        }
        return null;
      },
    );
  }
}
