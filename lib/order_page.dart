import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/user.dart';
import 'model/produk.dart';
import 'providers/cart_provider.dart';
import 'cart_page.dart';
import 'pembayaran_page.dart';

class OrderPage extends StatefulWidget {
  final Customer customer;
  final Produk produk;

  const OrderPage({super.key, required this.customer, required this.produk});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late DateTime orderDate;

  @override
  void initState() {
    super.initState();
    orderDate = DateTime.now();
  }

  void _beliSekarang() {
  final cart = Provider.of<CartProvider>(context, listen: false);
  cart.addToCart(widget.produk);

  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const PembayaranPage()),
  );
}


  void _tambahKeKeranjang() {
    final cart = Provider.of<CartProvider>(context, listen: false);
    cart.addToCart(widget.produk);

    print("Produk ditambahkan: ${widget.produk.name}");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${widget.produk.name} ditambahkan ke keranjang 🛒")),
    );
  }

  void _bukaKeranjang() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CartPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Produk"),
        backgroundColor: Colors.brown,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: _bukaKeranjang,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.produk.icon, size: 60, color: Colors.brown),
                const SizedBox(height: 16),
                Text(widget.produk.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(widget.produk.desc, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                Text(
                  "Harga: ${widget.produk.price}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.shopping_bag),
                      label: const Text("Beli Sekarang"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                      onPressed: _beliSekarang,
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text("Keranjang"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 169, 125, 93)),
                      onPressed: _tambahKeKeranjang,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
