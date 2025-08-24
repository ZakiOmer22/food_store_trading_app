import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onProfileTap;
  final ValueChanged<String>? onSearch;

  const HomeHeader({
    super.key,
    this.onMenuTap,
    this.onProfileTap,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF8BC34A), Color(0xFFA5D6A7)], // green gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30), // smooth curve like reference
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left menu button
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white, size: 28),
            onPressed: onMenuTap,
          ),

          // Search box
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey, size: 22),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      onChanged: onSearch,
                      decoration: const InputDecoration(
                        hintText: "Search product, kit or brand...",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Profile button
          GestureDetector(
            onTap: onProfileTap,
            child: const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("assets/images/profile.png"),
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
