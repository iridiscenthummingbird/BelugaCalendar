import 'package:flutter/material.dart';

class CreateButton extends StatelessWidget {
  const CreateButton({
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(4),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'Create',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
