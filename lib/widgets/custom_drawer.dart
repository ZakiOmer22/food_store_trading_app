import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final BuildContext contextRef;
  const AppDrawer({super.key, required this.contextRef});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(cs),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _drawerItem(Icons.home, "Home", "/"),
                  _drawerItem(Icons.grid_view_rounded, "Products", "/products"),
                  _drawerItem(Icons.shopping_cart, "Cart", "/cart"),
                  _drawerItem(Icons.local_offer, "Deals & Offers", "/deals"),
                  _drawerItem(Icons.fastfood, "Daily Meals", "/daily-meals"),
                  _drawerItem(
                    Icons.restaurant_menu,
                    "Categories",
                    "/categories",
                  ),
                  _drawerItem(Icons.person, "Profile", "/profile"),
                  _drawerItem(Icons.favorite, "Favorites", "/favorites"),
                  _drawerItem(Icons.receipt_long, "Orders History", "/orders"),
                  _drawerItem(Icons.settings, "Settings", "/settings"),
                  _drawerItem(Icons.help_rounded, "Help & Support", "/support"),
                  _drawerItem(Icons.info_outline, "About Us", "/about"),
                ],
              ),
            ),
            const Divider(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme cs) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primary, cs.primaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage(
              'assets/images/universities/placeholder.png',
            ),
            backgroundColor: Colors.white,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "eALIF Store",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "POS Front Store",
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
                const SizedBox(height: 8),
                // Animated, continuously moving progress bar
                LinearProgressIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.white24,
                  minHeight: 4,
                  value: null, // null makes it continuously animated
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String label, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: Colors.grey.shade800),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: Colors.grey.shade200.withOpacity(0.3),
        onTap: () => Navigator.pushNamed(contextRef, route),
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/icon.png', width: 18, height: 18),
          const SizedBox(width: 8),
          Text(
            "Powered by eALIF Team",
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
