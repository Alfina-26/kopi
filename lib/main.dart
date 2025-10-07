import 'package:flutter/material.dart';
import 'homescreen_page.dart';
import 'splashscreen_page.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'dashboard_page.dart';
import 'produk_page.dart';
import 'order_page.dart'; // Halaman detail produk (dengan tombol beli / keranjang)
  // Halaman keranjang baru

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cherry Coffee',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/homescreen': (context) => const HomeScreen(),
        '/dashboard': (context) => const DashboardPage(),
        '/produk': (context) => ProdukPage(),
        '/order': (context) => const Placeholder(), // nanti diganti jadi halaman order dinamis
        '/promo': (context) => const Placeholder(),
        '/about': (context) => const Placeholder(),
      },
    );
  }
}
