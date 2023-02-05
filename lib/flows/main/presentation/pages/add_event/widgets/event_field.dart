import 'package:flutter/material.dart';

class EventField extends StatelessWidget {
  const EventField({
    required this.title,
    required this.controller,
    this.validator,
    this.focusNode,
    this.maxLength = 32,
    this.maxLines = 1,
    super.key,
  });

  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final int maxLength;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Theme.of(context).primaryColor,
      maxLength: maxLength,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: 16,
        color: Theme.of(context).primaryColor,
      ),
      focusNode: focusNode,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        errorStyle: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
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
        labelText: title,
        labelStyle: TextStyle(
          fontSize: 16,
          color: Theme.of(context).primaryColor,
        ),
      ),
      validator: validator,
    );
  }
}
