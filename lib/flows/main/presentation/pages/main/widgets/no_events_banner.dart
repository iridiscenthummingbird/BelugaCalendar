import 'package:beluga_calendar/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class NoEventsBanner extends StatelessWidget {
  const NoEventsBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Flexible(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Assets.noEvents.path),
                  const Padding(
                    padding: EdgeInsets.only(top: 24, bottom: 12),
                    child: Text(
                      'No events',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    'Create your first event',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColorDark.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Flexible(
            child: SizedBox(),
          )
        ],
      ),
    );
  }
}
