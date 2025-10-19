import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'package:intl/intl.dart';

class PembayaranPage extends StatefulWidget {
  const PembayaranPage({super.key});

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  String? _selectedMethod;
  final TextEditingController _nominalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final int totalHarga = cart.totalHarga; // pastikan ini int
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pembayaran"),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Detail Pembayaran",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Daftar item di keranjang
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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

              const Divider(height: 30),

              Text(
                "Total: ${formatter.format(totalHarga)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                "Pilih Metode Pembayaran:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              _buildPaymentOption("Cash", Icons.attach_money),
              _buildPaymentOption("Debit", Icons.credit_card),
              _buildPaymentOption("QRIS", Icons.qr_code_2),

              const SizedBox(height: 20),

              if (_selectedMethod == "Cash" || _selectedMethod == "Debit")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedMethod == "Cash"
                          ? "Masukkan nominal pembayaran:"
                          : "Masukkan 4 digit terakhir kartu debit:",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _nominalController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: _selectedMethod == "Cash"
                            ? "Contoh: 50000"
                            : "Contoh: 1234",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 30),

              // Tombol Bayar Sekarang
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 6,
                  ),
                  icon: const Icon(Icons.receipt_long, color: Colors.white),
                  label: const Text(
                    "Bayar Sekarang",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onPressed: () {
                    if (_selectedMethod == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Pilih metode pembayaran terlebih dahulu ☕"),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                      return;
                    }

                    if ((_selectedMethod == "Cash" ||
                            _selectedMethod == "Debit") &&
                        _nominalController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Masukkan nominal pembayaran 💰"),
                          backgroundColor: Colors.orangeAccent,
                        ),
                      );
                      return;
                    }

                    // panggil fungsi tampilkan struk
                    _showStruk(context, totalHarga, formatter);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String method, IconData icon) {
    final isSelected = _selectedMethod == method;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = method;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.brown.shade100 : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.brown : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.brown, size: 28),
            const SizedBox(width: 12),
            Text(
              method,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.brown),
          ],
        ),
      ),
    );
  }

  void _showStruk(BuildContext context, int totalHarga, NumberFormat formatter) {
    final nominal = double.tryParse(_nominalController.text) ?? 0;
    double kembalian = 0;

    if (_selectedMethod == "Cash" && nominal >= totalHarga) {
      kembalian = nominal - totalHarga;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Struk Pembayaran"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Metode Pembayaran: $_selectedMethod"),
            Text("Total Pembelian: ${formatter.format(totalHarga)}"),
            if (_selectedMethod == "Cash")
              Text("Nominal Bayar: ${formatter.format(nominal)}"),
            if (_selectedMethod == "Cash")
              Text("Kembalian: ${formatter.format(kembalian)}"),
            if (_selectedMethod == "Debit")
              Text("Kartu: **** ${_nominalController.text}"),
            if (_selectedMethod == "QRIS")
              const Text("Pembayaran via QRIS berhasil ✅"),
            const SizedBox(height: 10),
            const Text(
              "Terima kasih telah berbelanja di Cherry Coffee ☕",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Provider.of<CartProvider>(context, listen: false).clearCart();
            },
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }
}
