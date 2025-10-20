import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'struk_page.dart';

class PembayaranPage extends StatefulWidget {
  final Map<String, dynamic>? produk;
  final List<Map<String, dynamic>>? keranjang;

  const PembayaranPage({super.key, this.produk, this.keranjang});

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  String? _selectedMethod;
  final TextEditingController _nominalController = TextEditingController();
  double totalBayar = 0;
  double? kembalian;

  @override
  void initState() {
    super.initState();

    // Hitung total harga
    if (widget.produk != null) {
      totalBayar = (widget.produk!['price'] as num).toDouble();
    } else if (widget.keranjang != null) {
      totalBayar = widget.keranjang!
          .fold<double>(0.0, (sum, item) => sum + (item['price'] as num).toDouble());
    }
  }

  void _prosesPembayaran() {
    if (_selectedMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih metode pembayaran terlebih dahulu!')),
      );
      return;
    }

    if (_selectedMethod == 'Cash') {
      if (_nominalController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Masukkan nominal uang tunai!')),
        );
        return;
      }

      final nominal = double.tryParse(_nominalController.text) ?? 0;
      if (nominal < totalBayar) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nominal kurang dari total bayar!')),
        );
        return;
      }

      kembalian = nominal - totalBayar;
    }

    // Setelah proses pembayaran, tampilkan popup struk
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: StrukPage(
          totalBayar: totalBayar,
          metode: _selectedMethod!,
          nominal: _selectedMethod == 'Cash'
              ? double.tryParse(_nominalController.text) ?? totalBayar
              : totalBayar,
          kembalian: _selectedMethod == 'Cash' ? kembalian ?? 0 : 0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pembayaran"),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Total Pembayaran: Rp ${totalBayar.toStringAsFixed(0)}",
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown)),
            const SizedBox(height: 20),
            const Text("Pilih Metode Pembayaran:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.brown[50],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              value: _selectedMethod,
              hint: const Text("Pilih metode"),
              items: const [
                DropdownMenuItem(value: 'Cash', child: Text("Cash")),
                DropdownMenuItem(value: 'Debit', child: Text("Debit Card")),
                DropdownMenuItem(value: 'QRIS', child: Text("QRIS")),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedMethod = value;
                });
              },
            ),
            const SizedBox(height: 20),
            if (_selectedMethod == 'Cash')
              TextField(
                controller: _nominalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Masukkan nominal uang",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.money, color: Colors.brown),
                ),
              ),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: _prosesPembayaran,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.check_circle, color: Colors.white),
                label: const Text("Proses Pembayaran",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
