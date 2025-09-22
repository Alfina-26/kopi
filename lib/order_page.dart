import 'package:flutter/material.dart';
import 'model/user.dart';
import 'model/produk.dart';

class Order {
  Customer customer;
  List<Produk> items;
  DateTime date;

  Order(this.customer, this.items, this.date);

  // Getter untuk total harga
  int get totalPrice {
    return items.fold(0, (sum, item) {
      // Mengambil angka dari string harga, misal "Rp 18.000" -> 18000
      final angka = int.tryParse(item.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      return sum + angka;
    });
  }

  // Info pesanan
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

  @override
  Widget build(BuildContext context) {
    final order = Order(widget.customer, [widget.produk], orderDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Pesanan"),
        backgroundColor: const Color.fromARGB(255, 250, 247, 246),
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
                        color: Colors.brown)),
                const SizedBox(height: 8),
                Text(widget.produk.desc,
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                Text("Harga: ${widget.produk.price}",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown)),
                const Divider(height: 32),
                Text("Pemesan: ${widget.customer.name}"),
                Text("Email: ${widget.customer.email}"),
                Text("Alamat: ${widget.customer.address}"),
                const SizedBox(height: 16),
                Text(
                  "Tanggal Pesanan: ${orderDate.day}-${orderDate.month}-${orderDate.year}",
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text("Konfirmasi Pesanan"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Pesanan berhasil dikonfirmasi!"))
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}