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
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null
          ? onTap!.call()
          : () {
              print(itemText);
            },
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
              style: Theme.of(context).primaryTextTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
