import 'package:flutter/material.dart';
import 'dart:async';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trading_app/routes.dart';
import 'package:trading_app/widgets/home/bakery_specials.dart';
import 'package:trading_app/widgets/home/dairy_products.dart';
import 'package:trading_app/widgets/home/fresh_produce.dart';
import 'package:trading_app/widgets/home/snacks_beverages.dart';
import 'package:trading_app/widgets/home/special_offers.dart';
import 'package:trading_app/widgets/home/summer_sale.dart';
import 'package:trading_app/widgets/home/weekly_deals.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 🔹 Available countries
  final List<String> countries = [
    "Baridhara, Dhaka",
    "Nairobi, Kenya",
    "Addis Ababa, Ethiopia",
    "Mogadishu, Somalia",
    "Cairo, Egypt",
  ];

  String selectedCountry = "Baridhara, Dhaka"; // default selected

  // 🔹 Banner data
  final List<Map<String, String>> banners = [
    {
      "text": "Get 40% discount\non your first order\nfrom app.",
      "cta": "Shop Now",
      "image": "assets/images/banners/fresh_produce.jpg",
    },
    {
      "text": "Weekly Deals!\nSave big on groceries.",
      "cta": "Explore",
      "image": "assets/images/banners/weekly_deals.jpg",
    },
    {
      "text": "Summer Sale 🌞\nCool drinks & snacks.",
      "cta": "Grab Now",
      "image": "assets/images/banners/summer_sale.jpg",
    },
  ];

  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  // 🔹 Track favorite products
  final Set<String> favorites = {};

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.95);

    // Auto carousel every 3 sec
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Green Top Section (Location + Search)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                decoration: const BoxDecoration(color: Colors.green),
                child: Column(
                  children: [
                    Text(
                      "Location       ",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // Top Row with icons + location
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          FontAwesomeIcons.bars,
                          color: Colors.white,
                          size: 18,
                        ),
                        Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.mapMarkerAlt,
                              color: Colors.white,
                              size: 18,
                            ),
                            const SizedBox(width: 20),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedCountry,
                                icon: const Icon(
                                  FontAwesomeIcons.chevronDown,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                dropdownColor: Colors.green,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                items: countries
                                    .map(
                                      (c) => DropdownMenuItem(
                                        value: c,
                                        child: Text(c),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) {
                                  setState(() => selectedCountry = val!);
                                },
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            FontAwesomeIcons.bell,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    // Search bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: "Search Your Groceries",
                          border: InputBorder.none,
                          icon: Icon(
                            FontAwesomeIcons.search,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // 🔹 Promo Banner (Auto Carousel)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 135,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: banners.length,
                    itemBuilder: (context, index) {
                      final banner = banners[index];
                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    banner["text"]!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    banner["cta"]!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(banner["image"]!, height: 80),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // 🔹 Categories
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: sectionTitle("Categories"),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 90,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  children: [
                    categoryItem(
                      "Veggies",
                      "assets/images/products/tomatoes.jpg",
                    ),
                    categoryItem(
                      "Fruits",
                      "assets/images/products/bananas.jpg",
                    ),
                    categoryItem("Meat", "assets/images/products/salmon.jpg"),
                    categoryItem("Dairy", "assets/images/products/milk.jpg"),
                    categoryItem("Bakery", "assets/images/products/bread.jpg"),
                    categoryItem("Snacks", "assets/images/products/chips.jpg"),
                    categoryItem("Drinks", "assets/images/products/water.jpg"),
                    categoryItem(
                      "Sauces",
                      "assets/images/products/ketchup.jpg",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // 🔹 Popular Products
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: sectionTitle("Popular"),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: productGrid(),
              ),
              const SizedBox(height: 20),
              // 🔹 New Arrivals
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: sectionTitle("New Arrivals"),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: productGrid(),
              ),
              const SizedBox(height: 20),
              // 🔹 Recommended
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: sectionTitle("Recommended"),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: productGrid(),
              ),
              const SizedBox(height: 20),
              // 🔹 Trending Products
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: sectionTitle("Trending Products"),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: productGrid(),
              ),
              const SizedBox(height: 20),
              // 🔹 Best Sellers
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: sectionTitle("Best Sellers"),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: productGrid(),
              ),
              const SizedBox(height: 20),
              // 🔹 Deals of the Day
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: sectionTitle("Deals of the Day"),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: productGrid(),
              ),
              const SizedBox(height: 20),

              // 🔹 New Sections (Custom Widgets)
              const SpecialOffers(),
              const SizedBox(height: 20),
              const WeeklyDeals(),
              const SizedBox(height: 20),
              const SummerSale(),
              const SizedBox(height: 20),
              const FreshProduce(),
              const SizedBox(height: 20),
              const DairyProducts(),
              const SizedBox(height: 20),
              const BakerySpecials(),
              const SizedBox(height: 20),
              // const MeatFish(),
              // const SizedBox(height: 20),
              const SnacksBeverages(),
              const SizedBox(height: 20),
              // const HealthyChoices(),
              // const SizedBox(height: 20),
              // const FamilyMeal(),
              // const SizedBox(height: 20),
              // const FamilyGaming(),
              // const SizedBox(height: 20),
              // const MovieNight(),
              // const SizedBox(height: 20),
              // const Essentials(),
              // const SizedBox(height: 20),
              // const BestSellers(),
              // const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      // 🔹 Bottom Nav Bar
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.home, size: 20),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.utensils, size: 20),
            label: "Products",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.shoppingCart, size: 20),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.receipt, size: 20),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 14,
              backgroundImage: AssetImage("assets/images/avatars/user1.png"),
            ),
            label: "Profile",
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, Routes.home);
              break;
            case 1:
              Navigator.pushNamed(context, Routes.products);
              break;
            case 2:
              Navigator.pushNamed(context, Routes.cart);
              break;
            case 3:
              Navigator.pushNamed(context, Routes.orders);
              break;
            case 4:
              Navigator.pushNamed(context, Routes.profile);
              break;
          }
        },
      ),
    );
  }

  // Section Title widget
  Widget sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  // Category Item widget
  static Widget categoryItem(String title, String imagePath) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.green[50],
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // Product Grid (reused)
  Widget productGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 0.75,
      children: [
        productCard(
          "Rice Premium",
          "assets/images/products/rice_premium.jpg",
          "\$25.00",
        ),
        productCard(
          "Olive Oil",
          "assets/images/products/olive_oil.jpg",
          "\$8.99",
        ),
        productCard(
          "Cornflakes",
          "assets/images/products/cornflakes.jpg",
          "\$4.50",
        ),
        productCard(
          "Chocolate",
          "assets/images/products/chocolate.jpg",
          "\$2.99",
        ),
      ],
    );
  }

  // Product Card with like button
  Widget productCard(String title, String imagePath, String price) {
    final isFavorite = favorites.contains(title);

    return Container(
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
                    favorites.remove(title);
                  } else {
                    favorites.add(title);
                  }
                });
              },
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.green : Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Center(child: Image.asset(imagePath, fit: BoxFit.cover)),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            price,
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
              child: const Icon(Icons.add, size: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
