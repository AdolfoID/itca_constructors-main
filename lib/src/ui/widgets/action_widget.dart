import 'package:flutter/material.dart';

class ActionWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final VoidCallback onTap;
  const ActionWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Row(children: [
          Image.asset(
            image,
            width: 80,
            height: 100,
          ),
          Expanded(
            child: ListTile(
              title: Text(
                title,
                style: const TextStyle(
                  height: 1.1,
                ),
              ),
              subtitle: Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.1,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: onTap,
          ),
        ]),
      ),
    );
  }
}
