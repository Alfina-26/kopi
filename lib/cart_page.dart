import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'pembayaran_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    // Hitung total harga dari item di keranjang
    double totalHarga = 0;
    for (var item in cart.items) {
      final harga = int.tryParse(
            item.price.replaceAll(RegExp(r'[^0-9]'), ''),
          ) ??
          0;
      totalHarga += harga;
    }

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
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading:
                        const Icon(Icons.local_cafe, color: Colors.brown),
                    title: Text(item.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold)),
                    subtitle: Text(item.desc),
                    trailing: Text(
                      item.price,
                      style: const TextStyle(color: Colors.brown),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: cart.items.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Menampilkan total harga
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Pembayaran:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Rp ${totalHarga.toStringAsFixed(0)}",
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.brown,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      // Ubah data produk ke bentuk Map untuk dikirim ke halaman pembayaran
                      final keranjang = cart.items.map((item) {
                        final harga = int.tryParse(
                              item.price
                                  .replaceAll(RegExp(r'[^0-9]'), ''),
                            ) ??
                            0;
                        return {
                          'name': item.name,
                          'price': harga,
                        };
                      }).toList();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PembayaranPage(
                            keranjang: keranjang,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.payment, color: Colors.white),
                    label: const Text(
                      "Lanjut ke Pembayaran 💳",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
