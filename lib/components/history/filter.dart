import 'package:flutter/material.dart';
import 'package:JAJA/database/database.dart';

class Filter extends StatelessWidget {
  final List<Category> filters;
  final List<Category> selectedFilters;
  final Function(Category) onChangeFilter;

  const Filter({
    super.key,
    required this.filters,
    required this.selectedFilters,
    required this.onChangeFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          return GestureDetector(
            onTap: () => onChangeFilter(filter),
            child: Chip(
              label: Text(filter.name),
              backgroundColor: selectedFilters.contains(filter) ? Colors.blue : Colors.grey.shade300,
              labelStyle: TextStyle(
                color: selectedFilters.contains(filter) ? Colors.white : Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }
}
