import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'cart_page.dart';
import 'homescreen_page.dart';
import 'splashscreen_page.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'dashboard_page.dart';
import 'produk_page.dart';
import 'pembayaran_page.dart';
import 'package:latihan1/tentang_page.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cherry Coffee',
      theme: ThemeData(primarySwatch: Colors.brown),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/homescreen': (context) => const HomeScreen(),
        '/dashboard': (context) => const DashboardPage(),
        '/produk': (context) => ProdukPage(),
        '/cart': (context) => const CartPage(),
        '/pembayaran': (context) => const PembayaranPage(),
        '/about': (context) => const TentangPage(),
      },
    );
  }
}
