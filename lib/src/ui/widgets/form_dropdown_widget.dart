import 'package:flutter/material.dart';

import '../../colors.dart';

class FormDropdownWidget extends StatelessWidget {
  final String? title; 
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  const FormDropdownWidget({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.title, 
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (title != null)
            Text(
              title!,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          
        ],
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 8,
          ).copyWith(
            left: 15,
          ),
          child: SizedBox(
            height: 45,
            child: DropdownButton(
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.red,
                ),
                items: items
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Center(
                          child: Text(
                            e,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                value: value,
                onChanged: onChanged),
          ),
        ),
      ),
    ]);
  }
}
