class Kontak {
  final int id;
  final String nama, telepon, email;

  Kontak(
      {required this.id,
        required this.nama,
        required this.telepon,
        required this.email});

  // mengubah data menjadi Map
  // untuk disimpan dalam database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'telepon': email,
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
