import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PickerField extends StatelessWidget {
  const PickerField({
    required this.onPressed,
    required this.iconPath,
    required this.controller,
    required this.validator,
    super.key,
  });

  final VoidCallback onPressed;
  final String iconPath;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            iconPath,
            color: Theme.of(context).primaryColor.withOpacity(0.6),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: IgnorePointer(
              child: TextFormField(
                validator: validator,
                readOnly: true,
                controller: controller,
                style: TextStyle(
                  color: Theme.of(context).primaryColor.withOpacity(0.6),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor.withOpacity(0.6),
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor.withOpacity(0.6),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor.withOpacity(0.6),
                    ),
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.only(bottom: 10, top: 4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
