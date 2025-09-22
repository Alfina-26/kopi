class User {
  String _name;
  String _email;

  User(this._name, this._email);

  String get name => _name;
  set name(String value) => _name = value;

  String get email => _email;
  set email(String value) => _email = value;

  // Method yang bisa dioverride
  String getInfo() {
    return "Nama: $_name\nEmail: $_email";
  }
}

// Pewarisan (extend) dan override
class Customer extends User {
  String _address;

  Customer(String name, String email, this._address) : super(name, email);

  String get address => _address;
  set address(String value) => _address = value;

  @override
  String getInfo() {
    return "${super.getInfo()}\nAlamat: $_address";
  }
}