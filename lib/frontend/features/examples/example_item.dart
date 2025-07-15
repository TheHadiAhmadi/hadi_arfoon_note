import 'package:flutter/material.dart';

class ExampleItem extends StatelessWidget {
  const ExampleItem(
      {super.key,
      required this.title,
      required this.description,
      required this.onTap});

  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: ConstrainedBox(
            constraints: const BoxConstraints(),
            child: Padding(
              padding: const EdgeInsetsGeometry.symmetric(
                  horizontal: 24, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                  ),
                ],
              ),
            )));
  }
}
