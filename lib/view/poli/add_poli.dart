import 'package:flutter/material.dart';
import 'package:jadwal_piket_dokter/view/poli/poli.dart';

import '../../controller/poli_controller.dart';
import '../../model/poli_model.dart';

class AddPoli extends StatefulWidget {
  const AddPoli({super.key});

  @override
  State<AddPoli> createState() => _AddPoliState();
}

class _AddPoliState extends State<AddPoli> {
  final formkey = GlobalKey<FormState>();
  var poliController = PoliController();

  String? poliname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Poli'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF000000),
              Color(0xFF1A237E),
              Color(0xFF673AB7),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Poli Name',
                    border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.white
                  ),
                  onChanged: (value) {
                    poliname = value;
                  },
                ),
                const SizedBox(height: 20),
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor: MaterialStateProperty.all(Colors.white)),
                    onPressed: () {
                      PoliModel pm = PoliModel(
                        poliname: poliname!,
                      );
                      poliController.addPoli(pm);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Poli Changed')));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Poli(),
                          ));
                    },
                    child: Text('Add'))
              ],
            ),
          ),
        ),
      )
    );
  }
}