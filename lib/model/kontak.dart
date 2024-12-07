class Kontak {
  // kemungkinan tak memasukkan id
  // ketika input data baru
  late final int? id;
  final String nama, telepon, email;

  Kontak(
      {this.id,
        required this.nama,
        required this.telepon,
        required this.email});

  // mengubah data menjadi Map
  // untuk disimpan dalam database
  // tanpa id
  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'telepon': telepon,
      'email': email,
    };
  }

  // Constructor untuk membuat objek dari Map
  factory Kontak.fromMap(Map<String, dynamic> map) {
    return Kontak(
        id: map['id'],
        nama: map['nama'],
        telepon: map['telepon'],
        email: map['email']
    );
  }
}
