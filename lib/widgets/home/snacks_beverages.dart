import 'package:flutter/material.dart';

class SnacksBeverages extends StatefulWidget {
  const SnacksBeverages({super.key});

  @override
  State<SnacksBeverages> createState() => _SnacksBeveragesState();
}

class _SnacksBeveragesState extends State<SnacksBeverages> {
  final Set<String> favorites = {};

  final List<Map<String, String>> products = const [
    {
      "title": "Chips",
      "image": "assets/images/products/chips.jpg",
      "price": "\$1.50",
    },
    {
      "title": "Chocolate Bar",
      "image": "assets/images/products/chocolate.jpg",
      "price": "\$2.00",
    },
    {
      "title": "Cookies",
      "image": "assets/images/products/cookies.jpg",
      "price": "\$2.50",
    },
    {
      "title": "Soda",
      "image": "assets/images/products/soda.jpg",
      "price": "\$1.20",
    },
    {
      "title": "Juice",
      "image": "assets/images/products/juice.jpg",
      "price": "\$2.00",
    },
    {
      "title": "Water Bottle",
      "image": "assets/images/products/water.jpg",
      "price": "\$1.00",
    },
    {
      "title": "Energy Drink",
      "image": "assets/images/products/energy_drink.jpg",
      "price": "\$2.50",
    },
    {
      "title": "Candy",
      "image": "assets/images/products/candy.jpg",
      "price": "\$1.20",
    },
    {
      "title": "Peanuts",
      "image": "assets/images/products/peanuts.jpg",
      "price": "\$1.50",
    },
    {
      "title": "Trail Mix",
      "image": "assets/images/products/trail_mix.jpg",
      "price": "\$2.80",
    },
    {
      "title": "Crackers",
      "image": "assets/images/products/crackers.jpg",
      "price": "\$2.00",
    },
    {
      "title": "Ice Tea",
      "image": "assets/images/products/ice_tea.jpg",
      "price": "\$1.80",
    },
    {
      "title": "Smoothie",
      "image": "assets/images/products/smoothie.jpg",
      "price": "\$3.00",
    },
    {
      "title": "Popcorn",
      "image": "assets/images/products/popcorn.jpg",
      "price": "\$1.50",
    },
    {
      "title": "Granola Bar",
      "image": "assets/images/products/granola_bar.jpg",
      "price": "\$2.20",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Snacks & Beverages",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final isFavorite = favorites.contains(product["title"]);
              return Container(
                width: 150,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isFavorite) {
                              favorites.remove(product["title"]);
                            } else {
                              favorites.add(product["title"]!);
                            }
                          });
                        },
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey[600],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          product["image"]!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product["title"]!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product["price"]!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
