import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'pembayaran_page.dart';

class OrderPage extends StatefulWidget {
  final dynamic produk;

  const OrderPage({super.key, required this.produk});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  void _tambahKeKeranjang(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    cart.addToCart(widget.produk);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.produk.name} ditambahkan ke keranjang 🛒'),
        backgroundColor: Colors.brown,
      ),
    );
    Navigator.pop(context);
  }

  void _beliSekarang(BuildContext context) {
    final produk = {
      'name': widget.produk.name,
      'price': int.tryParse(
            widget.produk.price.replaceAll(RegExp(r'[^0-9]'), ''),
          ) ??
          0,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PembayaranPage(
          produk: produk,
          keranjang: [produk],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final produk = widget.produk;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(produk.icon, color: Colors.brown, size: 80),
            const SizedBox(height: 12),
            Text(
              produk.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(produk.desc, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text(
              'Harga: ${produk.price}',
              style: const TextStyle(fontSize: 18, color: Colors.brown),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => _tambahKeKeranjang(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
              label: const Text('Masukkan Keranjang',
                  style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => _beliSekarang(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              icon: const Icon(Icons.payment, color: Colors.white),
              label: const Text('Bayar Sekarang',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
