import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomMenuItem extends StatelessWidget {
  const CustomMenuItem({
    super.key,
    required this.itemText,
    required this.iconPath,
    this.onTap,
  });

  final String itemText;
  final String iconPath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              color: const Color(0xFFFFFFFF),
            ),
            const SizedBox(width: 12),
            Text(
              itemText,
              style: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(
                    color: Theme.of(context).primaryColorLight,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
