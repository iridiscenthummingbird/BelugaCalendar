import 'package:beluga_calendar/flows/main/domain/entities/category.dart';
import 'package:beluga_calendar/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EventsFilterButton extends StatelessWidget {
  const EventsFilterButton({
    required this.onChanged,
    required this.categories,
    required this.currentCategoryId,
    super.key,
  });

  final ValueChanged<String?> onChanged;
  final List<Category> categories;
  final String currentCategoryId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 107,
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          alignment: Alignment.centerRight,
          value: currentCategoryId,
          elevation: 0,
          isDense: true,
          icon: SvgPicture.asset(Assets.icons.dropDown.path),
          items: [
            const DropdownMenuItem<String>(
              value: '',
              child: Text(
                'All events',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ...categories.map(
              (c) => DropdownMenuItem<String>(
                value: c.id,
                child: Text(
                  c.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ).toList(),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
