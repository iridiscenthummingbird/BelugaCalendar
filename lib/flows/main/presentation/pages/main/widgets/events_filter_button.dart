import 'package:beluga_calendar/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EventsFilterButton extends StatelessWidget {
  const EventsFilterButton({
    required this.onButtonPressed,
    super.key,
  });

  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onButtonPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 107,
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: 'All events',
                elevation: 0,
                isDense: true,
                icon: SvgPicture.asset(Assets.icons.dropDown.path),
                items: const [
                  DropdownMenuItem<String>(
                    value: 'All events',
                    child: Text(
                      'All events',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Study',
                    child: Text(
                      'Study',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Work',
                    child: Text(
                      'Work',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Relax',
                    child: Text(
                      'Relax',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                onChanged: (value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
