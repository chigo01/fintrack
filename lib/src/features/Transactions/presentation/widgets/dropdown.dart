import 'package:fintrack/src/core/domain/models/category.dart';
import 'package:flutter/material.dart';

DropdownButton<String> dropDown({
  required BuildContext context,
  required String? dropDownValue,
  required List<Category> categories,
  required Function(String?) onChanged,
  Widget? hint,
}) {
  return DropdownButton<String>(
    dropdownColor: Theme.of(context).scaffoldBackgroundColor,
    menuMaxHeight: 200,
    isExpanded: true,
    value: dropDownValue,
    hint: hint,
    items: categories
        .map((e) => e.title)
        .map<DropdownMenuItem<String>>(
          (value) => DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      letterSpacing: 2,
                    ),
              ),
            ),
          ),
        )
        .toList(),
    onChanged: onChanged,
  );
}
