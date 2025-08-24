import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String) onChanged;
  final Function(String) onCategoryChanged;

  const SearchBarWidget({
    super.key,
    required this.onChanged,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              onChanged: onChanged,
            ),
          ),
          const SizedBox(width: 8),
          DropdownButton<String>(
            value: "All",
            items: const [
              DropdownMenuItem(value: "All", child: Text("All")),
              DropdownMenuItem(
                value: "Electronics",
                child: Text("Electronics"),
              ),
              DropdownMenuItem(value: "Fashion", child: Text("Fashion")),
              DropdownMenuItem(
                value: "Accessories",
                child: Text("Accessories"),
              ),
            ],
            onChanged: (value) {
              if (value != null) onCategoryChanged(value);
            },
          ),
        ],
      ),
    );
  }
}
