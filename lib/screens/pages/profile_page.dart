import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trading_app/widgets/custom_bottom_navbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: AppBottomNav(currentIndex: 3, onTap: (index) {}),
      body: SafeArea(
        child: Stack(
          children: [
            // Top Green Background (#ebfbea)
            Container(
              height: 350,
              decoration: BoxDecoration(
                color: const Color(0xffebfbea),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),

            // Content
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Top buttons row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildTopCircleButton(Icons.arrow_back_ios_new),
                        const Text(
                          "Profile",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87, // text on light green
                          ),
                        ),
                        buildTopCircleButton(Icons.history),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Profile Picture (#00aca4 background)
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: const Color(0xff00aca4),
                    child: Icon(
                      FontAwesomeIcons.user,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Zaki Omer",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "zaki.omer@example.com",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),

                  const SizedBox(height: 30),

                  // Three buttons section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildActionButton(
                          FontAwesomeIcons.bell,
                          "Notifications",
                        ),
                        buildActionButton(FontAwesomeIcons.ticket, "Vouchers"),
                        buildActionButton(FontAwesomeIcons.clock, "History"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Menu options section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        buildMenuItem(FontAwesomeIcons.user, "Profile"),
                        buildMenuItem(
                          FontAwesomeIcons.addressCard,
                          "Address Management",
                        ),
                        buildMenuItem(
                          FontAwesomeIcons.creditCard,
                          "Payment Methods",
                        ),
                        buildMenuItem(FontAwesomeIcons.cog, "Account Settings"),
                        buildMenuItem(
                          FontAwesomeIcons.questionCircle,
                          "Help & Support",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ), // extra space to avoid bottom overflow
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTopCircleButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black12),
      ),
      child: Icon(icon, color: Colors.black87),
    );
  }

  Widget buildActionButton(IconData icon, String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 28,
              color: const Color(0xff00aca4),
            ), // changed green color
            const SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color(0xff00aca4),
        ), // changed green color
        title: Text(title, style: const TextStyle(fontSize: 16)),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.black45,
        ),
        onTap: () {},
      ),
    );
  }
}
