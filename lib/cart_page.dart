import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'pembayaran_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang Kamu"),
        backgroundColor: Colors.brown,
      ),
      body: cart.items.isEmpty
          ? const Center(child: Text("Keranjang masih kosong 😢"))
          : ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return ListTile(
                  leading: Icon(item.icon, color: Colors.brown),
                  title: Text(item.name),
                  subtitle: Text(item.desc),
                  trailing: Text(item.price),
                );
              },
            ),
      bottomNavigationBar: cart.items.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PembayaranPage()),
                  );
                },
                child: const Text("Lanjut ke Pembayaran 💳"),
              ),
            ),
    );
  }
}
