class Produk {
  // 🔒 Atribut private (enkapsulasi)
  String _name;
  String _desc;
  String _price;
  dynamic _icon;

  // 🏗️ Constructor
  Produk(this._name, this._desc, this._price, this._icon);

  // ✅ Getter & Setter
  String get name => _name;
  set name(String value) => _name = value;

  String get desc => _desc;
  set desc(String value) => _desc = value;

  String get price => _price;
  set price(String value) => _price = value;

  dynamic get icon => _icon;
  set icon(dynamic value) => _icon = value;

  String getInfo() {
    return "$_name: $_desc (Harga: $_price)";
  }

  // 📋 List produk (static agar bisa diakses tanpa objek)
  static List<Produk> daftarProduk = [
    Produk("Espresso", "Kopi hitam pekat khas Italia.", "Rp 18.000", null),
    Produk("Latte", "Espresso dengan banyak susu.", "Rp 23.000", null),
    Produk("Americano", "Espresso dengan air panas.", "Rp 19.000", null),
    Produk("Cappuccino", "Espresso dengan susu dan foam.", "Rp 22.000", null),
    Produk("Mocha", "Espresso, coklat, dan susu.", "Rp 25.000", null),
    // Tambahkan produk lain sesuai kebutuhan
  ];
}
