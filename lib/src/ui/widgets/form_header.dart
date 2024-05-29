import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback clearForm;
  const FormHeader({
    super.key,
    required this.image,
    required this.title,
    required this.clearForm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffe1e1e1),
      padding: const EdgeInsets.only(
        right: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 175,
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.black,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
