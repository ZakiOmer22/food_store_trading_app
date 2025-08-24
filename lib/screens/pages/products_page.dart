import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trading_app/routes.dart';
import 'package:trading_app/screens/pages/product_details.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  int _selectedIndex = 1; // highlight Products in bottom nav
  int _currentPage = 0;
  final int _itemsPerPage = 10;

  late List<Product> allProducts;
  final Set<String> likedProducts = {};

  final ScrollController _scrollController = ScrollController();
  bool _showPagination = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent / 3) {
        setState(() => _showPagination = true);
      } else {
        setState(() => _showPagination = false);
      }
    });

    allProducts = [
      Product(
        "Apples",
        "\$2.99/KG",
        "assets/images/products/apples.jpg",
        "Fresh and crispy apples.",
      ),
      Product(
        "Bananas",
        "\$1.00/KG",
        "assets/images/products/bananas.jpg",
        "Sweet ripe bananas.",
      ),
      Product(
        "Carrots",
        "\$1.20/KG",
        "assets/images/products/carrots.jpg",
        "Crunchy organic carrots.",
      ),
      Product(
        "Avocado",
        "\$2.50/KG",
        "assets/images/products/avocado.jpg",
        "Creamy Hass avocados.",
      ),
      Product(
        "Lemon",
        "\$0.75/KG",
        "assets/images/products/lemon.jpg",
        "Juicy yellow lemons.",
      ),
      Product(
        "Tomatoes",
        "\$1.90/KG",
        "assets/images/products/tomatoes.jpg",
        "Red ripe tomatoes.",
      ),
      Product(
        "Baguette",
        "\$2.50/pc",
        "assets/images/products/baguette.jpg",
        "Classic French bread.",
      ),
      Product(
        "Brioche",
        "\$3.50/pc",
        "assets/images/products/brioche.jpg",
        "Soft buttery brioche.",
      ),
      Product(
        "Candy",
        "\$1.10",
        "assets/images/products/candy.jpg",
        "Colorful sweet candy.",
      ),
      Product(
        "Chips",
        "\$2.00",
        "assets/images/products/chips.jpg",
        "Crispy potato chips.",
      ),
      Product(
        "Cookies",
        "\$2.80",
        "assets/images/products/cookies.jpg",
        "Homemade style cookies.",
      ),
      Product(
        "Cream",
        "\$1.90",
        "assets/images/products/cream.jpg",
        "Fresh dairy cream.",
      ),
      Product(
        "Croissant",
        "\$2.40",
        "assets/images/products/croissant.jpg",
        "Flaky butter croissant.",
      ),
      Product(
        "Donut",
        "\$1.50",
        "assets/images/products/donut.jpg",
        "Glazed sweet donut.",
      ),
      Product(
        "Ice Tea",
        "\$1.20",
        "assets/images/products/ice_tea.jpg",
        "Refreshing iced tea.",
      ),
      Product(
        "Lettuce",
        "\$1.80/KG",
        "assets/images/products/lettuce.jpg",
        "Crisp green lettuce.",
      ),
      Product(
        "Muffin",
        "\$2.70",
        "assets/images/products/muffin.jpg",
        "Soft baked muffin.",
      ),
      Product(
        "Oreo",
        "\$1.60",
        "assets/images/products/oreo.jpg",
        "Classic Oreo cookies.",
      ),
      Product(
        "Rice Premium",
        "\$15.00/Bag",
        "assets/images/products/rice_premium.jpg",
        "High quality rice.",
      ),
      Product(
        "Soda",
        "\$1.50",
        "assets/images/products/soda.jpg",
        "Chilled fizzy soda.",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final int totalPages = (allProducts.length / _itemsPerPage).ceil();
    final startIndex = _currentPage * _itemsPerPage;
    final endIndex = (_currentPage + 1) * _itemsPerPage;
    final List<Product> currentProducts = allProducts.sublist(
      startIndex,
      endIndex > allProducts.length ? allProducts.length : endIndex,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Products",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          _circleButton(FontAwesomeIcons.search),
          _circleButton(FontAwesomeIcons.bell, rightMargin: 8),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: GridView.builder(
                    controller: _scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.63,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: currentProducts.length,
                    itemBuilder: (context, index) {
                      final product = currentProducts[index];
                      final isLiked = likedProducts.contains(product.name);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailPage(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image + like
                              Expanded(
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                      child: Image.asset(
                                        product.image,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      right: 8,
                                      top: 8,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (isLiked) {
                                              likedProducts.remove(
                                                product.name,
                                              );
                                            } else {
                                              likedProducts.add(product.name);
                                            }
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                  0.1,
                                                ),
                                                blurRadius: 4,
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            isLiked
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: isLiked
                                                ? Colors.green
                                                : Colors.grey,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // name + desc
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                child: Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  product.description,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // price + add
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 6,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      product.price,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 60), // leave space for pagination
            ],
          ),
          if (_showPagination)
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(totalPages, (index) {
                  final isActive = index == _currentPage;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _currentPage = index);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isActive ? Colors.green : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          color: isActive ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() => _selectedIndex = index);
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
      ),
    );
  }

  Widget _circleButton(IconData icon, {double rightMargin = 0}) {
    return Container(
      margin: EdgeInsets.only(right: rightMargin, left: 6),
      decoration: const BoxDecoration(
        color: Colors.white24,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 19),
        onPressed: () {},
      ),
    );
  }
}

class Product {
  final String name;
  final String price;
  final String image;
  final String description;
  Product(this.name, this.price, this.image, this.description);
}
