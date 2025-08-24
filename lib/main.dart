import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:shimmer/main.dart';
import 'package:trading_app/models/cart_manager.dart';
import 'app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartManager(),
      child: const TradingApp(),
    ),
    // const TradingApp(),
  );
}
