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
      backgroundColor: const Color(0xFFF8F4EF), // warna cream lembut
      appBar: AppBar(
        title: const Text(
          "Keranjang Kamu",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF6F4E37), // cokelat kopi
        elevation: 4,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: cart.items.isEmpty
          ? const Center(
              child: Text(
                "Keranjang masih kosong 😢",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  color: Color(0xFF5D4037),
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.brown.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2E3D5),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.local_cafe_rounded,
                          color: Color(0xFF6F4E37), size: 28),
                    ),
                    title: Text(
                      item.name,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Color(0xFF4E342E),
                      ),
                    ),
                    subtitle: Text(
                      item.desc,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Color(0xFF795548),
                      ),
                    ),
                    trailing: Text(
                      item.price,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF8D6E63),
                      ),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: cart.items.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBF6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Total Harga
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Pembayaran:",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4E342E),
                        ),
                      ),
                      Text(
                        "Rp ${totalHarga.toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6F4E37),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Tombol Bayar
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6F4E37),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 6,
                      ),
                      onPressed: () {
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
                            builder: (context) =>
                                PembayaranPage(keranjang: keranjang),
                          ),
                        );
                      },
                      icon: const Icon(Icons.payment_rounded,
                          color: Colors.white),
                      label: const Text(
                        "Lanjut ke Pembayaran 💳",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
