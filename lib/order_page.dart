import 'package:flutter/material.dart';
import 'model/user.dart';
import 'model/produk.dart';

// -------------------------
// List keranjang sementara (global)
// -------------------------
List<Produk> keranjang = [];

class Order {
  Customer customer;
  List<Produk> items;
  DateTime date;

  Order(this.customer, this.items, this.date);

  // Getter untuk total harga
  int get totalPrice {
    return items.fold(0, (sum, item) {
      final angka = int.tryParse(item.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      return sum + angka;
    });
  }

  String getOrderInfo() {
    return "Order by: ${customer.name}\nTotal: Rp $totalPrice\nTanggal: ${date.day}-${date.month}-${date.year}";
  }
}

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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Pesanan berhasil dikonfirmasi!")),
    );
  }

  void _tambahKeKeranjang() {
    setState(() {
      keranjang.add(widget.produk);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${widget.produk.name} ditambahkan ke keranjang!")),
    );
  }

  void _bukaKeranjang() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => KeranjangPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final order = Order(widget.customer, [widget.produk], orderDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Produk"),
        backgroundColor: const Color.fromARGB(255, 127, 76, 59),
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
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 222, 222, 222))),
                const SizedBox(height: 8),
                Text(widget.produk.desc, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                Text("Harga: ${widget.produk.price}",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown)),
                const Divider(height: 32),
                Text("Pemesan: Alfina Berlian"),
                Text("Email: Berlian@gmail.com"),
                Text("Alamat: Jl. Uhuy 29"),
                const SizedBox(height: 16),
                Text(
                  "Tanggal: ${orderDate.day}-${orderDate.month}-${orderDate.year}",
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),

                // -------------------------
                // Tombol aksi
                // -------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.shopping_bag),
                      label: const Text("Beli Sekarang"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _beliSekarang,
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text("Keranjang"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 169, 125, 93),
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
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

// -------------------------
// Halaman Keranjang Baru
// -------------------------
class KeranjangPage extends StatelessWidget {
  const KeranjangPage({super.key});

  @override
  Widget build(BuildContext context) {
    int total = keranjang.fold(0, (sum, item) {
      final angka = int.tryParse(item.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      return sum + angka;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang Saya"),
        backgroundColor: const Color.fromARGB(255, 127, 76, 59),
      ),
      body: keranjang.isEmpty
          ? const Center(child: Text("Keranjang masih kosong"))
          : ListView.builder(
              itemCount: keranjang.length,
              itemBuilder: (context, index) {
                final item = keranjang[index];
                return ListTile(
                  leading: Icon(item.icon, color: Colors.brown),
                  title: Text(item.name),
                  subtitle: Text(item.price),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      keranjang.removeAt(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${item.name} dihapus dari keranjang")),
                      );
                      (context as Element).markNeedsBuild();
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        color: Colors.brown.shade100,
        padding: const EdgeInsets.all(16),
        child: Text(
          "Total: Rp $total",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
