// File: screens/onboarding/onboarding_page.dart
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _pages = [
    _OnboardingData(
      image: "assets/images/onboarding1.png",
      title: "Fast Shipment To Your Home!",
      subtitle:
          "Get your groceries quickly and easily,\nwith delivery right to your door.",
    ),
    _OnboardingData(
      image: "assets/images/onboarding2.png",
      title: "Fresh & Organic",
      subtitle: "We deliver only fresh and organic\nfruits and vegetables.",
    ),
    _OnboardingData(
      image: "assets/images/onboarding3.png",
      title: "Track Your Orders",
      subtitle: "Stay updated with live tracking\nand real-time notifications.",
    ),
    _OnboardingData(
      image: "assets/images/onboarding4.png",
      title: "Secure Payments",
      subtitle: "Pay with ease using multiple\nsecure payment options.",
    ),
    _OnboardingData(
      image: "assets/images/onboarding5.png",
      title: "Exclusive Discounts",
      subtitle: "Enjoy special deals and offers\nonly available in our app.",
    ),
    _OnboardingData(
      image: "assets/images/onboarding6.png",
      title: "Start Shopping Today!",
      subtitle: "Get everything you need,\ndelivered faster than ever.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFFDF7), // light mint background
      body: SafeArea(
        child: PageView.builder(
          controller: _controller,
          itemCount: _pages.length,
          onPageChanged: (index) => setState(() => _currentPage = index),
          itemBuilder: (context, index) {
            final data = _pages[index];
            return Stack(
              children: [
                // --- Main Image ---
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Image.asset(
                      data.image,
                      height: MediaQuery.of(context).size.height * 0.45,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // --- Bottom Curved White Container ---
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipPath(
                    clipper: _TopWaveClipper(),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: double.infinity,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 150, 24, 24),
                        child: Column(
                          children: [
                            Text(
                              data.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              data.subtitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                height: 1.4,
                              ),
                            ),
                            const Spacer(),

                            // --- Page Dots ---
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                _pages.length,
                                (i) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  height: 8,
                                  width: _currentPage == i ? 24 : 8,
                                  decoration: BoxDecoration(
                                    color: _currentPage == i
                                        ? const Color(0xFF1EB980)
                                        : Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 28),

                            // --- Button ---
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1EB980),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () {
                                  if (_currentPage == _pages.length - 1) {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      "/sign_in",
                                    );
                                  } else {
                                    _controller.nextPage(
                                      duration: const Duration(
                                        milliseconds: 400,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                child: Text(
                                  _currentPage == _pages.length - 1
                                      ? "Done"
                                      : "Next",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// --- Model for data ---
class _OnboardingData {
  final String image;
  final String title;
  final String subtitle;
  const _OnboardingData({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

// --- Custom Wave Clipper ---
class _TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 40);

    // left curve
    path.quadraticBezierTo(size.width * 0.25, 0, size.width * 0.5, 40);

    // right curve
    path.quadraticBezierTo(size.width * 0.75, 80, size.width, 40);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
