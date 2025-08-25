import 'package:flutter/material.dart';
import 'package:trading_app/screens/auth/register_page.dart';
import 'package:trading_app/screens/auth/sign_in_page.dart';
import 'package:trading_app/screens/onboarding/onboarding_page.dart';
import 'package:trading_app/screens/pages/cart_page.dart';
import 'package:trading_app/screens/pages/home/home_screen.dart';
import 'package:trading_app/screens/pages/products_page.dart';
import 'package:trading_app/screens/pages/profile_page.dart';
import 'screens/splash_screen.dart';

class Routes {
  // Route names
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String signIn = '/sign_in';
  static const String register = '/register';
  static const String home = '/home';
  static const String cart = '/cart';
  static const String profile = '/profile';
  static const String orders = '/orders';
  static const String products = '/products';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      onboarding: (context) => const OnboardingPage(),
      signIn: (context) => const SignInPage(),
      register: (context) => const RegisterPage(),
      home: (context) => const HomePage(),
      cart: (context) => const CartPage(),
      profile: (context) => const ProfilePage(),
      // orders: (context) => const OrdersPage(),
      products: (context) => ProductsPage(),
    };
  }
}
