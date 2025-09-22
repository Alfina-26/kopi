import 'produk.dart';

class MinumanSpesial extends Produk {
  bool _isSignature;

  MinumanSpesial(
      String name, String desc, String price, dynamic icon, this._isSignature)
      : super(name, desc, price, icon);

  bool get isSignature => _isSignature;
  set isSignature(bool value) => _isSignature = value;

  @override
  String getInfo() {
    return "${super.getInfo()}${_isSignature ? " [Signature]" : ""}";
  }

  // Tambahkan list minuman spesial (static agar bisa diakses tanpa objek)
  static List<MinumanSpesial> daftarMinumanSpesial = [
    MinumanSpesial("Signature Kopi Nusantara", "Blend kopi terbaik dari seluruh Indonesia.", "Rp 35.000", null, true),
    MinumanSpesial("Signature Cherry Latte", "Latte dengan sirup cherry khas.", "Rp 30.000", null, true),
    MinumanSpesial("Kopi Luwak", "Kopi eksklusif dari luwak.", "Rp 80.000", null, true),
  ];
}
