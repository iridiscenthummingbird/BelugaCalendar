import 'package:flutter/material.dart';

class FindEventPage extends StatelessWidget {
  const FindEventPage({super.key});

  static const String path = '/find_event';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Find Event',
        ),
      ),
    );
  }
}
