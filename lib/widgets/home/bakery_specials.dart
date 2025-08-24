import 'package:flutter/material.dart';

class BakerySpecials extends StatefulWidget {
  const BakerySpecials({super.key});

  @override
  State<BakerySpecials> createState() => _BakerySpecialsState();
}

class _BakerySpecialsState extends State<BakerySpecials> {
  final Set<String> favorites = {};

  final List<Map<String, String>> products = const [
    {
      "title": "White Bread",
      "image": "assets/images/products/bread.jpg",
      "price": "\$2.00",
    },
    {
      "title": "Baguette",
      "image": "assets/images/products/baguette.jpg",
      "price": "\$3.00",
    },
    {
      "title": "Croissant",
      "image": "assets/images/products/croissant.jpg",
      "price": "\$2.50",
    },
    {
      "title": "Donut",
      "image": "assets/images/products/donut.jpg",
      "price": "\$1.50",
    },
    {
      "title": "Muffin",
      "image": "assets/images/products/muffin.jpg",
      "price": "\$2.20",
    },
    {
      "title": "Bagel",
      "image": "assets/images/products/bagel.jpg",
      "price": "\$1.80",
    },
    {
      "title": "Cake Slice",
      "image": "assets/images/products/cake_slice.jpg",
      "price": "\$3.50",
    },
    {
      "title": "Brownie",
      "image": "assets/images/products/brownie.jpg",
      "price": "\$2.80",
    },
    {
      "title": "Cupcake",
      "image": "assets/images/products/cupcake.jpg",
      "price": "\$2.00",
    },
    {
      "title": "Danish Pastry",
      "image": "assets/images/products/danish_pastry.jpg",
      "price": "\$3.00",
    },
    {
      "title": "Brioche",
      "image": "assets/images/products/brioche.jpg",
      "price": "\$2.50",
    },
    {
      "title": "Pita Bread",
      "image": "assets/images/products/pita_bread.jpg",
      "price": "\$1.90",
    },
    {
      "title": "Focaccia",
      "image": "assets/images/products/focaccia.jpg",
      "price": "\$3.20",
    },
    {
      "title": "Sourdough",
      "image": "assets/images/products/sourdough.jpg",
      "price": "\$3.00",
    },
    {
      "title": "Cinnamon Roll",
      "image": "assets/images/products/cinnamon_roll.jpg",
      "price": "\$2.50",
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
            "Bakery Specials",
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
