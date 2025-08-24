import 'package:flutter/material.dart';

class DairyProducts extends StatefulWidget {
  const DairyProducts({super.key});

  @override
  State<DairyProducts> createState() => _DairyProductsState();
}

class _DairyProductsState extends State<DairyProducts> {
  final Set<String> favorites = {};

  final List<Map<String, String>> products = const [
    {
      "title": "Milk",
      "image": "assets/images/products/milk.jpg",
      "price": "\$2.50",
    },
    {
      "title": "Cheese",
      "image": "assets/images/products/cheese.jpg",
      "price": "\$5.00",
    },
    {
      "title": "Yogurt",
      "image": "assets/images/products/yogurt.jpg",
      "price": "\$3.00",
    },
    {
      "title": "Butter",
      "image": "assets/images/products/butter.jpg",
      "price": "\$4.20",
    },
    {
      "title": "Cream",
      "image": "assets/images/products/cream.jpg",
      "price": "\$3.50",
    },
    {
      "title": "Eggs",
      "image": "assets/images/products/eggs.jpg",
      "price": "\$2.80",
    },
    {
      "title": "Cottage Cheese",
      "image": "assets/images/products/cottage_cheese.jpg",
      "price": "\$4.50",
    },
    {
      "title": "Ice Cream",
      "image": "assets/images/products/ice_cream.jpg",
      "price": "\$6.00",
    },
    {
      "title": "Sour Cream",
      "image": "assets/images/products/sour_cream.jpg",
      "price": "\$3.20",
    },
    {
      "title": "Ghee",
      "image": "assets/images/products/ghee.jpg",
      "price": "\$7.50",
    },
    {
      "title": "Kefir",
      "image": "assets/images/products/kefir.jpg",
      "price": "\$3.80",
    },
    {
      "title": "Powdered Milk",
      "image": "assets/images/products/powdered_milk.jpg",
      "price": "\$5.50",
    },
    {
      "title": "Mozzarella",
      "image": "assets/images/products/mozzarella.jpg",
      "price": "\$4.80",
    },
    {
      "title": "Parmesan",
      "image": "assets/images/products/parmesan.jpg",
      "price": "\$6.20",
    },
    {
      "title": "Cheddar",
      "image": "assets/images/products/cheddar.jpg",
      "price": "\$5.00",
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
            "Dairy Products",
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
