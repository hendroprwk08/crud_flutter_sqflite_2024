import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sqflite Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String nama, telepon, email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text('SQFLite'),
      ),
      body: ListView.builder(
          itemCount: 25,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                trailing: const Text(
                  "0000 0000 0000",
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
                title: Text("Nama ke-$index"));
          }),
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
                          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            telepon = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Telepon',
                          hintText: '000000000000',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: "email@provider.com",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      child: const Text('CANCEL'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    ElevatedButton(
                      child: const Text('OK'),
                      onPressed: () {
                        print(nama);
                        print(telepon);
                        print(email);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              });
        },
        tooltip: 'Tambah',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
