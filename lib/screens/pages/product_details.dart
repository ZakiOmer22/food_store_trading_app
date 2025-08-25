import 'package:flutter/material.dart';
import 'package:trading_app/models/cart_manager.dart';
import 'package:trading_app/screens/pages/cart_page.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  // Theme (GREEN instead of orange)
  static const Color kAccent = Colors.green;

  // Mock product
  final String productName = "Basmati Rice";
  final String productImage = "assets/images/products/rice.jpg";
  final double unitPrice = 12.99;

  int qty = 1;
  String selectedSize = "5kg";
  final List<String> sizes = ["1kg", "5kg", "10kg"];

  bool isFavorite = false; // ✅ toggle for heart
  List<Map<String, dynamic>> cart = []; // ✅ mock cart storage

  double get total => unitPrice * qty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xFFEEF2FF), Color(0xFFFFFFFF)],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      _roundIcon(
                        icon: Icons.arrow_back_ios_new_rounded,
                        onTap: () => Navigator.pop(context), // ✅ back works
                      ),
                      const Spacer(),
                      const Text(
                        "Product Details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      _roundIcon(
                        icon: isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        iconColor: kAccent,
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite; // ✅ toggle fav
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isFavorite
                                    ? "Added to favorites"
                                    : "Removed from favorites",
                              ),
                              backgroundColor: kAccent,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Big Product Image
                        Container(
                          height: 300,
                          margin: const EdgeInsets.only(bottom: 18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.asset(
                            productImage,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),

                        // Name + Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                productName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              "\$${unitPrice.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: kAccent,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Size + Rating
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              spacing: 8,
                              children: sizes
                                  .map(
                                    (s) => _sizeChip(
                                      label: s,
                                      selected: selectedSize == s,
                                      onTap: () => setState(() {
                                        selectedSize = s;
                                      }),
                                    ),
                                  )
                                  .toList(),
                            ),
                            const _ratingChip(ratingText: "4.9 (210)"),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Info Pills
                        Row(
                          children: const [
                            _infoPill(
                              icon: Icons.local_fire_department_rounded,
                              iconColor: Colors.red,
                              text: "120 kcal/100g",
                            ),
                            SizedBox(width: 10),
                            _infoPill(
                              icon: Icons.access_time_rounded,
                              iconColor: Colors.blue,
                              text: "Fast Delivery",
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Description
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Text(
                            "Premium long-grain Basmati rice, perfect for biryani, pilaf, and everyday meals. "
                            "Naturally aromatic, aged for flavor, and carefully packed to lock in freshness.",
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.6,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Recommended
                        const Text(
                          "Recommended for you",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),

                        SizedBox(
                          height: 150,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            children: const [
                              _RecommendedCard(
                                title: "Olive Oil",
                                price: "\$8.99",
                                img: "assets/images/products/oil.jpg",
                              ),
                              _RecommendedCard(
                                title: "Muffin",
                                price: "\$2.70",
                                img: "assets/images/products/muffin.jpg",
                              ),
                              _RecommendedCard(
                                title: "Oreo",
                                price: "\$1.60",
                                img: "assets/images/products/oreo.jpg",
                              ),
                              _RecommendedCard(
                                title: "Cheddar Cheese",
                                price: "\$9.40",
                                img: "assets/images/products/cheese.jpg",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Qty stepper
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        _stepperBtn(
                          icon: Icons.remove_rounded,
                          onTap: () => setState(() {
                            if (qty > 1) qty--;
                          }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "$qty",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        _stepperBtn(
                          icon: Icons.add_rounded,
                          onTap: () => setState(() => qty++),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Total
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                        Text(
                          "\$${total.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // CTA
                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                      ),
                      onPressed: () {
                        // ✅ Add to cart
                        final cartManager = CartManager();
                        cartManager.addItem(
                          {
                            "name": productName,
                            "qty": qty,
                            "price": unitPrice,
                            "size": selectedSize,
                          },
                          id: productName, // Use a unique ID for the product
                          name: productName,
                          image: productImage,
                          price: unitPrice,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "$productName added to cart ($qty x $selectedSize)",
                            ),
                            backgroundColor: kAccent,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => CartPage()),
                        );
                      },
                      child: const Text(
                        "Add to Cart",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---- UI helpers ----

  Widget _roundIcon({
    required IconData icon,
    Color bg = Colors.white,
    Color iconColor = Colors.black87,
    VoidCallback? onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }

  Widget _sizeChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? kAccent : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kAccent),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : kAccent,
          ),
        ),
      ),
    );
  }

  Widget _stepperBtn({required IconData icon, required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(icon, size: 20, color: kAccent),
        ),
      ),
    );
  }
}

// Small pill with icon + text
class _infoPill extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;
  const _infoPill({
    required this.icon,
    required this.iconColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

// Rating chip
class _ratingChip extends StatelessWidget {
  final String ratingText;
  const _ratingChip({required this.ratingText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.star_rounded, size: 18, color: Colors.orange),
          const SizedBox(width: 6),
          Text(
            ratingText,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

// Recommended item card
class _RecommendedCard extends StatelessWidget {
  final String title;
  final String price;
  final String img;
  const _RecommendedCard({
    required this.title,
    required this.price,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Expanded(
            child: Image.asset(img, fit: BoxFit.cover, width: double.infinity),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 13,
                    color: _ProductDetailPageState.kAccent,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
