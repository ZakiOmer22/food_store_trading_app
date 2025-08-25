// File: screens/auth/sign_in_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trading_app/routes.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailCtrl = TextEditingController(text: "Fahaduxlab@gmail.com");
  final _pwCtrl = TextEditingController(text: "password");
  bool _obscure = true;

  Color get _green => const Color(0xFF1EB980); // EcoEats green

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // ---------- Full patterned background ----------
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF1EB980),
                image: DecorationImage(
                  image: AssetImage("assets/images/pattern_bg.png"),
                  fit: BoxFit.cover,
                  opacity: 0.6,
                ),
              ),
            ),

            // ---------- Title & subtitle (on top of pattern) ----------
            Padding(
              padding: const EdgeInsets.fromLTRB(90, 60, 30, 0),
              child: Column(
                children: const [
                  Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Enter your email address and password to\n"
                    "access your account or create an account",
                    style: TextStyle(color: Colors.white70, height: 1.35),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // ---------- White rounded sheet (fills almost to footer) ----------
            Positioned.fill(
              top: 220, // push down so header text is visible
              bottom: 90, // leave space for footer
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.06),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 28, 18, 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Email field label + field
                      const _FieldLabel("Email address"),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _inputDecoration(
                          hint: "Fahaduxlab@gmail.com",
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Password field label + field
                      const _FieldLabel("Password"),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _pwCtrl,
                        obscureText: _obscure,
                        decoration: _inputDecoration(
                          hint: "••••••••",
                          suffix: IconButton(
                            onPressed: () =>
                                setState(() => _obscure = !_obscure),
                            icon: Icon(
                              _obscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),

                      // Sign in button
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.home);
                          },
                          child: const Text(
                            "Sign in",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Forgot password
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // Register option
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don’t have an account? ",
                            style: TextStyle(color: Colors.black87),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.register);
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                color: Color(0xFF1EB980),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Spacer(), // pushes socials to bottom
                      // Other sign in options
                      const Center(
                        child: Text(
                          "Other sign in options",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _socialCircle("assets/icons/facebook.svg"),
                          const SizedBox(width: 24),
                          _socialCircle("assets/icons/google.svg"),
                          const SizedBox(width: 24),
                          _socialCircle("assets/icons/apple.svg"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ---------- Brand footer (outside white sheet) ----------
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    _FooterLogo(path: 'assets/images/icon.png'),
                    SizedBox(width: 8),
                    Text(
                      'Powered by eALIF Team',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static InputDecoration _inputDecoration({String? hint, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE4E6EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFB7C9C2)),
      ),
      suffixIcon: suffix,
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }
}

Widget _socialCircle(String assetSvg) {
  return Container(
    width: 46,
    height: 46,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Color(0xFFE4E6EB)),
    ),
    padding: const EdgeInsets.all(10),
    child: SvgPicture.asset(assetSvg, fit: BoxFit.contain),
  );
}

class _FooterLogo extends StatelessWidget {
  final String path;
  const _FooterLogo({required this.path});
  @override
  Widget build(BuildContext context) {
    return Image.asset(path, width: 28, height: 28, fit: BoxFit.contain);
  }
}
