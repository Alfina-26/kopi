import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

Future<Uint8List> generateStrukPDF({
  required String metodePembayaran,
  required double totalHarga,
  required List<Map<String, dynamic>> items,
  double? nominalDibayar,
  double? kembalian,
}) async {
  final pdf = pw.Document();
  final date = DateFormat('dd MMMM yyyy, HH:mm').format(DateTime.now());

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.roll80,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Text("☕ Cherry Coffee",
                style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 5),
            pw.Text("Jl. Kenangan No. 26, Bali", style: const pw.TextStyle(fontSize: 10)),
            pw.Divider(),

            pw.Text("Struk Pembayaran",
                style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.Text(date, style: const pw.TextStyle(fontSize: 10)),
            pw.SizedBox(height: 10),

            // Daftar Item
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: items.map((item) {
                return pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(item['name'], style: const pw.TextStyle(fontSize: 12)),
                    pw.Text(item['price'], style: const pw.TextStyle(fontSize: 12)),
                  ],
                );
              }).toList(),
            ),

            pw.Divider(),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text("Total", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text("Rp ${totalHarga.toStringAsFixed(0)}"),
              ],
            ),
            pw.SizedBox(height: 5),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text("Metode"),
                pw.Text(metodePembayaran),
              ],
            ),
            if (nominalDibayar != null)
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Dibayar"),
                  pw.Text("Rp ${nominalDibayar.toStringAsFixed(0)}"),
                ],
              ),
            if (kembalian != null)
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Kembalian"),
                  pw.Text("Rp ${kembalian.toStringAsFixed(0)}"),
                ],
              ),

            pw.SizedBox(height: 10),
            pw.Text(
              "Terima kasih telah berbelanja di Cherry Coffee ☕",
              textAlign: pw.TextAlign.center,
              style: const pw.TextStyle(fontSize: 10),
            ),
          ],
        );
      },
    ),
  );

  return pdf.save();
}
