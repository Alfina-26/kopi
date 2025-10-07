import 'package:flutter/material.dart';
import 'model/produk.dart';
import 'keranjang_page.dart'; // supaya bisa ambil list keranjang

class PembayaranPage extends StatefulWidget {
  const PembayaranPage({super.key});

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _metodeController = TextEditingController();

  int _hitungTotal() {
    return keranjang.fold(0, (sum, item) {
      final angka =
          int.tryParse(item.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      return sum + angka;
    });
  }

  void _konfirmasiPembayaran() {
    if (_namaController.text.isEmpty ||
        _alamatController.text.isEmpty ||
        _metodeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lengkapi semua data pembayaran ⚠️")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Pembayaran berhasil! 🎉")),
    );

    // Kosongkan keranjang setelah pembayaran
    setState(() {
      keranjang.clear();
    });

    // Kembali ke halaman utama setelah beberapa detik
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.popUntil(context, (route) => route.isFirst);
    });
  }

  @override
  Widget build(BuildContext context) {
    final total = _hitungTotal();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pembayaran"),
        backgroundColor: const Color.fromARGB(255, 127, 76, 59),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ringkasan Pesanan",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // List produk yang dibeli
              ...keranjang.map((produk) => ListTile(
                    leading: Icon(produk.icon, color: Colors.brown),
                    title: Text(produk.name),
                    subtitle: Text(produk.price),
                  )),

              const Divider(height: 30),
              Text(
                "Total Pembayaran: Rp $total",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),

              const SizedBox(height: 30),
              const Text(
                "Data Pembeli",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: "Nama Lengkap",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _alamatController,
                decoration: const InputDecoration(
                  labelText: "Alamat Pengiriman",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _metodeController,
                decoration: const InputDecoration(
                  labelText: "Metode Pembayaran (contoh: Transfer, COD, DANA)",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 30),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _konfirmasiPembayaran,
                  icon: const Icon(Icons.check_circle),
                  label: const Text("Konfirmasi Pembayaran"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
