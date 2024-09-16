import 'package:flutter/material.dart';

class MessageDateItem extends StatelessWidget {
  final String date;

  const MessageDateItem({super.key, required this.date});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            date,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}
