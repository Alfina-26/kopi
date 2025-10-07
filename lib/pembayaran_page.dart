import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class PembayaranPage extends StatelessWidget {
  const PembayaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final totalHarga = cart.items.fold<double>(
      0,
      (sum, item) => sum + double.parse(item.price.replaceAll(RegExp(r'[^0-9]'), '')),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pembayaran"),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Detail Pembayaran",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
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
            ),
            const Divider(),
            Text(
              "Total: Rp ${totalHarga.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Pembayaran berhasil ✅")),
                  );
                  cart.clearCart();
                  Navigator.pop(context);
                },
                child: const Text("Bayar Sekarang"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
