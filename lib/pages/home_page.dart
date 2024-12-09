import 'package:flutter/material.dart';
import '../model/kontak.dart';
import '../helper/database_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _databaseHelper = DatabaseHelper();
  List<Kontak> _kontakList = [];

  late int id;
  late String nama, alamat, telepon, email;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    List<Kontak> kontak = await _databaseHelper.getAll();
    setState(() {
      _kontakList = kontak;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text('SQFLite', style: TextStyle(color: Colors.white),),
      ),
      body: _kontakList.length == 0
          ? Center(
              child: Text('Kosong'),
            )
          : ListView.builder(
              itemCount: _kontakList.length,
              itemBuilder: (context, index) {
                Kontak kontak = _kontakList[index];

                return GestureDetector(
                  onLongPress: (){
                    // tampung kedalam variable
                    setState(() {
                      id = kontak.id!;
                      nama = kontak.nama;
                      telepon = kontak.telepon;
                      email = kontak.email;
                    });

                    showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            title: const Text('Detail Kontak'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  initialValue: nama,
                                  onChanged: (value) {
                                    setState(() {
                                      nama = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Nama',
                                    hintText: 'Nama Kontak',
                                    border: OutlineInputBorder(),
                                    contentPadding:
                                    EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  initialValue: telepon,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      telepon = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Telepon',
                                    hintText: '000000000000',
                                    border: OutlineInputBorder(),
                                    contentPadding:
                                    EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  initialValue: email,
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) {
                                    setState(() {
                                      email = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    hintText: "email@provider.com",
                                    border: OutlineInputBorder(),
                                    contentPadding:
                                    EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                child: const Text('Tutup'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ElevatedButton(
                                child: const Text('Perbarui'),
                                onPressed: () async {
                                  final Kontak model =
                                  Kontak(id: id, nama: nama, telepon: telepon, email: email);

                                  await _databaseHelper.update(model);
                                  _getData();

                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        }) ;
                  },
                  child: ListTile(
                    title: Text(kontak.nama),
                    subtitle: Text('${kontak.telepon} - ${kontak.email}'),
                    trailing: IconButton(
                        icon: Icon(Icons.block),
                        onPressed: () {
                          _databaseHelper.delete(kontak.id!);
                          _getData();
                        }),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //munculkan Dialog
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  title: const Text('Kontak'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            nama = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Nama',
                          hintText: 'Nama Kontak',
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            telepon = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Telepon',
                          hintText: '000000000000',
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: "email@provider.com",
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      child: const Text('Tutup'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Simpan'),
                      onPressed: () async {
                        final Kontak model =
                            Kontak(nama: nama, telepon: telepon, email: email);

                        await _databaseHelper.insert(model);
                        _getData();

                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              });
        },
        tooltip: 'Tambah',
        child: const Icon(Icons.add),
      ),
    );
  }
}
