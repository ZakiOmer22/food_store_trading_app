import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trading_app/models/cart_manager.dart';
import 'package:ionicons/ionicons.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartManager>(
      builder: (context, cartManager, _) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                24,
              ), // Rounded corners for the whole bar
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(icon: Ionicons.home_outline, index: 0),
                _navItem(icon: Ionicons.storefront_outline, index: 1),
                _navItem(icon: Ionicons.heart_outline, index: 2),
                _cartNavItem(
                  icon: Ionicons.cart_outline,
                  index: 3,
                  cartCount: cartManager.totalItems,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _navItem({required IconData icon, required int index}) {
    bool selected = index == currentIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Icon(
          icon,
          color: selected ? Colors.green : Colors.grey,
          size: 28,
        ),
      ),
    );
  }

  Widget _cartNavItem({
    required IconData icon,
    required int index,
    required int cartCount,
  }) {
    bool selected = index == currentIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Icon(
              icon,
              color: selected ? Colors.green : Colors.grey,
              size: 28,
            ),
          ),
          if (cartCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  cartCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
