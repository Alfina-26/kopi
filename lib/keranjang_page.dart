import 'package:flutter/material.dart';
import 'model/produk.dart';
import 'pembayaran_page.dart';

// List keranjang global (pastikan sama dengan yang di file lain)
List<Produk> keranjang = [];

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  void _hapusProduk(int index) {
    setState(() {
      keranjang.removeAt(index);
    });
  }

  int _hitungTotal() {
    return keranjang.fold(0, (sum, item) {
      final angka = int.tryParse(item.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      return sum + angka;
    });
  }

  @override
  Widget build(BuildContext context) {
    final total = _hitungTotal();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang Saya"),
        backgroundColor: const Color.fromARGB(255, 127, 76, 59),
      ),
      body: keranjang.isEmpty
          ? const Center(
              child: Text(
                "Keranjang masih kosong ☕",
                style: TextStyle(fontSize: 16),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: keranjang.length,
                      itemBuilder: (context, index) {
                        final item = keranjang[index];
                        return Card(
                          child: ListTile(
                            leading: Icon(item.icon, color: Colors.brown),
                            title: Text(item.name),
                            subtitle: Text(item.price),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _hapusProduk(index),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total:",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Rp $total",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Tombol lanjut pembayaran
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PembayaranPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Lanjut Pembayaran 💳",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
